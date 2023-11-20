`timescale 1ns / 1ps
`include "defines.v"

module branch_control(
    input [4:0] opcode_reg, 
    input [2:0] funct3_reg,
    input cf, zf, of, sf, branch,
    output reg branch
    );
    
    always @* begin
         if(branch) begin
            if (opcode_reg==7'b1100111 || opcode_reg== 7'b1100011) begin
                branch=1;
            end
            else begin
            case (funct3_reg) 
                3'b000: branch = zf;        
                3'b001: branch = ~zf;        
                3'b100: branch = (sf!=of);          
                3'b101: branch = (sf==of);        
                3'b110:branch = ~cf;         
                3'b111:branch = cf;   
                default: branch = 0;    
            endcase
            end
         end
         else branch=0;
    end
    
endmodule