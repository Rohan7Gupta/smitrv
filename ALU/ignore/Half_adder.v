module Half_adder(
    input A,
    input B,
    output Carry,
    output Sum
    );
assign Sum=A ^ B;
assign Carry= A & B;
endmodule