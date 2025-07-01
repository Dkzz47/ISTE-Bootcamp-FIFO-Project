`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 13:08:26
// Design Name: 
// Module Name: w_r_ptr_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module w_r_ptr_tb( );
parameter addr_size = 4;
wire rempty;
wire [addr_size-1:0] raddr;
wire [addr_size:0] rptr;
reg rinc, rclk, rrst_n;

wire wfull;
wire [addr_size-1:0] waddr;
wire [addr_size:0] wptr, wq2_rptr;
reg winc, wclk, wrst_n;

top_fifo #(addr_size) t1 (wfull, rempty, waddr, raddr, wptr, wq2_rptr, rptr, winc, wclk, wrst_n, rinc, rclk, rrst_n);

always #5 wclk = ~wclk;
always #10 rclk = ~rclk;

initial begin
        // Initialize all signals
        wclk = 0;
        rclk = 0;
        wrst_n = 1;     // Active low reset
        rrst_n = 1;     // Active low reset
        winc = 0;
        rinc = 0;

        // Reset the FIFO
        #40 wrst_n = 0; rrst_n = 0;
        #40 wrst_n = 1; rrst_n = 1;
        
        repeat (30) begin
            @(posedge wclk);
            if (!wfull) begin
                winc = 1;
                $display("[%t] Writing to FIFO. waddr=%0d", $time, waddr);
            end else begin
                winc = 0;
                $display("[%t] FIFO Full. Cannot write.", $time);
            end
        end
        winc = 0;

        // Delay before starting read

        // Start reading from FIFO
        repeat (30) begin
            @(posedge rclk);
            if (!rempty) begin
                rinc = 1;
                $display("[%t] Reading from FIFO. raddr=%0d", $time, raddr);
            end else begin
                rinc = 0;
                $display("[%t] FIFO Empty. Cannot read.", $time);
            end
        end
        rinc = 0;

        #50;
        $display("Simulation complete.");
        $finish;
end
endmodule
