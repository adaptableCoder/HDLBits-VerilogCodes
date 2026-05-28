module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);  
    // assign s = ...
    // assign overflow = ...
    wire signed [8:0] temp = a + b;
    assign s = temp[7:0];
    
    assign overflow = (a[7] == b[7]) && (a[7] != s[7]);
endmodule
