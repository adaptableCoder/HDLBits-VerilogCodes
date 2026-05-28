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

	parameter LEFT=3'd0, RIGHT=3'd1, FALL_L=3'd2, FALL_R=3'd3, DIG_L=3'd4, DIG_R=3'd5, SPLAT=3'd6;
    reg [2:0] state, next;
    reg [4:0] count=5'd0;
    
    // Combinational always block for state transition logic.   
    always@(*) begin
		case (state)
            LEFT: next = bump_left ? (ground ? (dig ? DIG_L: RIGHT) : FALL_L) : (ground ? (dig ? DIG_L : LEFT) : FALL_L);
            RIGHT: next = bump_right ? (ground ? (dig ? DIG_R : LEFT) : FALL_R) : (ground ? (dig ? DIG_R : RIGHT) : FALL_R);
            FALL_L: next = ground ? ((count>5'd20) ? SPLAT : LEFT) : FALL_L;
            FALL_R: next = ground ? ((count>5'd20) ? SPLAT : RIGHT) : FALL_R;
            DIG_L: next = dig ? (ground ? DIG_L : FALL_L) : (ground ? DIG_L : FALL_L);
            DIG_R: next = dig ? (ground ? DIG_R : FALL_R) : (ground ? DIG_R : FALL_R);
            SPLAT: next = SPLAT;
		endcase
    end
   
    // Asynchronous Sequential Logic (Flip-Flop)
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT; 
            count <= 5'd0;
        end
        else begin
            if (count<5'd21) begin
                //SEE here -> count is updated from next state
                if (next==FALL_L) count <= count + 1'd1;
                else if (next==FALL_R) count <= count + 1'd1;
                else count <= 5'd0;
            end
            state <= next;
        end
	end
		
    // Output combinational block
    assign walk_left = (state==SPLAT) ? 1'b0 : (state==LEFT);
    assign walk_right = (state==SPLAT) ? 1'b0 : (state==RIGHT);
    assign aaah = (state==SPLAT) ? 1'b0 : ((state==FALL_L) | (state==FALL_R));
    assign digging = (state==SPLAT) ? 1'b0 : ((state==DIG_L) | (state==DIG_R));
endmodule
