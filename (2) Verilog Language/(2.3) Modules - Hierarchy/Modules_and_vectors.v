module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] one, two, three;
    
    // Use named port connections for clarity
    my_dff8 instance1 (.clk(clk), .d(d), .q(one));
    my_dff8 instance2 (.clk(clk), .d(one), .q(two));
    my_dff8 instance3 (.clk(clk), .d(two), .q(three));
    
    always @(*) begin
        case (sel)
            2'b00: q = d;
            2'b01: q = one;
            2'b10: q = two;
            2'b11: q = three;
        endcase
    end
endmodule
