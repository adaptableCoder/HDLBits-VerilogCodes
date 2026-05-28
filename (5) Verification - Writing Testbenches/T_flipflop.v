module top_module ();
    reg clk, reset, t, q;
    tff ff1 (.clk(clk), .reset(reset), .t(t), .q(q));
    
    initial begin
        clk=0; reset=0; t=0; #5
        clk=1; reset=1; #5;
        clk=0; reset=0; #5;
        clk=1; reset=0; t=1; #5;
    end
endmodule