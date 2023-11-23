`timescale 1ns / 1ps
module MUX32_2_1_behav(
    input wire[31:0]rs1,//from rs1 reg
    input wire[31:0]pc,//program counter
    input wire AluSrcA_reg,
    output reg SrcA
    );
always @(*)
begin
case(AluSrcA_reg)
1'b0: SrcA=rs1;
1'b1: SrcA=pc;
endcase
end
endmodule