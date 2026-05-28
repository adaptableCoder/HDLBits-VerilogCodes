module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT: next_state = (bump_left == 1'b1) ? RIGHT : LEFT;
            RIGHT: next_state = (bump_right == 1'b1) ? LEFT : RIGHT;
            
            // Always include a default to prevent latches
            default: next_state = LEFT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) state <= LEFT; // Reset specifically to LEFT
        else state <= next_state; // Otherwise, advance to the next state            
    end

    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
