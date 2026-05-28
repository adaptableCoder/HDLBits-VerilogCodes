module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out
);  

    parameter A=0, B=1; 
    reg state, next_state;

    // --- Part 1: State Transition Logic (Combinational) ---
    // This block calculates the *next* state based on *current* state and input.
    // It does NOT wait for a clock edge.
    always @(*) begin    
        case (state)
            A: begin
                if (in == 1'b1) next_state = A;  // Stay in A if in=1
                else            next_state = B;  // Move to B if in=0
            end
            
            B: begin
                if (in == 1'b1) next_state = B;  // Stay in B if in=1
                else            next_state = A;  // Move to A if in=0
            end
            
            // Always include a default to prevent latches
            default: next_state = B;
        endcase
    end

    // --- Part 2: State Flip-Flops (Sequential) ---
    // This block saves the next_state into state on the clock edge.
    // It also handles the Asynchronous Reset.
    always @(posedge clk, posedge areset) begin    
        if (areset) begin
            // Reset specifically to State B (as requested)
            state <= B;
        end
        else begin
            // Otherwise, advance to the next state
            state <= next_state;
        end
    end

    // --- Part 3: Output Logic ---
    // Output depends on the current state (Moore Machine).
    // Example: Output is 1 only when in state B.
    assign out = (state == B);

endmodule

/*
Breakdown of the Format
	1.Combinational Block (always @(*)):
		- This is purely logic (gates). It looks at where you are (state) and what the input is (in) to decide where to go next (next_state).
		- Crucial: Use blocking assignments (=) here.

	2. Sequential Block (always @(posedge clk...)):
		- This represents the D Flip-Flops.
		- Because areset is in the sensitivity list and used in the if, it is an Asynchronous Reset. If areset goes high, the state changes immediately, ignoring the clock.
		- Crucial: Use non-blocking assignments (<=) here.
        
	3. Output Logic (assign):
		- This drives the output based on the current state.
		- For a Moore Machine, output depends only on state.
		- For a Mealy Machine, output would depend on state and in (e.g., assign out = (state == B) && in;).
*/