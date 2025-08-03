`timescale 1ns / 1ps

module PC_counter(
    input [31:0] PC_next,
    input clk, reset,
    output reg [31:0] PC
    );
    always@(posedge clk ,negedge reset) begin
        if(~reset) begin
        PC <= {32{1'b0}};
        end
        else begin
        PC <= PC_next;
        end
    end
endmodule
