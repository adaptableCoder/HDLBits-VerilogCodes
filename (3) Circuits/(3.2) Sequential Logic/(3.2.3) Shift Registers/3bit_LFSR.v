module mux_dff (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    wire d;
    always @(L) begin
        case (L)
            1'b0: d = q_in;
            1'b1: d = r_in;
        endcase
    end
    always @(posedge clk) begin
        Q <= d;
    end
endmodule

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
    output [2:0] LEDR    // Q
); 
    mux_dff one(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[0]), .q_in(LEDR[2]), .Q(LEDR[0]) );
    mux_dff two(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[1]), .q_in(LEDR[0]), .Q(LEDR[1]) );
    mux_dff three(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[2]), .q_in(LEDR[2] ^ LEDR[1]), .Q(LEDR[2]) );
endmodule