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
        
        `ADD : ALUResult = addTemp; 
        `SUB : ALUResult = addTemp; 
        `PASS: ALUResult = SrcB;
        
        `OR:  ALUResult = SrcA | SrcB;
        `AND:  ALUResult = SrcA & SrcB;
        `XOR:  ALUResult = SrcA ^ SrcB;
        
        `SRL:  ALUResult=(SrcA >> SrcB); 
        `SRA:  ALUResult=(SrcA >>> SrcB);
        `SLL:  ALUResult=(SrcA << SrcB);
        
        `SLT:  ALUResult = {31'b0,(signf != overFlowf)}; 
        `SLTU: ALUResult = {31'b0,(~carryf)};      
        default: ALUResult = 32'b0;         
    endcase
end
endmodule