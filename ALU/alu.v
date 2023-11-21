`timescale 1ns/1ps

module alu(
    input wire [6:0]opcode_reg,
    input wire [2:0]funct3_reg,
    input wire [6:0]funct7_reg,
    input wire [31:0] SrcA, SrcB,
    output  reg [31:0] ALUResult,
    output reg branch
);

wire cf, zf, of, sf;
wire [31:0] addTemp, compSrcB;
assign compSrcB = (~SrcB);       
assign {cf, addTemp} = funct7_reg[5] ? (SrcA + compSrcB + 1'b1) : (SrcA + SrcB); 
assign zf = (addTemp == 0);
assign sf = addTemp[31];
assign of = (SrcA[31] ^ (compSrcB[31]) ^ addTemp[31] ^ cf);

reg cfb, zfb, ofb, sfb;
reg [31:0] addTempb, compSrcBb;

always @(*)
begin
    case (opcode_reg)
        //  R-type instructions
        7'b0110011: begin
            if (funct7_reg == 7'b0000000) begin
                case (funct3_reg)
                    3'b000:  ALUResult = addTemp; //add
                    3'b001:  ALUResult=(SrcA << SrcB); //sll
                    3'b010:  ALUResult = {31'b0,(sf != of)}; //slt
                    3'b011:  ALUResult = {31'b0,(~cf)}; //sltu
                    3'b100:  ALUResult = SrcA ^ SrcB; //xor
                    3'b101:  ALUResult=(SrcA >> SrcB); //srl
                    3'b110:  ALUResult = SrcA | SrcB; //or
                    3'b111:  ALUResult = SrcA & SrcB; //and
                endcase
            end
            else if (funct7_reg == 7'b0100000) begin
                case (funct3_reg)
                    3'b000: ALUResult = addTemp; //sub
                    3'b101: ALUResult=(SrcA >>> SrcB); //sra 
                endcase
            end
            branch = 1'b0;
        end
        //  I-type instructions(load)
        7'b0000011: begin
                compSrcBb = (~SrcB);       
                {cfb, addTempb} = SrcA + SrcB; 
                ALUResult = addTempb;
                branch = 1'b0;
        end//lb,lh,lw,lbu,lhu
        //  I-type instructions(jump)
        7'b1100111: begin
                    {cfb, addTempb} = SrcA + SrcB; 
                    ALUResult = addTempb;
                    branch=1'b1;
        end//jalr srcA=rs1

        //  I-type instructions(shift, logical, arithmetic)
        7'b0010011:
        begin
            if (funct7_reg == 7'b0000000) begin
                case (funct3_reg)
                    3'b000:  ALUResult = addTemp; //add
                    3'b001:  ALUResult=(SrcA << SrcB); //sll
                    3'b010:  ALUResult = {31'b0,(sf != of)}; //slt
                    3'b011:  ALUResult = {31'b0,(~cf)}; //sltu
                    3'b100:  ALUResult = SrcA ^ SrcB; //xor
                    3'b101:  ALUResult=(SrcA >> SrcB); //srl
                    3'b110:  ALUResult = SrcA | SrcB; //or
                    3'b111:  ALUResult = SrcA & SrcB; //and
                endcase
            end
            else if (funct7_reg == 7'b0100000) begin
                case (funct3_reg)
                    3'b000: ALUResult = addTemp; //sub
                    3'b101: ALUResult=(SrcA >>> SrcB); //sra
                endcase
            end
            branch = 1'b0;
        end
        //  S-type instructions
        7'b0100011: begin
            {cfb, addTempb} = SrcA + SrcB; 
            ALUResult = addTempb;
            branch = 1'b0;
        end//sb,sh,sw
   
        //B-type instructions
        7'b1100011: begin
            compSrcBb = (~SrcB);       
             {cfb, addTempb} = SrcA + compSrcBb + 1'b1; 
             zfb = (addTempb == 0);
             sfb = addTempb[31];
             ofb = (SrcA[31] ^ (compSrcBb[31]) ^ addTempb[31] ^ cfb);
            ALUResult=addTemp;                    
                    case (funct3_reg) 
                        3'b000: branch = zfb;  //beq      
                        3'b001: branch = ~zfb;      //bne  
                        3'b100: branch = (sfb!=ofb);      //blt    
                        3'b101: branch = (sfb==ofb);        ///bge
                        3'b110:branch = ~cfb;         //bltu
                        3'b111:branch = cfb;   //bgeu
                        default: branch = 1'b0;    
                    endcase
                    end//beq,bge,bgeu,blt,bltu,bne
        //  J-type instructions
        7'b1101111: begin 
                    {cfb, addTempb} = SrcA + SrcB; 
                    ALUResult = addTempb;;
                    branch=1'b1;
        end//jal srcA=pc
        //  U-type (load upper immediate)
        7'b0110111: begin
                ALUResult = SrcB;
                branch = 1'b0;
        end
        //  U-type (add upper immediate)
        7'b0010111: begin 
                {cfb, addTempb} = SrcA + SrcB; 
                ALUResult = addTempb;
                branch = 1'b0;
        end
        //default: ALUOp=`NOP;
    endcase
    //note -> need to add logic for pc=pc+4 if needed

end
endmodule