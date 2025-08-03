`timescale 1ns / 0.1ns

module Risc_V_tb(
    );
    reg reset ,clk;
    FullModule_RiscV risc_V(
    .clk(clk),
    .reset(reset));
    always #10 clk =!clk;
    initial begin
    clk = 0;
    reset = 0;
    #20 
    reset = 1;
   #500;
   $finish;
     end
    
endmodule
