module ALU_32 (
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [2:0]  sel,
    output reg  [31:0] Result,
    output wire  Zero_F
);

    wire [31:0] add_res = A + B;
    wire [31:0] sub_res = A - B;
    wire [31:0] and_res = A & B;
    wire [31:0] or_res  = A | B;
    wire [31:0] xor_res = A ^ B;
    wire slt = (A[31] & ~B[31]) | (~(A[31] ^ B[31]) & (A < B));
    wire [31:0] slt_res= {31'd0, slt};
    wire [31:0] sll_res = A << B[4:0];  
    wire [31:0] srl_res = A >> B[4:0];  

    always @(*) begin
        case (sel)
            3'd0: Result = add_res;
            3'd1: Result = sub_res;
            3'd2: Result = and_res;
            3'd3: Result = or_res;
            3'd4: Result = xor_res;
            3'd5: Result = slt_res;
            3'd6: Result = sll_res;
            3'd7: Result = srl_res;
            default: Result = 32'd0;
        endcase
    end
    assign Zero_F = ~|Result;

endmodule
