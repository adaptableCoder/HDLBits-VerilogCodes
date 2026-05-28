module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter ZERO=2'd0, FIRST_ONE=2'd1, AFTER=2'd2;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            ZERO: next = x ? FIRST_ONE : ZERO;
            FIRST_ONE: next = x ? AFTER : FIRST_ONE;
            AFTER: next = x ? AFTER : FIRST_ONE;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset) state <= ZERO;
        else state <= next;
    end
    
    always @(*) begin
        case(state)
            ZERO: z = 1'b0;
            FIRST_ONE: z = 1'b1;
            AFTER: z = 1'b0;
        endcase
    end
endmodule