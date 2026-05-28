module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, done=3'd4;
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            A: next = data ? B : A;
            B: next = data ? C : A;
            C: next = data ? C : D;
            D: next = data ? done : A;
            done: next = done;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end
    
    assign start_shifting = (state==done);
endmodule