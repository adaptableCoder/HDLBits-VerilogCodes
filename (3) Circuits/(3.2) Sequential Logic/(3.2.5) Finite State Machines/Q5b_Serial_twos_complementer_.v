module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=1'd0, B=1'd1;
    reg [1:0] next, state;
    
    assign next[A] = state[A]&(~x);
    assign next[B] = state[A]&x | state[B]&x | state[B]&(~x);
    
    always @(posedge clk, posedge areset) begin
        if (areset) state <= {1'b0,1'b1};
        else state <= next;
    end

    assign z = (state[A] & x) | (state[B] & ~x);
endmodule
