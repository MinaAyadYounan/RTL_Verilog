module PC_counter (
    input  [31:0] PC_next,
    input         clk,
    input         reset,
    output [31:0] PC
);

    reg [6:0] pc_reg;

    assign PC = {23'd0, pc_reg, 2'b00};

    always @(posedge clk or negedge reset) begin
        if (!reset)
            pc_reg <= 7'd0;
        else
            pc_reg <= PC_next[8:2]; 
    end
endmodule
