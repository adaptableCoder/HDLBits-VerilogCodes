module A (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module top_module (input x, input y, output z);
    A instance1 (.x(x), .y(y), .z(z) );
endmodule
