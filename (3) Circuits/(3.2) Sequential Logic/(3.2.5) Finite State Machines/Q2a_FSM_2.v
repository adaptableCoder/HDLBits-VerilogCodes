module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            A: begin
                if (r==3'b000) next = A;
                else if (r[1]==1'b1) next = B;
                else if (r[2:1]==2'b10) next = C;
                else if (r==3'b100) next = D;
            end
            B: next = r[1] ? B : A;
            C: next = r[2] ? C : A;
            D: next = r[3] ? D : A;
        endcase
    end
    
    always @(posedge clk) begin
        if(!resetn) state <= A;
        else state <= next;
    end
    
    always @(*) begin
        case(state)
            A: g = 3'b000;
            B: g[1] = 1'b1;
            C: g[2] = 1'b1;
            D: g[3] = 1'b1;
        endcase
    end
endmodule
