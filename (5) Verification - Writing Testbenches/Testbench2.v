module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
    wire out;

    q7 dut ( .clk(clk), .in(in), .s(s), .out(out));

    initial begin
        clk = 1'b0;
        in  = 1'b0;
        s   = 3'd2;

        #5 clk = 1'b1;
        #5 clk = 1'b0; s = 3'd6;
        #5 clk = 1'b1;
        #5 clk = 1'b0; in=1'b1; s = 3'd2;
        #5 clk = 1'b1;
        #5 clk = 1'b0; in=1'b0; s = 3'd7;
        #5 clk = 1'b1;
        #5 clk = 1'b0; in=1'b1; s = 3'd0;
        #5 clk = 1'b1;
        #5 clk = 1'b0;
        #5 clk = 1'b1;
        #5 clk = 1'b0;
        #5 clk = 1'b1;
        #5 clk = 1'b0; in = 1'b0;
        #5 clk = 1'b1;
        #5 clk = 1'b0;
    end
endmodule