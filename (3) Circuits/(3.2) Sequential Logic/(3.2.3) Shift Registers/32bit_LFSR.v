module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
	
    reg [31:0] q_next;		// q_next is not a register

	// Convenience: Create a combinational block of logic that computes
	// what the next value should be. For shorter code, I first shift
	// all of the values and then override the two bit positions that have taps.
	// A logic synthesizer creates a circuit that behaves as if the code were
	// executed sequentially, so later assignments override earlier ones.
	// Combinational always block: Use blocking assignments.
	always @(*) begin
        q_next = q[31:1];
        q_next[31] = q[0];
        q_next[21] = q[22] ^ q[0];
        q_next[1] =  q[2] ^ q[0];
        q_next[0] = q[1] ^ q[0];
	end
	
	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
	end
	
endmodule