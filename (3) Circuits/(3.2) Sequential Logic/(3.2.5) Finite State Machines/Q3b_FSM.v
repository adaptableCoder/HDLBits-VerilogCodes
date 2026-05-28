module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4;
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            A: next = x ? B : A;
            B: next = x ? E : B;
            C: next = x ? B : C;
            D: next = x ? C : B;
            E: next = x ? E : D;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end

    always @(*) begin
        case(state)
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b1;
            E: z = 1'b1;
        endcase
    end
endmodule
