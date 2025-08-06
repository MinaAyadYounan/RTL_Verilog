`timescale 1ns / 1ps

module instruction_ROM(
    input [31:0] Address,
    output  [31:0]  RD
    );
    reg[31:0]memo[0:63];
   assign RD = memo[Address[8:2]];
       initial begin
       memo[0] = 32'h00000493;  // addi s1, zero, 0
       memo[1] = 32'h00000413;  // addi s0, zero, 0
       memo[2] = 32'h00A00293;  // addi t0, zero, 10
       memo[3] = 32'h40540333;  // sub t1, s0, t0
       memo[4] = 32'h000323B3;  // slt t2, t1, zero
       memo[5] = 32'h00038863;  // beq t2, zero, done
       memo[6] = 32'h008484B3;  // add s1, s1, s0
       memo[7] = 32'h00140413;  // addi s0, s0, 1
       memo[8] = 32'hFEDFF06F;  // jal loop
       memo[9] = 32'h00000013;  // nop
   end
   endmodule
