// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out; 
    reg out;

    // Fill in state name declarations
    parameter A = 0;
    parameter B = 1;

    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic (Use blocking = to match the style)
            present_state = B;
            out = 1'b1;       // Output of State B is 1
            
        end else begin
            case (present_state)
                // Fill in state transition logic
                // (Calculate next_state based on CURRENT present_state)
                A: next_state = (in ? A : B); // If in=1 stay A, else B
                B: next_state = (in ? B : A); // If in=1 stay B, else A
            endcase

            // State flip-flops
            // (Because this is blocking, present_state updates IMMEDIATELY here)
            present_state = next_state;   

            case (present_state)
                // Fill in output logic
                // (This runs using the NEW present_state value)
                A: out = 1'b0;
                B: out = 1'b1;
            endcase
        end
    end

endmodule