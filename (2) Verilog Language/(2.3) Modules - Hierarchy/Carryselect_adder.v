module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] out1, out2a, out2b; wire cout;
    
    add16 lowera ( .a(a[15:0]), .b(b[15:0]), .cin(0), .sum(out1), .cout(cout) );
    add16 uppera ( .a(a[31:16]), .b(b[31:16]), .cin(0), .sum(out2a) );
    add16 upperb ( .a(a[31:16]), .b(b[31:16]), .cin(1), .sum(out2b) );
    
    always @(*) begin
        case (cout)
            2'b0: sum = {out2a, out1};
            2'b1: sum = {out2b, out1};
        endcase
    end
endmodule
