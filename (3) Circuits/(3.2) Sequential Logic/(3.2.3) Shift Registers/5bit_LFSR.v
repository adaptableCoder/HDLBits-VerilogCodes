module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    wire [4:0] d_in;
    
    assign d_in[0] = q[1];
    assign d_in[1] = q[2];
    assign d_in[2] = q[3] ^ q[0]; // Matches "three" logic input
    assign d_in[3] = q[4];
    assign d_in[4] = 0 ^ q[0];    // Matches "five" logic input
    
    // Sequential Logic Block with Synchronous Reset
    always @(posedge clk) begin
        if(reset) begin
            // Synchronous reset applied at the positive clock edge
    	    // q <= 5'b11111; doesn't work
            q <= 1; //works
        end
        else begin
            // Normal operation: load the inputs from the logic defined above
            q <= d_in;
        end
    end
endmodule