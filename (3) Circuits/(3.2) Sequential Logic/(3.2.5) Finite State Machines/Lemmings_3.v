module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    
	parameter LEFT=3'd0, RIGHT=3'd1, FALL_L=3'd2, FALL_R=3'd3, DIG_L=3'd4, DIG_R=3'd5;
    reg [2:0] state, next;
    
    // Combinational always block for state transition logic.   
    always@(*) begin
		case (state)
            LEFT: next = bump_left ? (ground ? (dig ? DIG_L: RIGHT) : FALL_L) : (ground ? (dig ? DIG_L : LEFT) : FALL_L);
            RIGHT: next = bump_right ? (ground ? (dig ? DIG_R : LEFT) : FALL_R) : (ground ? (dig ? DIG_R : RIGHT) : FALL_R);
            FALL_L: next = ground ? LEFT : FALL_L;
            FALL_R: next = ground ? RIGHT : FALL_R;
            DIG_L: next = dig ? (ground ? DIG_L : FALL_L) : (ground ? DIG_L : FALL_L);
            DIG_R: next = dig ? (ground ? DIG_R : FALL_R) : (ground ? DIG_R : FALL_R);
		endcase
    end
   
    // Asynchronous Sequential Logic (Flip-Flop)
    always @(posedge clk, posedge areset) begin
        if (areset) state <= LEFT;
        else state <= next;
	end
		
    // Output combinational block
    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
    assign aaah = (state==FALL_L) | (state==FALL_R);
    assign digging = (state==DIG_L) | (state==DIG_R);
endmodule
