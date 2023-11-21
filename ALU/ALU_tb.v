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
	// srca=32'd5;
    // srcb=32'd6;
    // op=4'b0001;//SUB
	// #10
	// srca=32'd5;
    // srcb=32'd5;
    // op=4'b0001;//SUB
	// #10
	// srca=32'd5;
    // srcb=32'd6;
    // op=4'b0100;//OR
	// #10
	// srca=32'd5;
    // srcb=32'd6;
    // op=4'b0101;//AND
	// #10
	// srca=32'h87654321;
    // srcb=32'h08;//expected 00876543
    // op=4'b1000;//SRL
	// #10
	// srca=32'h87654321;
    // srcb=32'h08; //expected 0xff876543
    // op=4'b1010;//SRA
	// #10
	// srca=32'h12345678;
    // srcb=32'h08;//expected 0x34567800
    // op=4'b1001;//SLL
	// #10
	// srca=32'h12345678;
    // srcb=32'h0000ffff;//expected 0x00000000
    // op=4'b1101;//SLT
	// #10
	// srca=32'h12345678;
    // srcb=32'h0000ffff;//expected 0x00000000
    // op=4'b1111;//SLTU
	// #10
	$display("test complete");
end

endmodule