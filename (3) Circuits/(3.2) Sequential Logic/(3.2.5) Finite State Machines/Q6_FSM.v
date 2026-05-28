module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5;
    reg [3:1] state, next;
    
    always @(*) begin
        case(state)
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next;
    end
    
    always @(*) begin
        case(state)
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b0;
            E: z = 1'b1;
            F: z = 1'b1;
        endcase
    end
endmodule
