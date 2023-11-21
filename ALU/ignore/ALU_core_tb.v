//alu_core_test
`timescale 1ns / 1ps
`include "ALU_core.v"


module ALU_core_tb;
	reg [31:0] srca, srcb;
	reg [3:0]  op;
	wire  [31:0] result;
	wire cf, zf, of, sf;

ALU_core uut (srca,srcb,op,result,cf,zf,of,sf);
initial begin
	$dumpfile("alu_core_test.vcd");
	$dumpvars(0,ALU_core_tb);
    srca=32'd5;
    srcb=32'd6;
    op=4'b0000;//ADD
    #10
	srca=32'd5;
    srcb=32'd6;
    op=4'b0001;//SUB
	#10
	srca=32'd5;
    srcb=32'd5;
    op=4'b0001;//SUB
	#10
	srca=32'd5;
    srcb=32'd6;
    op=4'b0100;//OR
	#10
	srca=32'd5;
    srcb=32'd6;
    op=4'b0101;//AND
	#10
	srca=32'h87654321;
    srcb=32'h08;//expected 00876543
    op=4'b1000;//SRL
	#10
	srca=32'h87654321;
    srcb=32'h08; //expected 0xff876543
    op=4'b1010;//SRA
	#10
	srca=32'h12345678;
    srcb=32'h08;//expected 0x34567800
    op=4'b1001;//SLL
	#10
	srca=32'h12345678;
    srcb=32'h0000ffff;//expected 0x00000000
    op=4'b1101;//SLT
	#10
	srca=32'h12345678;
    srcb=32'h0000ffff;//expected 0x00000000
    op=4'b1111;//SLTU
	#10
	$display("test complete");
end

endmodule