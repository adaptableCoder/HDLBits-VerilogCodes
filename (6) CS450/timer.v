module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] count;
    
    always @(posedge clk) begin
        if(load) count <= data;
        else begin
            if (count==10'd0) count <= count;
            else count <= count - 1;
        end
    end
    
    assign tc = (count==10'd0);
endmodule
