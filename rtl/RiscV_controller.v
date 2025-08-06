`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2025 11:02:26 PM
// Design Name: 
// Module Name: RiscV_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RiscV_controller(
 input [6:0]OP,
 input  F7,
 input [2:0]F3,
 input Zero,
 output PC_src,
 output [1:0]Result_src,
 output Mem_W,
 output [2:0]Alu_control,
 output ALU_src,
 output [1:0]imm_src,
 output Reg_W
    );
    wire [1:0]ALU_op;
    main_decoder main_controller(
     .OP(OP),
    .Zeros(Zero),
    .PC_src(PC_src),
    .Result_src(Result_src),
    .Mem_W(Mem_W),
    .ALU_src(ALU_src),
    .imm_src(imm_src),
    .Reg_W(Reg_W),
    .ALU_op(ALU_op));
 ALU_controller alu_control(
   .F7(F7),
   .F3(F3),
   .OP_b5(OP[5]),
   .ALU_op(ALU_op),
   .ALU_control(Alu_control)
       );

endmodule
