`timescale 1ns / 1ps

module fetch_test;
    reg clk_tb,
    reg reset_tb,
    reg PCSel_tb,
    reg [31:0] Imm_tb,
    //reg [31:0] ALU_result_tb,
    wire [31:0] pc_tb
    
fetch_unit f0(
    clk(clk_tb),
    reset(reset_tb),
    PCSel_reg(PCSel_tb),
    Imm_reg(Imm_tb),
    //ALU_result_reg(ALU_result_tb),
    pc_reg(pc_tb)
);
  
initial begin
clk_tb <=0;
reset_tb <= 1;
#10 
reset_tb <= 0;
end

always 
begin
    #10 clk_tb = ~clk_tb;
end

always @(posedge clk_tb) begin
    pc_tb = 32'h00000007;
    PCSel_tb = 1'b1;
    Imm_tb = 32'h00000002;

    #10
    PCSel_tb = 1'b0;
    Imm_tb = 32'h00000005;
      
#100
$finish;
end
endmodule
