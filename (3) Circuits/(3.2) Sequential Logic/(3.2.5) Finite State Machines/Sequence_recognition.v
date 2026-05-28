module top_module(
    input clk,
    input reset, // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter NONE=4'd0, ONE=4'd1, TWO=4'd2, THREE=4'd3, FOUR=4'd4, FIVE=4'd5, SIX=4'd6, ERROR=4'd7, DISCARD=4'd8, FLAG=4'd9;
    reg [3:0] state, next;
    
    always @(*) begin
        case(state)
            NONE: next = in ? ONE: NONE;
            ONE: next = in ? TWO: NONE;
            TWO: next = in ? THREE : NONE;
            THREE: next = in ? FOUR : NONE;
            FOUR: next = in ? FIVE : NONE;
            FIVE: next = in ? SIX : DISCARD;
            SIX: next = in ? ERROR : FLAG;
            ERROR: next = in ? ERROR : NONE;
            DISCARD: next = in ? ONE : NONE;
            FLAG: next = in ? ONE : NONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) state <= NONE;
        else state <= next;
    end
    
    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);     
endmodule