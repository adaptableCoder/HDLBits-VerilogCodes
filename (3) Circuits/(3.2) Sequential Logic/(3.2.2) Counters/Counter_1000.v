module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);
    wire [3:0] out1, out2, out3;
    
    // The fastest counter (runs at 1000 Hz) is always enabled.
    assign c_enable[0] = 1'b1;
    bcdcount counter0 (clk, reset, c_enable[0], out1);
    
    // The middle counter (runs at 100 Hz) is enabled only when counter0 is 9.
    assign c_enable[1] = (out1 == 4'd9);
    bcdcount counter1 (clk, reset, c_enable[1], out2);
    
    // The slowest counter (runs at 10 Hz) is enabled only when counter1 is 9.
    assign c_enable[2] = (out2 == 4'd9 && out1 == 4'd9);
    bcdcount counter2 (clk, reset, c_enable[2], out3);
    
    // The OneHertz pulse is active for a single clock cycle when all counters are at 9.
    assign OneHertz = (out1 == 4'd9) && (out2 == 4'd9) && (out3 == 4'd9);
endmodule
