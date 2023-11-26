`timescale 1ns / 1ps

module decode_test;
    reg clk_tb;
    reg reset_tb;
    reg Cond_Chk_tb;
    reg [31:0] instruction_tb;
    wire [6:0] opcode_tb;
    wire [2:0] funct3_tb;
    wire [6:0] funct7_tb;
    wire [4:0] rs1_tb;
    wire [4:0] rs2_tb;
    wire [4:0] rd_tb;
    wire IorD_tb;
    wire MemWrite_tb;
    wire MtoR_tb;
    wire IRWrite_tb;
    wire [31:0] Imm_tb;
    wire AluSrcA_tb;
    wire [1:0] AluSrcB_tb;
    wire RegWrite_tb;
    wire Branch_tb;
    wire PCWrite_tb;
    wire PCSel_tb;
    wire [2:0] AluControl_tb;
    
decode_unit d0(
    .clk(clk_tb),
    .reset(reset_tb),
    .Cond_Chk_reg(Cond_Chk_tb),
    .instruction(instruction_tb),
    .opcode_reg(opcode_tb),
    .funct3_reg(funct3_tb),
    .funct7_reg(funct7_tb),
    .rs1_reg(rs1_tb),
    .rs2_reg(rs2_tb),
    .rd_reg(rd_tb),
    .IorD_reg(IorD_tb),
    .MemWrite_reg(MemWrite_tb),
    .MtoR_reg(MtoR_tb),
    .IRWrite_reg(IRWrite_tb),
    .Imm_reg(Imm_tb),
    .AluSrcA_reg(AluSrcA_tb),
    .AluSrcB_reg(AluSrcB_tb),
    .RegWrite_reg(RegWrite_tb),
    .Branch_reg(Branch_tb),
    .PCWrite_reg(PCWrite_tb),
    .PCSel_reg(PCSel_tb),
    .AluControl_reg(AluControl_tb)
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
    Cond_Chk_tb = 1;
    instruction_tb = 32'h002a5a3; // add rd1, rs1, rs2
    #200
    $finish;
end
endmodule