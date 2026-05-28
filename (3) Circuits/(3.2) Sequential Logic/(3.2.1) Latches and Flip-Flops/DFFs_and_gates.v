module top_module (
    input clk,
    input x,
    output z
); 
    wire Q1; wire Q1bar = ~Q1;
    wire Q2; wire Q2bar = ~Q2;
    wire Q3; wire Q3bar = ~Q3;
    
    wire d1 = x ^ Q1;
    wire d2 = x & Q2bar;
    wire d3 = x | Q3bar;
    
    always @(posedge clk) begin
        Q1 <= d1;
        Q2 <= d2;
        Q3 <= d3;
    end
    
    assign z = ~(Q1 | Q2 | Q3);
endmodule
