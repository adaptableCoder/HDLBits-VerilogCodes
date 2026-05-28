module top_module (
    input clk,
    input in, 
    output out);
    wire q = out;
    always @(posedge clk) begin
        out <= in ^ q;
    end
endmodule
