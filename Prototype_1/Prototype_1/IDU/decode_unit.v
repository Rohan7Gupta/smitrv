module decode_unit(
    input clk,
    input reset,
    input Cond_Chk_reg, // determines PCSel_reg
    input [31:0] instruction,
    output reg [6:0] opcode_reg,
    output reg [4:0] rs1_reg,
    output reg [4:0] rs2_reg,
    output reg [4:0] rd_reg,
    output reg [2:0] funct3_reg,
    output reg [6:0] funct7_reg,
    output reg IorD_reg,
    output reg MemWrite_reg,
    output reg MtoR_reg,
    output reg IRWrite_reg,
    output reg [31:0] Imm_reg,
    output reg AluSrcA_reg,
    output reg [1:0] AluSrcB_reg,
    output reg RegWrite_reg,
    output reg Branch_reg,
    output reg PCWrite_reg,
    output reg PCSel_reg,
    output reg [2:0] AluControl_reg,
    output reg [2:0] stage
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        opcode_reg <= 0;
        rs1_reg <= 0;
        rs2_reg <= 0;
        rd_reg <= 0;
        funct3_reg <= 0;
        funct7_reg <= 0;
        IorD_reg <= 1'b0;
        MemWrite_reg <= 1'b0;
        MtoR_reg <= 1'b0;
        IRWrite_reg <= 1'b0;
        Imm_reg <= 0;
        AluSrcA_reg <= 1'b0;
        AluSrcB_reg <= 0;
        RegWrite_reg <= 1'b0;
        Branch_reg <= 1'b0;
        PCWrite_reg <= 1'b0;
        PCSel_reg <= 1'b0;
        AluControl_reg <= 0;
        stage <= 0;
    end 
    else begin
        case (stage)
            //  Fetching
            0: begin
                #10
                opcode_reg <= instruction[6:0];
                rs1_reg <= instruction[19:15];
                rs2_reg <= instruction[24:20];
                rd_reg <= instruction[11:7];
                funct3_reg <= instruction[14:12];
                funct7_reg <= instruction[31:25];
                IorD_reg <= 1'b0;
                MemWrite_reg <= 1'b0;
                MtoR_reg <= 1'b0;
                IRWrite_reg <= 1'b1;
                Imm_reg <= 0;
                AluSrcA_reg <= 1'b0;
                AluSrcB_reg <= 2'b01;
                RegWrite_reg <= 1'b0;
                Branch_reg <= 1'b0;
                PCWrite_reg <= 1'b0;
                PCSel_reg <= 1'b0;
                AluControl_reg <= 3'b000;
                case (opcode_reg)
                    7'b0110011: stage <= 1; //R-type(register)
                    7'b0000011: stage <= 1; //I-type(immediate load)
                    7'b1100111: stage <= 1; //I-type(immediate jump)
                    7'b0010011: stage <= 1; //I-type(immediate shift, logical, arithmetic)
                    7'b0100011: stage <= 1; //S-type(store)
                    7'b1100011: stage <= 1; //B-type(branch)
                    7'b1101111: stage <= 1; //J-type(jump)
                    7'b0110111: stage <= 1; //U-type(load upper immediate)
                    7'b0010111: stage <= 1; //U-type(add upper immediate)
                endcase
            end

            //  Decode
            1: begin
                #10
                case (opcode_reg)
                    //  I-type(jump), J-type
                    7'b1100111, 7'b1101111: begin
                    MtoR_reg <= 1'b0;
                    RegWrite_reg <= 1'b1;
                    end
                endcase
                stage <= 2;
            end

            //  Execution/MemAdr
            2: begin
                #10
                case (opcode_reg)
                    //  R-type instructions
                    7'b0110011: begin
                        AluSrcA_reg <= 1'b1;
                        AluSrcB_reg <= 2'b00;
                        if (funct7_reg == 7'b0000000) begin
                            case (funct3_reg)
                                3'b000: AluControl_reg <= 3'b000; //add
                                3'b001: AluControl_reg <= 3'b001; //sll
                                3'b010: AluControl_reg <= 3'b010; //slt (conditional)
                                3'b011: AluControl_reg <= 3'b011; //sltu (conditional)
                                3'b100: AluControl_reg <= 3'b100; //xor
                                3'b101: AluControl_reg <= 3'b101; //srl
                                3'b110: AluControl_reg <= 3'b110; //or
                                3'b111: AluControl_reg <= 3'b111; //and
                            endcase
                        end
                        else if (funct7_reg == 7'b0100000) begin
                            case (funct3_reg)
                                3'b000: AluControl_reg <= 3'b000; //sub
                                3'b101: AluControl_reg <= 3'b101; //sra
                            endcase
                        end
                    end
                    //  I-type instructions(load)
                    7'b0000011: begin
                        AluSrcA_reg <= 1'b1;
                        AluSrcB_reg <= 2'b10;
                        Imm_reg <= {{20{instruction[31]}}, instruction[31:20]};
                        case (funct3_reg)
                            3'b000: AluControl_reg <= 3'b000; //lb
                            3'b001: AluControl_reg <= 3'b001; //lh
                            3'b010: AluControl_reg <= 3'b010; //lw
                            3'b100: AluControl_reg <= 3'b100; //lbu
                            3'b101: AluControl_reg <= 3'b101; //lhu
                        endcase
                    end
                    //  I-type instructions(jump)
                    7'b1100111: begin
                        AluSrcA_reg <= 1'b1;
                        AluSrcB_reg <= 2'b10;
                        Imm_reg <= {{20{instruction[31]}}, instruction[31:20]};
                        case (funct3_reg)
                            3'b000: AluControl_reg <= 3'b000; //jalr
                        endcase
                    end
                    //  I-type instructions(shift, logical, arithmetic)
                    7'b0010011: begin
                        AluSrcA_reg <= 1'b1;
                        AluSrcB_reg <= 2'b10;
                        case (funct3_reg)
                            3'b001, 3'b101: begin // slli, srli, srai
                                Imm_reg = {12'b0, instruction[31:20]}; // shift amount immediate
                            end
                            3'b000, 3'b010, 3'b011, 3'b100, 3'b111: begin // addi, slti, sltiu, xori, ori, andi
                                Imm_reg <= {{20{instruction[31]}}, instruction[31:20]};
                            end
                        endcase
                        case (funct3_reg)
                            3'b000: AluControl_reg <= 3'b000; //addi
                            3'b010: AluControl_reg <= 3'b010; //slti (conditional)
                            3'b011: AluControl_reg <= 3'b011; //sltiu (conditional)
                            3'b100: AluControl_reg <= 3'b100; //xori
                            3'b110: AluControl_reg <= 3'b110; //ori
                            3'b111: AluControl_reg <= 3'b111; //andi
                            3'b001: AluControl_reg <= 3'b001; //slli
                            3'b101: AluControl_reg <= 3'b101; //srli or srai
                        endcase
                    end
                    //  S-type instructions
                    7'b0100011: begin
                        AluSrcA_reg <= 1'b1;
                        AluSrcB_reg <= 2'b10;
                        Imm_reg <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
                        case (funct3_reg)
                            3'b000: AluControl_reg <= 3'b000; //sb
                            3'b001: AluControl_reg <= 3'b001; //sh
                            3'b010: AluControl_reg <= 3'b010; //sw
                        endcase
                    end
                    //  B-type instructions
                    7'b1100011: begin
                        AluSrcA_reg <= 1'b1;
                        AluSrcB_reg <= 2'b00;
                        Branch_reg <= 1'b1;
                        Imm_reg <= {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
                        case (funct3_reg)
                            3'b000: AluControl_reg <= 3'b000; //beq (conditional)
                            3'b001: AluControl_reg <= 3'b001; //bne (conditional)
                            3'b100: AluControl_reg <= 3'b100; //blt (conditional)
                            3'b101: AluControl_reg <= 3'b101; //bge (conditional)
                            3'b110: AluControl_reg <= 3'b110; //bltu (conditional)
                            3'b111: AluControl_reg <= 3'b111; //bgeu (conditional)
                        endcase
                    end
                    //  J-type instructions
                    7'b1100011: begin
                        AluSrcA_reg <= 1'b0;
                        AluSrcB_reg <= 2'b10;
                        Imm_reg <= {{12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21]}; //jal
                    end
                    //  U-type (load upper immediate)
                    7'b0110111: begin
                        Imm_reg = {instruction[31:20], 12'b0};
                    end
                    //  U-type (add upper immediate)
                    7'b0010111: begin
                        AluSrcA_reg <= 1'b0;
                        AluSrcB_reg <= 2'b10;
                        Imm_reg = {instruction[31:20], 12'b0};
                    end
                endcase
                stage <= 3;
            end

            //  MemRead
            3: begin
                #10
                case (opcode_reg)
                    //  J-type, I-type instructions(jump)
                    7'b1100111, 7'b1101111: begin
                        PCWrite_reg <= 1'b1;
                        PCSel_reg <= 1'b1;
                    end
                    //  B-type instructions
                    7'b1100011: begin
                        if (Cond_Chk_reg) begin // if ALU response is true, enable PCSel_reg
                            PCSel_reg <= 1'b1;
                        end
                    end
                endcase
                stage <= 4;
            end

            //  Writeback
            4: begin
                #10
                case (opcode_reg)
                    //  R-type instructions
                    7'b0110011: begin
                        MtoR_reg <= 1'b0;
                        RegWrite_reg <= 1'b1;
                    end
                    //  I-type instructions(load, shift, logical, arithmetic)
                    7'b0000011, 7'b0010011: begin
                        MtoR_reg <= 1'b1;
                        RegWrite_reg <= 1'b1;
                    end
                    //  S-type instructions
                    7'b0100011: begin
                        MemWrite_reg <= 1'b1;
                        IorD_reg <= 1'b1;
                    end
                    //  U-type instructions(lui)
                    7'b0110111: begin
                        MtoR_reg <= 1'b1;
                        RegWrite_reg <= 1'b1;
                    end
                    //  U-type instructions(auipc)
                    7'b0010111: begin
                        PCWrite_reg <= 1'b1;
                        PCSel_reg <= 1'b1;
                    end 
                endcase
                stage <= 0;
            end
        endcase
    end
end
endmodule
