module MUX2(
    input A,
    input B,
    input sel,
    output reg C
    );
    always@(*) begin
   case(sel)
   0:C = A;
   1:C = B;
   endcase
    end
    
endmodule
