module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = (in == 1'b0) ? A: B ;
            B: next_state = (in == 1'b0) ? C: B;
            C: next_state = (in == 1'b0) ? A: D;
            D: next_state = (in == 1'b0) ? C: B ;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin    
        if (areset) begin
            // Reset specifically to State B (as requested)
            state <= A;
        end
        else begin
            // Otherwise, advance to the next state
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            A: out=1'b0;
            B: out=1'b0;
            C: out=1'b0;
            D: out=1'b1;
        endcase
    end

endmodule
