module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, done=3'd4;
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            A: next = B;
            B: next = C;
            C: next= D;
            D: next = done;
            done: next = done;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end
    
    assign shift_ena = ~(state==done);
endmodule