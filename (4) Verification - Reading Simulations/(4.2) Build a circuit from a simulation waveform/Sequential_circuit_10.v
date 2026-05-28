module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state);

    always @(posedge clk) begin
        case({a,b})
            2'b00: state <= 1'b0;
            2'b01: state <= state;
            2'b10: state <= state;
            2'b11: state <= 1'b1;
        endcase
    end
    
    assign q = (~a)&(b^state) | a&(~(b^state));
endmodule