module top_module (
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
