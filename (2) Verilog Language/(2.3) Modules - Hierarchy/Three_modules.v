module top_module ( input clk, input d, output q );
    wire one, two;
    wire three = clk;
    my_dff instance1 ( three, d, one );
    my_dff instance2 ( three, one, two );
    my_dff insatnce3 ( three, two, q );
endmodule
