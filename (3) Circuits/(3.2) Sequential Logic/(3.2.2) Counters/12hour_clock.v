module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 1'b0;
        end
        else if (ena) begin
            
            // ----------------------------------------------------
            // SECONDS LOGIC (Increments every enabled cycle)
            // ----------------------------------------------------
            if (ss == 8'h59) begin
                ss <= 8'h00;
            end 
            else if (ss[3:0] == 4'd9) begin
                ss[7:4] <= ss[7:4] + 1'd1;
                ss[3:0] <= 4'd0;
            end 
            else begin
                ss[3:0] <= ss[3:0] + 1'd1;
            end

            // ----------------------------------------------------
            // MINUTES LOGIC (Only triggers when seconds hit 59)
            // ----------------------------------------------------
            if (ss == 8'h59) begin
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                end 
                else if (mm[3:0] == 4'd9) begin
                    mm[7:4] <= mm[7:4] + 1'd1;
                    mm[3:0] <= 4'd0;
                end 
                else begin
                    mm[3:0] <= mm[3:0] + 1'd1;
                end
            end

            // ----------------------------------------------------
            // HOURS LOGIC (Only triggers when minutes & seconds hit 59)
            // ----------------------------------------------------
            if (ss == 8'h59 && mm == 8'h59) begin
                if (hh == 8'h12) begin
                    hh <= 8'h01;
                end 
                else if (hh[3:0] == 4'd9) begin
                    hh[7:4] <= hh[7:4] + 1'd1;
                    hh[3:0] <= 4'd0;
                end 
                else begin
                    hh[3:0] <= hh[3:0] + 1'd1;
                end
            end

            // ----------------------------------------------------
            // PM LOGIC (Toggles at 11:59:59 AM/PM)
            // ----------------------------------------------------
            if (ss == 8'h59 && mm == 8'h59 && hh == 8'h11) begin
                pm <= ~pm;
            end
         
        end
    end
endmodule