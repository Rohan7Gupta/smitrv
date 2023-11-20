`include "Half_adder.v"
module FULL_ADDER(
    input X,
    input Y,
    input Z,
    output SUM,
    output CARRY
    );
wire s1;
wire c1;
wire c2;
Half_adder L1(Y,Z,c1,s1);
Half_adder L2(X,s1,c2,SUM);
or(CARRY,c1,c2);

endmodule