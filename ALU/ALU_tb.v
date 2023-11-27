`timescale 1ns / 1ps
`include "alu.v"

module ALU_tb;
	reg [6:0]opcode_reg;
    reg [31:0] srcA, srcB;
    reg [3:0] ALUControl_reg;
    wire [31:0] result;
    wire Cond_Chk;
    //wire [3:0]ALUOp;

//alu uut (opcode_reg,ALUControl_reg,srcA,srcB,result,Cond_Chk);//,ALUOp);
    alu uut (
        .opcode_reg(opcode_reg),
        .ALUControl_reg(ALUControl_reg),
        .SrcA(srcA),
        .SrcB(srcB),
        .ALUResult(result),
        .Cond_Chk(Cond_Chk)
     );

    initial begin
	$dumpfile("alu_test.vcd");
	$dumpvars(0,ALU_tb);
    srcA=32'd5;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0000;//R ADD
    #10
	srcA=32'd5;
    srcB=32'd7;
    opcode_reg = 7'b0010011;
    ALUControl_reg = 4'b1000;//SUB
	#10
	srcA=32'd567;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b1000;//SUBi
	#10
	srcA=32'd5;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0110;//OR
	#10
	srcA=32'd5;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0111;//AND
	#10
	srcA=32'h87654321;
    srcB=32'h08;//expected 00876543
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0101;//SRL
	#10
	srcA=32'h87654321;
    srcB=32'h08; //expected 0xff876543
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b1101;//SRA
	#10
	srcA=32'h12345678;
    srcB=32'h08;//expected 0x34567800
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0001;//SLL
	#10
	srcA=32'h12345678;
    srcB=32'h0000ffff;//expected 0x00000000
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0010;//SLT
	#10
	srcA=32'h12345678;
    srcB=32'h0000ffff;//expected 0x00000000
    opcode_reg = 7'b0110011;
    ALUControl_reg = 4'b0011;//SLTU
	#10
    srcA=32'h12345678;
    srcB=32'h0000ffff;//expected 0x00000000
    opcode_reg = 7'b1101111;//JAL;
    #10
    srcA=32'd8;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    ALUControl_reg = 4'b1000;//beq  o/p -> not Cond_Chk
	#10
    srcA=32'd87;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    ALUControl_reg = 4'b1000;//beq  o/p -> Cond_Chk
	#10
    srcA=32'd908;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    ALUControl_reg = 4'b1100;//blt  o/p -> not Cond_Chk
	#10
    srcA=32'd8;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    ALUControl_reg = 4'b1100;//blt  o/p -> Cond_Chk
	#10
	$display("test complete");
end

endmodule