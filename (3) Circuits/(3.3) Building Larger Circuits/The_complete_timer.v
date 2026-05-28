module count1k (
    input clk,
    input reset,
    input count_ena,
    output done1k);
    
    reg [9:0] q;
    always @(posedge clk) begin
        if (reset | ~count_ena) q <= 10'd0;
        else if (q == 10'd999) q <= 10'd0;
        else q <= q + 10'd1;
    end
    assign done1k = (q == 10'd999); 
endmodule

module shiftcount (
    input clk,
    input done1k,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena) q <= {q[2:0], data};
        else if (count_ena & done1k) q <= q - 1'd1;
    end
endmodule

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter S=4'd0, S1=4'd1, S11=4'd2, S110=4'd3, B0=4'd4, B1=4'd5, B2=4'd6, B3=4'd7, Count=4'd8, Wait=4'd9;
    reg [3:0] state, next;
    wire shift_ena, done_counting, done1k;
    
    always @(*) begin
        case (state)
            S: next = data ? S1 : S;
            S1: next = data ? S11 : S;
            S11: next = data ? S11 : S110;
            S110: next = data ? B0 : S;
            B0: next = B1;
            B1: next = B2;
            B2: next = B3;
            B3: next = Count;
            Count: next = done_counting ? Wait : Count;
            Wait: next = ack ? S : Wait;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= S;
        else state <= next;
    end
    
    assign shift_ena = (state==B0) | (state==B1) | (state==B2) | (state==B3) ;
    assign counting = (state==Count);
    assign done = (state==Wait);
    assign done_counting = (count == 4'd0) & done1k;
    
    shiftcount C1 (.clk(clk), .done1k(done1k), .shift_ena(shift_ena), .count_ena(counting), .data(data), .q(count));
    count1k C2 (.clk(clk), .reset(reset), .done1k(done1k), .count_ena(counting));
endmodule