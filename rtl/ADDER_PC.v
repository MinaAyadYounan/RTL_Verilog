
module ADDER_PC(
    input [31:0] A,
    output [31:0] B
    );
    assign B = A + 32'b100;
endmodule

