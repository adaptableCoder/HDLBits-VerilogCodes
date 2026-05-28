module D_FF(input D,clk,en, output reg Q);
    always @(posedge clk) begin
        if(en) begin
        	Q <= D;
        end
    end
endmodule

module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z );
    
    wire [7:0] Q;
    wire [7:0] inputs;
    
    assign inputs[0] = S; 
    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin: D_FFs
            D_FF u0 (.D(inputs[i]), .clk(clk), .en(enable), .Q(Q[i]));
            if (i<7) begin: connect_next
                assign inputs[i+1] = Q[i];
            end
        end
    endgenerate
    
    always @(*) begin
        Z = Q[{A,B,C}];
    end
endmodule