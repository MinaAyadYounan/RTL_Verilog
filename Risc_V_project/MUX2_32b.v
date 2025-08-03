module MUX2_32b(
    input [31:0] A,
    input [31:0] B,
    input sel,
    output reg [31:0] C
    );
  always@(*) begin
       case(sel)
           0:C = A;
           1:C = B;
       endcase
    end 
endmodule
