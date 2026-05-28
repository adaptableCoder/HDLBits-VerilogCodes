module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    wire [1:0] sel;
    assign {sel[1], sel[0]} = {c,d};
    
    always @(*) begin
        case (sel)
            2'b00: mux_in = 4'b0100;
            2'b01: mux_in = 4'b0001;
            2'b10: mux_in = 4'b0101;
            2'b11: mux_in = 4'b1001;
        endcase
    end
endmodule

//HDL BITS Official Solution
/*
module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	// After splitting the truth table into four columns,
	// the rest of this question involves implementing logic functions
	// using only multiplexers (no other gates).
	// I will use the conditional operator for each 2-to-1 mux: (s ? a : b)
	assign mux_in[0] = c ? 1 : d;          // 1 mux:   c|d
	assign mux_in[1] = 0;                  // No muxes:  0
	assign mux_in[2] = d ? 0 : 1;          // 1 mux:    ~d
	assign mux_in[3] = c ? d : 0;          // 1 mux:   c&d
	
endmodule
*/