module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    // Added a parityState to account for the 9th bit
    parameter startBit=3'd0, data=3'd1, parityState=3'd2, stopBit=3'd3, recovery=3'd4, doneState=3'd5;
    reg [2:0] state, next;
    reg [3:0] count = 4'd0;
    
    wire odd;
    // Reset parity when idling, recovering, or done
    wire parity_reset = (state == startBit) || (state == recovery) || (state == doneState) || reset;
    
    parity p1 (.clk(clk), .reset(parity_reset), .in(in), .odd(odd));

    // --- Next State Logic ---
    always @(*) begin
        case(state)
            startBit: next = in ? startBit : data;
            data: next = (count == 4'd7) ? parityState : data; // Exit after 8 bits
            parityState: next = stopBit; // Wait 1 cycle for parity bit
            stopBit: next = in ? (odd ? doneState : startBit) : recovery;
            recovery: next = in ? startBit : recovery;
            doneState: next = in ? startBit : data;
            default: next = startBit;
        endcase
    end
    
    // --- FSM Sequential Logic ---
    always @(posedge clk) begin
        if(reset) state <= startBit;
        else state <= next;
    end
    
    // --- Counter Logic ---
    always @(posedge clk) begin
        if(reset) count <= 4'd0;
        else if(state == data) count <= count + 4'd1;
        else count <= 4'd0;
    end
    
    // --- Datapath Logic ---
    always @(posedge clk) begin
        if (state == data) out_byte[count] <= in;
    end

    // --- Output Logic ---
    assign done = (state == doneState);
endmodule