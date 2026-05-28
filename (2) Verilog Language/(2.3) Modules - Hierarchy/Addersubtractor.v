module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [15:0] sum1, sum2; 
    wire cout1;
    wire [31:0] xored;
    
    always @(*) begin
        case (sub)
            0: xored = b;
            1: xored = ~b;
        endcase
    end     
    
    add16 instance1 ( .a(a[15:0]), .b(xored[15:0]), .cin(sub), .sum(sum1), .cout(cout1) );
    add16 instance2 ( .a(a[31:16]), .b(xored[31:16]), .cin(cout1), .sum(sum2) );
    
    assign sum = {sum2, sum1};
endmodule
