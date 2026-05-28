/*
// Original Code
module top_module (input a, input b, input c, output out);//

    andgate inst1 ( a, b, c, out );

endmodule
*/
module top_module (input a, input b, input c, output out);//

    wire out1;
    andgate inst1 ( .out(out1), .a(a), .b(b), .c(c), .d(1'b1), .e(1'b1) );
    assign out = ~out1;
endmodule
