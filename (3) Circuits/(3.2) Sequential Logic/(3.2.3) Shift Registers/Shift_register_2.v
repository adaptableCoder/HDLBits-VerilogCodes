module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux1_out, mux2_out;
    
    always @(E) begin
        case (E)
            1'b0: mux1_out = Q;
            1'b1: mux1_out = w ;
        endcase
    end
    
    always @(L) begin
        case (L)
            1'b0: mux2_out = mux1_out;
            1'b1: mux2_out = R;
        endcase
    end
    
    always @(posedge clk) begin
        Q <= mux2_out;
    end
endmodule

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    MUXDFF one(.clk(KEY[0]), .w(LEDR[1]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[0]) );
    MUXDFF two(.clk(KEY[0]), .w(LEDR[2]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[1]) );
    MUXDFF three(.clk(KEY[0]), .w(LEDR[3]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[2]) );
    MUXDFF four(.clk(KEY[0]), .w(KEY[3]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]) );
endmodule