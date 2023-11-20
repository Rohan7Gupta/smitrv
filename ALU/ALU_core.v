`timescale 1ns / 1ps
`include "defines.v"


module ALU_core(
	input wire [31:0] SrcA, SrcB,
	input wire [3:0]  ALUOp,
	output reg  [31:0] ALUResult,
	output wire carryf, zerof, overFlowf, signf
    );
wire [31:0] addTemp, compSrcB;
assign compSrcB = (~SrcB);       
assign {carryf, addTemp} = ALUOp[0] ? (SrcA + compSrcB + 1'b1) : (SrcA + SrcB); 
assign zerof = (addTemp == 0);
assign signf = addTemp[31];
assign overFlowf = (SrcA[31] ^ (compSrcB[31]) ^ addTemp[31] ^ carryf);

always @(*) 
begin
    case (ALUOp)
        
        `ADD : ALUReslt = addTemp; 
        `SUB : ALUReslt = addTemp; 
        `PASS: ALUReslt = SrcB;
        
        `OR:  ALUReslt = SrcA | SrcB;
        `AND:  ALUReslt = SrcA & SrcB;
        `XOR:  ALUReslt = SrcA ^ SrcB;
        
        `SRL:  ALUReslt=(SrcA >> SrcB); 
        `SRA:  ALUReslt=(SrcA >>> SrcB);
        `SLL:  ALUReslt=(SrcA << SrcB);
        
        `SLT:  ALUReslt = {31'b0,(signFlag != overFlowFlag)}; 
        `SLTU: ALUReslt = {31'b0,(~carryFlag)};      
        default: ALUReslt = 32'b0;         
    endcase
end
endmodule