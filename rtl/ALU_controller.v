`timescale 1ns / 1ps

module ALU_controller(
input F7,
input [2:0]F3,
input OP_b5,
input [1:0] ALU_op,
output reg[2:0] ALU_control
    );
    
    wire sub_signal;
    wire F7_b5;
    wire [2:0] Q0;// used to determine sub or add for any instruction use alu except R type
    wire [2:0] ADD_SUB_signal;
    reg [2:0]F3_out;
    localparam AND_sig = 3'b010;
    localparam OR_sig = 3'b011;
    localparam XOR_sig = 3'b100;
    localparam SLT_sig = 3'b101;
    localparam SLL_sig = 3'b110;
    localparam SRL_sig = 3'b111;
    assign F7_b5 = F7;
    assign sub_signal = F7_b5 & OP_b5; // if it 1 and then it subtract in cas F3 =  0;
    assign Q0 = {2'b00,ALU_op[0]};
    assign ADD_SUB_signal = {2'b00,sub_signal} ;
    always@(*) begin
    case(F3)
       0: F3_out =ADD_SUB_signal;
       1: F3_out =SLL_sig;
       2: F3_out =SLT_sig;
       3: F3_out =SLT_sig; // suppose to be SLT unsigned but it isn't implemented
       4: F3_out =XOR_sig;
       5: F3_out =SRL_sig;
       6: F3_out =OR_sig;
       7: F3_out =AND_sig;
       default: F3_out =ADD_SUB_signal;
    endcase
    if(ALU_op[1]) begin
         ALU_control = F3_out;
    end
    else begin
        ALU_control = Q0;
    end 
    end  

endmodule
