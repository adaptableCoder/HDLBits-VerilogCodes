module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    wire gate1 = j & ~Q;
    wire gate2 = ~k & Q;
    wire d = gate1 | gate2;
    
    always @(posedge clk) begin
        Q <= d;
    end
endmodule
