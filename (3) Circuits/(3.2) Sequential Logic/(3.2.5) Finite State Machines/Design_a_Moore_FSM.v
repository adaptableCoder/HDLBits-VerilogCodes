module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    // Use localparam so these values cannot be changed by other modules
    localparam BELOW_S1      = 3'd0,
               S1_TO_S2_UP   = 3'd1,
               S2_TO_S3_UP   = 3'd2,
               ABOVE_S3      = 3'd3,
               S3_TO_S2_DOWN = 3'd4,
               S2_TO_S1_DOWN = 3'd5;
    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state;
        case(state)
            BELOW_S1: begin
                if (s[3])      next_state = ABOVE_S3;
                else if (s[2]) next_state = S2_TO_S3_UP;
                else if (s[1]) next_state = S1_TO_S2_UP;
                else           next_state = BELOW_S1;
            end
            S1_TO_S2_UP: begin
                if (s[3])      next_state = ABOVE_S3;
                else if (s[2]) next_state = S2_TO_S3_UP;
                else if (!s[1]) next_state = BELOW_S1;
                else           next_state = S1_TO_S2_UP;
            end
            S2_TO_S3_UP: begin
                if (s == 3) next_state = S2_TO_S3_UP;
                else if (s == 7) next_state = ABOVE_S3;
                else if (s == 1) next_state = S2_TO_S1_DOWN;
            end
            ABOVE_S3: begin
                if (s == 7)      next_state = ABOVE_S3;
                else if (s == 3) next_state = S3_TO_S2_DOWN;
            end
            S3_TO_S2_DOWN: begin
                if (s == 3) next_state = S3_TO_S2_DOWN;
                else if (s == 7) next_state = ABOVE_S3;
                else if (s == 1) next_state = S2_TO_S1_DOWN;
            end
            S2_TO_S1_DOWN: begin
                if (s == 1)      next_state = S2_TO_S1_DOWN;
                else if (s == 3) next_state = S2_TO_S3_UP;
                else if (s == 0) next_state = BELOW_S1;
            end
        endcase
    end
    // State flip-flops with synchronous reset
    always @(posedge clk) begin    
        if (reset) state <= BELOW_S1; // Reset specifically to State as requested
        else state <= next_state; // Otherwise, advance to the next state
    end
 
    // Output logic: Moore model (depends only on state)
    always @(*) begin
        {fr3, fr2, fr1, dfr} = 4'b0000; // Default to prevent latches
        case (state)
            BELOW_S1:      {fr3, fr2, fr1, dfr} = 4'b1111;
            S1_TO_S2_UP:   {fr2, fr1} = 2'b11; 
            S2_TO_S1_DOWN: {fr2, fr1, dfr} = 3'b111;
            S2_TO_S3_UP:   fr1 = 1'b1;
            S3_TO_S2_DOWN: {fr1, dfr} = 2'b11;
            ABOVE_S3:      {fr3, fr2, fr1, dfr} = 4'b0000;
            default:       {fr3, fr2, fr1, dfr} = 4'b0000;
        endcase
    end
endmodule
