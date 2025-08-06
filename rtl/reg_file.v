
module reg_file(
    input [4:0]r1,
    input [4:0]r2,
    input [4:0]W1,
    input clk,
    input W_EN,
    input [31:0] W_data,
    output [31:0] RD1, RD2
    );
   reg [31:0] memo [0:31];
   assign RD1  = (r1 == 5'd0) ? 32'd0 : memo[r1];
   assign RD2 = (r2 == 5'd0) ? 32'd0 : memo[r2];
    
  always@(posedge clk) begin
  if(W_EN) begin
  memo[W1] <= W_data;
   end 
  end    
endmodule  

