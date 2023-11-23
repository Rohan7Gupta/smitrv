`timescale 1ns / 1ps
module MUX32_2_1_behav(
    input wire[31:0]ALU_out,//from ALU_out reg
    input wire[31:0]imm_reg,//program counter
    input wire PCSrc,
    output reg wd2
    );
always @(*)
begin
case(PCSrc)
1'b0: wd2=ALU_out;
1'b1: wd2=imm_reg;
endcase
end
endmodule