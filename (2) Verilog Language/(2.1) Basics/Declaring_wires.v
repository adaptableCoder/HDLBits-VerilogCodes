`default_nettype wire
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );
    
    assign and_one = a & b;
    assign and_two = c & d;
    
    wire wire_one = and_one;
    wire wire_two = and_two;
    
    assign or_one = wire_one | wire_two;
    
    assign out = or_one;
    assign out_n = ~out;
endmodule
