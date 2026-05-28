module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
    
    generate
        genvar i;
        for (i=0; i<100; i=i+1) begin : adder_generator
            bcd_fadd adders (.a(a[(4*i)+3 : (4*i)]), .b(b[(4*i)+3 : (4*i)]), .cin(carry[i]), .cout(carry[i+1]), .sum(sum[(4*i)+3:(4*i)]) );
        end
    endgenerate
    assign cout = carry[100];
endmodule
