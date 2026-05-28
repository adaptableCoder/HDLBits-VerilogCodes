module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
	parameter LEFT=2'd0, RIGHT=2'd1, FALL_L=2'd2, FALL_R=2'd3;
    reg [1:0] state;
    reg [1:0] next;
    
    // Combinational always block for state transition logic. 
    // Given the current state and inputs, what should be next state be?
    // Combinational always block: Use blocking assignments.    
    always@(*) begin
		case (state)
            LEFT: next = bump_left ? (ground ? RIGHT : FALL_L) : (ground ? LEFT : FALL_L);
            RIGHT: next = bump_right ? (ground ? LEFT : FALL_R) : (ground ? RIGHT : FALL_R);
            FALL_L: next = ground ? LEFT : FALL_L;
            FALL_R: next = ground ? RIGHT : FALL_R;
		endcase
    end
   
    always @(posedge clk, posedge areset) begin
        if (areset) state <= LEFT;
        else state <= next;
	end
	
    // Output combinational circuit
    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
    assign aaah = (state==FALL_L) | (state==FALL_R);
endmodule
