
module main_decoder(
input [6:0]OP,
input Zeros,
output  PC_src,
output  [1:0]Result_src,
output  Mem_W,
output  ALU_src,
output  [1:0] imm_src,
output  Reg_W,
output  [1:0]ALU_op


    ); 
 // R type op code = 51;
 // B type opcode = 99 ;
 // I type opcode = 19(use ALU) or 3(lw ) or 103 in jalr 
 // S type opcode = 35 becomes 17
 // we can igonre all first two bit it alls one in RV32I table for op code
 // Also MSB only 1 in case of B , J,jalr instruction so we can put if conditon
 // jalr isn't require in our simple arch so we can forge it now
 // opcode[3] is 0 in all except in jal instruction
 // for basic arch we compare between those opcode[4] -> [ jal] or else if[OP[6]] then branch else other instruction 
 // compare other instruction by those  opcode[2,4,5]
 // we implement I[load,other] ,R,U,J,B 
 wire branch ,jump;
 reg [2:0]instruction_type;
 localparam [4:0] OPCODE_LW   = 5'b00000;
 localparam [4:0] OPCODE_I    = 5'b00100; 
 localparam [4:0] OPCODE_S    = 5'b01000; 
 localparam [4:0] OPCODE_R    = 5'b01100; 
 localparam [4:0] OPCODE_B    = 5'b11000; 
 localparam [4:0] OPCODE_JAL  = 5'b11011; 
 
   
  assign imm_src[1] = OP[6] & OP[5];
  assign imm_src[0] = OP[6] ^ OP[5] ^ OP[3];
  assign ALU_op[1] = OP[4];
  assign ALU_op[0] = OP[3]^OP[6];
  assign Result_src[1] =OP[6]&OP[5];
  assign Result_src[0] = ~(OP[5] | OP[4]); 
  assign Reg_W   = OP[3] || (OP[6:2] == OPCODE_R)|| (OP[6:2] == OPCODE_LW)||(OP[6:2] == OPCODE_I) ;
  assign ALU_src = (OP[6:2] == OPCODE_LW)||(OP[6:2] == OPCODE_I) || (OP[6:2] == OPCODE_S);   
  assign branch  = OP[6] & (~OP[2]);
  assign jump    = OP[3]|(OP[6]&OP[2]);
  assign Mem_W   =(OP[6:2] == OPCODE_S);
  assign PC_src = (branch & Zeros)|jump; 
     
endmodule