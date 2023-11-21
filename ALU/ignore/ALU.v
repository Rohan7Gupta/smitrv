`timescale 1ns/1ps
`include "defines.v"
`include "ALU_core.v"
`include "branch_control.v"
module ALU(
    input wire [6:0]opcode_reg,
    input wire [2:0]funct3_reg,
    input wire [6:0]funct7_reg,
    input wire [31:0] SrcA, SrcB,
    output reg  [31:0] ALUResult,
    output reg branch
//    output wire [3:0]ALUOp
);
wire [3:0]ALUOp;
wire cf, zf, of, sf;
//ALU_core core();
//branch_control br();
ALU_core core_inst(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUOp(ALUOp),
    .ALUResult(ALUResult),
    .carryf(cf),
    .zerof(zf),
    .overFlowf(of),
    .signf(sf)
);

branch_control br_inst(
    .opcode_reg(opcode_reg),
    .funct3_reg(funct3_reg),
    .cf(cf),
    .zf(zf),
    .of(of),
    .sf(sf),
    .branch(branch)
);
always @(*)
begin
    case (opcode_reg)
        //  R-type instructions
        7'b0110011: begin
            if (funct7_reg == 7'b0000000) begin
                case (funct3_reg)
                    3'b000: ALUOp = `ADD; //add
                    3'b001: ALUOp = `SLL; //sll
                    3'b010: ALUOp = `SLT; //slt
                    3'b011: ALUOp = `SLTU; //sltu
                    3'b100: ALUOp = `XOR; //xor
                    3'b101: ALUOp = `SRL; //srl
                    3'b110: ALUOp = `OR; //or
                    3'b111: ALUOp = `AND; //and
                endcase
            end
            else if (funct7_reg == 7'b0100000) begin
                case (funct3_reg)
                    3'b000: ALUOp = `SUB; //sub
                    3'b101: ALUOp = `SRA; //sra
                endcase
            end
        end
        //  I-type instructions(load)
        7'b0000011: ALUOp = `ADD;//lb,lh,lw,lbu,lhu
        //  I-type instructions(jump)
        7'b1100111: ALUOp=`ADD;//jalr srcA=rs1

        //  I-type instructions(shift, logical, arithmetic)
        7'b0010011:
        begin
            if (funct7_reg == 7'b0000000) begin
                case (funct3_reg)
                    3'b000: ALUOp = `ADD; //addi
                    3'b001: ALUOp = `SLL; //slli
                    3'b010: ALUOp = `SLT; //slti
                    3'b011: ALUOp = `SLTU; //sltui
                    3'b100: ALUOp = `XOR; //xori
                    3'b101: ALUOp = `SRL; //srli
                    3'b110: ALUOp = `OR; //ori
                    3'b111: ALUOp = `AND; //andi
                endcase
            end
            else if (funct7_reg == 7'b0100000) begin
                case (funct3_reg)
                    3'b000: ALUOp = `SUB; //subi
                    3'b101: ALUOp = `SRA; //srai
                endcase
            end
        end
        //  S-type instructions
        7'b0100011: ALUOp=`ADD;//sb,sh,sw
   
        //B-type instructions
        7'b1100011: ALUOp=`SUB;//beq,bge,bgeu,blt,bltu,bne
        //  J-type instructions
        7'b1101111: ALUOp=`ADD;//jal srcA=pc
        //  U-type (load upper immediate)
        7'b0110111: ALUOp=`PASS;
        //  U-type (add upper immediate)
        7'b0010111: ALUOp=`ADD;
        default: ALUOp=`NOP;
    endcase
    //note -> need to add logic for pc=pc+4 if needed

//end
    // ALU_core core(SrcA[31:0], SrcB[31:0], ALUOp[3:0], ALUResult[31:0], cf, zf, of, sf);
    // if (opcode_reg == 7'b1100011 || opcode_reg==7'b1100111 || opcode_reg== 7'b1101111) begin
    //     branch_control br(opcode_reg[6:0],funct3_reg[2:0],cf,zf,of,sf,branch);
    // end

case(opcode_reg)
    7'b1100011,7'b1100111,7'b1101111: begin
        core(SrcA[31:0], SrcB[31:0], ALUOp[3:0], ALUResult[31:0], cf, zf, of, sf);
        br(opcode_reg[6:0],funct3_reg[2:0],cf,zf,of,sf,branch);
        //core_inst();
        //br_inst();
    end
    default: core(SrcA[31:0], SrcB[31:0], ALUOp[3:0], ALUResult[31:0], cf, zf, of, sf);
            //core_inst();
endcase
end
endmodule