module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5;
    reg [3:1] next;
    
    always @(*) begin
        case(y)
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
        endcase
    end
    
    assign Y2 = next[2];
endmodule
