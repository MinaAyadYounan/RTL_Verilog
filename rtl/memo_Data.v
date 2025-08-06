module memo_Data(
    input [31:0]Addr,
    input clk,WE,
    input [31:0] WD,
    output  [31:0] RD
    );
    reg [31:0] memo[0:63];
    wire [5:0] address;
    integer i;
    assign address =Addr[7:2];
    initial begin  
           for(i=0;i<63;i=i+1)  
                memo[i] = 31'd0;  
    end	
    assign RD = memo[address];
    always@(posedge clk) begin
          if (WE) begin
            memo[address] <= WD;
    		end
    end
endmodule

