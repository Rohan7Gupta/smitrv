`include "Full_adder.v"
module adder_32(
    input [31:0] a,
    input [31:0] b,
    input cin,  
    output [31:0] sum,
    output carry
    );
wire [31:0] w;
assign w[0]=cin;

generate
    for(i = 0; i < 32; i = i + 1)begin:Adder32BitBlock
        FULL_ADDER adder(a[i], b[i], w[i],sum[i],w[i+1]);
    end
endgenerate
endmodule