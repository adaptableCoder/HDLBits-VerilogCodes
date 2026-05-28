module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [1:0] PHT [127:0];
    wire [6:0] read_index;
    wire [6:0] training_index;
    wire [1:0] prediction;
    
    assign read_index = predict_pc ^ predict_history;
    assign training_index = train_pc ^ train_history;
    assign prediction = PHT[read_index];
    assign predict_taken = prediction[1];
    
    integer i;
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            predict_history <= 0;
            for (i=0;i<128;i=i+1) begin
                PHT[i] = 2'b01;
            end
        end
        else begin
            if (train_valid & train_mispredicted) begin
                predict_history <= {train_history[5:0], train_taken};
            end
            else if (predict_valid) begin
                predict_history <= {predict_history[5:0], predict_taken};
            end
            if (train_valid) begin
                if (train_taken) begin
                    if (PHT[training_index]!=2'b11) PHT[training_index] <= PHT[training_index]+1;
                end
                else begin
                    if (PHT[training_index]!=2'b00) PHT[training_index] <= PHT[training_index]-1;
                end
            end
        end
    end
endmodule