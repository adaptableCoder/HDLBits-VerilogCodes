module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 
	
    integer count;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (count=0; count<512; count=count+1) begin
            	if (count-1 == -1) begin
                	q[count] <= 1'b0 ^ q[count+1];
            	end
            	else if (count+1 == 512) begin
                	q[count] <= q[count-1] ^ 1'b0;
            	end
            	else begin
            		q[count] <= q[count-1] ^ q[count+1];
            	end
            end
        end
    end
endmodule