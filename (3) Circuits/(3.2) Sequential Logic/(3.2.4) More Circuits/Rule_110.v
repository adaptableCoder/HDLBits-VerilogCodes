module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 
    integer count;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (count=0; count<512; count=count+1) begin
            	if (count-1 == -1) begin
                    q[count] <= (q[count] ^ 1'b0) | (~q[count+1] & q[count]);
            	end
            	else if (count+1 == 512) begin
                    q[count] <= (q[count] ^ q[count-1]) | (~(1'b0) & q[count]);
            	end
            	else begin
                    q[count] <= (q[count] ^ q[count-1]) | (~q[count+1] & q[count]);
            	end
            end
        end
    end
    
    //Other way
    //wire [511:0] right = {q[510:0], 1'b0};  // Shifted left to bring right neighbor in
	//wire [511:0] left  = {1'b0, q[511:1]};  // Shifted right to bring left neighbor in

	//always @(posedge clk) begin
    //if (load)
        //q <= data;
    //else
        //q <= (q ^ right) | (~left & q);
	//end
endmodule