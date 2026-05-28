module top_module (
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
