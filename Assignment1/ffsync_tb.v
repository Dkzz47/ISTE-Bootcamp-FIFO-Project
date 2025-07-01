`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 14:54:22
// Design Name: 
// Module Name: ffsync_tb
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


module ffsync_tb( );
parameter SIZE = 4;
wire [SIZE-1:0] q2;
reg [SIZE-1:0] din;
reg wclk, wrst_n;

ff_sync #(SIZE) ff1(.q2(q2),.din(din),.clk(wclk),.rst_n(wrst_n));

always #5 wclk = ~wclk;


initial begin
wclk = 0;
wrst_n = 1;
din = 4'b0;
#50 wrst_n = 0;
#10 wrst_n = 1; 
#20 din = 4'b10;
#20 din = 4'b100;
#100;
$finish;

end

endmodule
