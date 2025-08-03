`timescale 1ns / 1ps



module ALU_32(
    input [31:0] A,
    input [31:0] B,
    input [2:0] sel,
    output reg [31:0] Result,
    output reg Zero_F
    );
    always@(*)
    begin
    case(sel)
    0:Result = A+B;
    1:Result = A-B;
    2:Result = A&B;
    3:Result = A|B;
    4:Result = A^B;
    5:Result =  ($signed(A) < $signed(B)) ? 32'b1:32'b0; 
    6:Result = (A<<B[4:0]);  
    7:Result = A>>B[4:0];
    endcase
    end
    always@(*)begin
    Zero_F=(Result == 0 )? 1:0;
    end
endmodule
