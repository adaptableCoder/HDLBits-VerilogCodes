module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);
    parameter A=1'd0, B=1'd1;
    reg next,state;
    reg [1:0] count;
    reg [2:0] data;
    
    always @(*) begin
        case(state)
            A: next = s ? B : A;
            B: next = B;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 2'd0;
            data <= 3'b000;
            z <= 1'b0;
        end
        else begin
            state <= next;
            if (state == B) begin
                count <= (count == 2'd2) ? 2'd0 : count + 2'd1;
                data <= {data[1:0], w};
                if (count == 2'd2) begin
                    case ({data[1:0], w})
                        3'b011: z <= 1'b1;
                        3'b101: z <= 1'b1;
                        3'b110: z <= 1'b1;
                        default: z <= 1'b0;
                    endcase
                end
                else z <= 1'b0;
            end
            else begin
                z <= 1'b0;
            end
        end
    end
endmodule