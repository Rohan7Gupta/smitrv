`timescale 1ns / 1ps
module Half_adder(
    input A,
    input B,
    output Carry,
    output Sum
    );
xor(Sum,A,B);
and(Carry,A,B);
endmodule