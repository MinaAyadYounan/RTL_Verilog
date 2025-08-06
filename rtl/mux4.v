module mux4(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [31:0] D,
    input [1:0] sel,
    output reg [31:0] out
    );
always@(*)
    case(sel)
        0: out = A;
        1: out = B;
        2: out = C;
        3: out = D;
    endcase
endmodule
