`timescale 1ns / 1ps
`include "alu.v"

module ALU_tb;
	reg [6:0]opcode_reg;
    reg [2:0]funct3_reg;
    reg [6:0]funct7_reg;
    reg [31:0] srcA, srcB;
    wire [31:0] result;
    wire branch;
    //wire [3:0]ALUOp;

alu uut (opcode_reg,funct3_reg,funct7_reg,srcA,srcB,result,branch);//,ALUOp);
initial begin
	$dumpfile("alu_test.vcd");
	$dumpvars(0,ALU_tb);
    srcA=32'd5;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 3'b000;//R ADD
    #10
	srcA=32'd5;
    srcB=32'd7;
    opcode_reg = 7'b0010011;
    funct7_reg = 7'b0100000;
    funct3_reg=4'b000;//SUB
	#10
	srcA=32'd567;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0100000;
    funct3_reg = 4'b000;//SUBi
	#10
	srcA=32'd5;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 4'b110;//OR
	#10
	srcA=32'd5;
    srcB=32'd6;
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 4'b111;//AND
	#10
	srcA=32'h87654321;
    srcB=32'h08;//expected 00876543
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 4'b101;//SRL
	#10
	srcA=32'h87654321;
    srcB=32'h08; //expected 0xff876543
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0100000;
    funct3_reg = 4'b101;//SRA
	#10
	srcA=32'h12345678;
    srcB=32'h08;//expected 0x34567800
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 4'b001;//SLL
	#10
	srcA=32'h12345678;
    srcB=32'h0000ffff;//expected 0x00000000
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 4'b010;//SLT
	#10
	srcA=32'h12345678;
    srcB=32'h0000ffff;//expected 0x00000000
    opcode_reg = 7'b0110011;
    funct7_reg = 7'b0000000;
    funct3_reg = 4'b011;//SLTU
	#10
    srcA=32'h12345678;
    srcB=32'h0000ffff;//expected 0x00000000
    opcode_reg = 7'b1101111;//JAL;
    #10
    srcA=32'd8;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    funct3_reg = 4'b000;//beq  o/p -> not branch
	#10
    srcA=32'd87;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    funct3_reg = 4'b000;//beq  o/p -> branch
	#10
    srcA=32'd908;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    funct3_reg = 4'b100;//blt  o/p -> not branch
	#10
    srcA=32'd8;
    srcB=32'd87;
    opcode_reg = 7'b1100011;
    funct3_reg = 4'b100;//blt  o/p -> branch
	#10
	$display("test complete");
end

endmodule