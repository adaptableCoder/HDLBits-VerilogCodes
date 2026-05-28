module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    parameter startBit=3'd0, data=3'd1, stopBit=3'd2, recovery=3'd3, doneState=3'd4;
    reg [2:0] state, next;
    reg [2:0] count = 3'd0;
    
    always @(*) begin
        case(state)
            startBit: next = in ? startBit : data;
            data: next = (count==3'd7) ? stopBit : data;
            stopBit: next = in ? doneState : recovery;
            recovery: next = in ? startBit : recovery;
            doneState: next = in ? startBit : data;
            default: next = startBit;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= startBit;
            count <= 3'd0;
        end
        else begin
            state <= next;
            if (state == data)
                count <= count + 3'd1;
            else
                count <= 3'd0;
        end
    end

    assign done = (state == doneState);
    
    // New: Datapath to store incoming data.
    always @(posedge clk) begin
        if (state == data) out_byte[count] = in;
     end
endmodule