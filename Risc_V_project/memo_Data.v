`timescale 1ns / 1ps

module memo_Data(
    input [31:0]Addr,
    input clk,WE,
    input [31:0] WD,
    output reg [31:0] RD
    );
    reg [31:0] memo[0:127];
    wire address;
    integer i;
    assign address =Addr[6:0];
    initial begin  
           for(i=0;i<127;i=i+1)  
                ram[i] <= 31'd0;  
    end	
    always@(*) begin
    RD = WE ? {32{1'b0}}: memo[address];
    end
    
    always@(posedge clk) begin
    memo[address] <= WE ? WD: memo[address];
    end
endmodule
