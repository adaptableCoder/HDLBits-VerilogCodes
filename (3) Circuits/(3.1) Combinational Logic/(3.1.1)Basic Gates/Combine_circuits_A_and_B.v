module A (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module B ( input x, input y, output z );
    assign z = ~(x^y);
endmodule

module top_module (input x, input y, output z);
    wire wire1, wire2, wire3, wire4;
    A inst1 (.x(x), .y(y), .z(wire1) );
    B inst2 (.x(x), .y(y), .z(wire2) );
    A inst3 (.x(x), .y(y), .z(wire3) );
    B inst4 (.x(x), .y(y), .z(wire4) );
    
    assign z = (wire1 | wire2) ^ (wire3 & wire4);
endmodule
