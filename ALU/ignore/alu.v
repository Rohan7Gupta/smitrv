'timescale 1ns/1ps
module ALU(
    input [31:0]SrcA,
    input [31:0]SrcB,
    input [2:0]ALUControl,
    input [2:0]ALUop,
    output reg [31:0]ALUResult,
    output reg zeroflag,
    output reg carry
);
always @(*)
begin

    case(ALUop)
    3'b011: adder_32(SrcA,SrcB,0,ALUResult,carry);//immediate
    3'b101: adder_32(SrcA,SrcB,0,ALUResult,carry);//store
    3'b011: ALUResult = SrcA ^ SrcB;//branch
    3'b000: begin //R type(except sub and sra)
        case(ALUControl)
        3'b000: adder_32(SrcA,SrcB,0,ALUResult,carry);//add
        3'b001: ALUResult = SrcA << SrcB[5:0];//sll
        3'b010: begin //slt
            if(signed(SrcA) < signed(SrcB));
            ALUResult=1;
            else
            ALUResult=0;
        end
        3'b011: begin //sltu
            if(unsigned(SrcA) < unsigned(SrcB));
            ALUResult=1;
            else
            ALUResult=0;
        end
        3'b100: ALUResult = SrcA ^ SrcB;//xor
        3'b101: ALUResult = SrcA >> SrcB[5:0];//srl
        3'b110: ALUResult = SrcA | SrcB;//and
        3'b111: ALUResult = SrcA & SrcB;//or
        endcase
    end
    3'b001: begin //R type( sub and sra)
        case(ALUControl)
        3'b000: ALUResult = SrcA - SrcB;//sub
        3'b101: ALUResult = SrcA >>> SrcB[5:0]//sra
        endcase
    end
    endcase

end
endmodule
