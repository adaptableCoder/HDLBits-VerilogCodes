module top_module (
    input clock,
    input a,
    output p,
    output q );

    // NOTE this: always @(clock) doesn't mean level triggered, instead use following
    always @(*) begin
        if (clock) p <= a;
    end
    
    always @(negedge clock) begin
        q <= a;
    end
endmodule