module fetch_unit(
    input clk,
    input reset,
    input reg PCSel_reg, // selects between (pc+4) and (pc')
    input reg [31:0] Imm_reg, // immediate data
    //input reg [31:0] ALU_result_reg, // ALU output
    output reg [31:0] pc_reg // program conter register
);

// Sequential logic for updating the Program Counter
always @(posedge clk or posedge reset)
begin
    if (reset) begin
        PCSel_reg <= 0;
        Imm_reg <= 0;
        //ALU_result_reg <= 0;
        pc_reg <= 0;
    end
    else begin
        // Stand-Alone model
        if (PCSel_reg) begin
            pc_reg <= pc_reg + Imm_reg;
        end
        else begin
            pc_reg <= pc_reg + 4;
        end
        /*//Combined model
            pc_reg <= ALU_result_reg;
        */
    end
end
endmodule