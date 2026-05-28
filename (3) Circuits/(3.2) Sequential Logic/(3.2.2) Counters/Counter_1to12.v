module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    // Instantiate the count4 module
    count4 counter_inst (.clk(clk), .enable(c_enable), .load(c_load), .d(c_d), .Q(Q));

    // Assign the control signals to the internal counter
    assign c_enable = enable; // The external enable signal controls the internal enable
    assign c_d = 4'd1;      // Load the value 1 into the counter
    assign c_load = reset | ((Q == 4'd12) && (enable == 1'b1)); // Load when reset or when count reaches 12 and is enabled
endmodule