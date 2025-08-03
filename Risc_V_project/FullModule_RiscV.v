`include "Adder_Nbit.v"
`include "ALU_32.v"
`include "ALU_controller.v"
`include "Extend.v"
`include "instruction_ROM.v"
`include "main_decoder.v"
`include "memo_Data.v"
`include "mux4.v"
`include "MUX2_32b.v"
`include "PC_counter.v"
`include "reg_file.v"
`include "RiscV_controller.v"

module FullModule_RiscV(
input clk,reset
    );
    wire [31:0] PC_next, PC, PC_plus4 , ALU_result,empty ,PC_srcb;
    wire [31:0] instr , REG_Wdata ,SRC_A,SRC_B, RD2, immEXT ,readData;
    wire PC_src ,Mem_W,ALU_src,Reg_W,Zeros;
    wire [1:0] Result_src, imm_src;
    wire [2:0]Alu_control;
 assign empty = 32'b0;
 PC_counter counter(
        .PC_next(PC_next),
        .clk(clk), 
        .reset(reset),
        .PC(PC)
        );
  instruction_ROM ISA (
         .Address(PC),
         .RD(instr)
            );
            
  RiscV_controller controller(
              .OP(instr[6:0]),
              .F7(instr[30]),
              .F3(instr[14:12]),
              .Zero(Zeros),
              .PC_src(PC_src),
              .Result_src(Result_src),
              .Mem_W(Mem_W),
              .Alu_control(Alu_control),
              .ALU_src(ALU_src),
              .imm_src(imm_src),
              .Reg_W(Reg_W)
                );          
            
  reg_file regester_memo(
               .r1(instr[19:15]),
               .r2(instr[24:20]),
               .W1(instr[11:7]),
               .clk(clk),
               .W_EN(Reg_W),
               .W_data(REG_Wdata),
               .RD1(SRC_A),
               .RD2(RD2)
                );
  Extend ex_imm(
                .imm(instr[31:7]),
                .imm_src(imm_src),
                .immEXT(immEXT)
    );
    
    
   MUX2_32b alu_src(
                 .A(RD2),
                 .B(immEXT),
                 .sel(ALU_src),
                 .C(SRC_B)
        );
   ALU_32 Alu_32b(
                .A(SRC_A),
                .B(SRC_B),
                .sel(Alu_control),
                .Result(ALU_result),
                .Zero_F(Zeros)
            );
   memo_Data mem_D(
               .Addr(ALU_result),
               .clk(clk),
               .WE(Mem_W),
               .WD(RD2),
               .RD(readData)
               );
               
   mux4 reg_F_src(
                 .A(ALU_result),
                 .B(readData),
                 .C(PC_plus4),
                 .D(empty),
                 .sel(Result_src),
                 .out(REG_Wdata)
                  ); 
  Adder_Nbit PC_p4(
                  .A(PC),
                  .B(32'd4),
                  .C(PC_plus4)
  ); 
   Adder_Nbit pc_target (
                   .A(PC),
                   .B(immEXT),
                   .C(PC_srcb)); 
   
     MUX2_32b PC_mux(
                     .A(PC_plus4),
                     .B(PC_srcb),
                     .sel(PC_src),
                     .C(PC_next) );            
                          
endmodule
