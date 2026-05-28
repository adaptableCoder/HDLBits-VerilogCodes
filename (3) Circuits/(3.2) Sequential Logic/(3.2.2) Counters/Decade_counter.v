module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
        if (reset) q <= 4'b0000;
        else begin
            if (q == 4'd9) q <= 4'b0000; // Reset to 0
            else q <= q + 1; // Increment the count
        end
    end
endmodule
