`timescale 1ns / 1ps


module Extend(
    input [24:0] imm,
    input [1:0]imm_src,
    output reg [31:0] immEXT
    );

    always @(*) begin
        case (imm_src)
            2'b00: immEXT = {{20{imm[24]}}, imm[24:13]};

            2'b01: immEXT = {{20{imm[24]}}, imm[24:18], imm[4:0]};
     
            2'b10: immEXT = {{19{imm[24]}}, imm[24], imm[0], imm[23:18], imm[4:1], 1'b0};
            
            2'b11: immEXT = {{12{imm[24]}}, imm[12:5],imm[13], imm[23:14], 1'b0};
        endcase
    end
endmodule
