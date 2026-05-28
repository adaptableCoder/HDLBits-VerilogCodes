module full_adder_behavioral (
    input a,
    input b,
    input cin,
    output reg sum,
    output reg carry
);
    always @(*) begin
        // Perform addition of all three inputs
        {carry, sum} = a + b + cin; // {carry, sum} assigns the carry-out and sum from the 3-bit addition result
    end
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
    
    generate
        genvar i;
        for (i = 0; i < 100; i = i + 1) begin : gen_adders
            full_adder_behavioral fa ( .a(a[i]), .b(b[i]), .cin(carry[i]), .sum(sum[i]), .carry(carry[i+1]) );
            assign cout[i] = carry[i+1]; // each stage carry
        end
    endgenerate
endmodule
