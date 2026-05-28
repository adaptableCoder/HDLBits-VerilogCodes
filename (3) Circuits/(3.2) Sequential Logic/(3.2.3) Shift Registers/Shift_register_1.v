module D_FF(input D,R,clk, output reg Q);
    always @(posedge clk) begin
        if (!R) begin
            Q <= 0;
        end
        else begin
        	Q <= D;
        end
    end
endmodule

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire [3:0] outputs;
    wire [3:0] inputs;
    
    assign out = outputs[3]; assign inputs[0] = in; 
    
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: D_FFs
            D_FF u0 (.D(inputs[i]), .R(resetn), .clk(clk), .Q(outputs[i]));
            if (i<3) begin: connect_next
                assign inputs[i+1] = outputs[i];
            end
        end
    endgenerate 
endmodule