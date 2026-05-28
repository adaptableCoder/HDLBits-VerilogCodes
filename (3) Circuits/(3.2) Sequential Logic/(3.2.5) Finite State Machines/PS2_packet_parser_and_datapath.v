module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter BYTE1=2'd0,  BYTE2=2'd1, BYTE3=2'd2, DONE=2'd3;
    reg [1:0] state, next, prev;

    // State transition logic (combinational)
    always @(*) begin
        case(state)
            BYTE1: next = in[3] ? BYTE2 : BYTE1;
            BYTE2: next = BYTE3;
            BYTE3: next = DONE;
            DONE: next = in[3] ? BYTE2 : BYTE1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) state <= BYTE1;
        else state <= next;
        prev <= state;
    end
 
    // Output logic
    assign done = (state == DONE);

    // New: Datapath to store incoming bytes.
    reg [7:0] byte1, byte2, byte3;
    always @(posedge clk) begin
        case (state)
            BYTE1: byte1 <= in;
            BYTE2: byte2 <= in;
            BYTE3: byte3 <= in;
            DONE: byte1 <= in;
        endcase
     end
    assign out_bytes = {byte1,byte2,byte3};
endmodule
