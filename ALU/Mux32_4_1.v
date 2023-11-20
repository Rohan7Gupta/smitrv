`timescale 1ns / 1ps
module MUX32_4_1_behav(
    input wire[31:0]rs2,//from rs2 reg
    input wire[31:0]imm_reg,
    input wire[1:0]AluSrcB_reg,
    output reg SrcB
    );
always @(*)
begin
case(AluSrcB_reg)
2'b00: SrcB=rs2;
2'b01: SrcB=32'd4;
2'b10: SrcB=imm_reg;
2'b11: SrcB=rs2;//case not needed
endcase
end
endmodule