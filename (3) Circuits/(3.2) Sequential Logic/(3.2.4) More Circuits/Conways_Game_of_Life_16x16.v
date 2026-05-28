module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    reg [17:0][17:0] state;
    reg [15:0][15:0] next;
    
    // creating a padded q -> 18x18 for easy comparing (basically precalculated wraps)
    integer i;
    always @(*) begin
        for(i=0;i<16;i=i+1) begin
            state[i+1] = {q[i*16], q[i*16 +: 16], q[(i*16)+15]}; //Verilog-2001: q[i*16 +: 16]
        end
        state[0] = state[16];
        state[17] = state[1];
    end
    
    // calulating the sum from padded q (state), and using aa mux to assign new (next) value
    reg [3:0] sum;
    integer r,c;
    always @(*) begin
        for(r=0;r<16;r=r+1) begin
            for(c=0;c<16;c=c+1) begin
                sum = state[r][c] + state[r][c+1] + state[r][c+2] + state[r+1][c] + state[r+1][c+2] + state[r+2][c] + state[r+2][c+1] + state[r+2][c+2];
                case(sum)
                    4'd2:next[r][c]=state[r+1][c+1];
                    4'd3:next[r][c]=1;
                    default: next[r][c]=0;
                endcase
            end
        end
    end
    
    // simple sequential part
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= next;
    end
endmodule