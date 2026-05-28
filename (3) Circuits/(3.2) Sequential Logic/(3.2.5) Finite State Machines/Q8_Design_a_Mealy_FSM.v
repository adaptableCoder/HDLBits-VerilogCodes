module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter ONE=2'd0, TWO=2'd1, THREE=2'd2;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            ONE: next = x ? TWO : ONE;
            TWO: next = x ? TWO : THREE ;
            THREE: next = x ? TWO : ONE;
        endcase
    end
    
    always @(posedge clk, negedge aresetn) begin
        if(!aresetn) state <= ONE;
        else state <= next;
    end
    
    assign z = (state == THREE) & x;
endmodule