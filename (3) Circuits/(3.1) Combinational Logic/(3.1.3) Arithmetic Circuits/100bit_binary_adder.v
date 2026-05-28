module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    wire [100:0] temp_sum = a+b+cin;
    assign sum[99:0] = temp_sum[99:0];
    assign cout = temp_sum[100];
endmodule

//HDL BITS Official Solution
/*
module top_module (
	input [99:0] a,
	input [99:0] b,
	input cin,
	output cout,
	output [99:0] sum
);

	// The concatenation {cout, sum} is a 101-bit vector.
	assign {cout, sum} = a+b+cin;

endmodule
*/