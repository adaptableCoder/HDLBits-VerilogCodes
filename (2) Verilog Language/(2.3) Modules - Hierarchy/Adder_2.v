module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] out1, out2;
    wire cout1;
    add16 lower ( .a(a[15:0]), .b(b[15:0]), .cin(16'b0000000000000000), .sum(out1), .cout(cout1) );
    add16 upper ( .a(a[31:16]), .b(b[31:16]), .cin(cout1), .sum(out2) );
    
    assign sum = {out2, out1};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
