module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );

    always @(*) begin 
        for (integer i=0; i<256; i=i+1) begin
            if (sel==i) out = in[i*4+3 -: 4];
        end
    end
endmodule
