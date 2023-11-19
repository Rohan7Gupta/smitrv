module adder_32(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] sum,
    output carry
    );
wire [31:0] w;
assign w[0]=cin;
// full_adder L0 (a[0],b[0],w[0],sum[0],w[1]);
// full_adder L1 (a[1],b[1],w[0],sum[1],w[2]);
// full_adder L2 (a[2],b[2],w[1],sum[2],w[3]);
// full_adder L2 (a[2],b[2],w[1],sum[2],w[2]);
// full_adder L31 (a[3],b[3],w[2],sum[3],carry);

generate
    for(i = 0; i < 32; i = i + 1)begin:Adder32BitBlock
        FULL_ADDER adder(a[i], b[i], w[i],sum[i],w[i+1]);
    end
endgenerate
endmodule