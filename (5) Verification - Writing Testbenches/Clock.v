module top_module ( );
    reg clk;
    dut clock (.clk(clk));
    
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
endmodule