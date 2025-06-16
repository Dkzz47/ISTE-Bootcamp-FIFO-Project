`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 13:16:00
// Design Name: 
// Module Name: mem_tb
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


module mem_tb( );
parameter DSIZE = 8;
parameter ADDR_SIZE = 4;

wire [DSIZE-1:0] rdata;
reg [DSIZE-1:0] wdata;
reg [ADDR_SIZE-1:0] waddr, raddr;
reg winc, wclk;
integer i = 0;

FIFO_Memory #(DSIZE,ADDR_SIZE) f1(.rdata(rdata),.wdata(wdata),.waddr(waddr),.raddr(raddr),.wclk_en(winc),.wclk(wclk));

always #5 wclk = ~wclk;

initial begin
wclk = 0;
wdata = 8'b0;
waddr = 4'b0;
raddr = 4'b0;

winc = 0;

#40 winc = 1;
for (i=0; i <10; i = i+1) begin
wdata = wdata + 8'b100;
waddr = waddr + 4'b1;
#10;
end
#100;
for (i=0; i<10; i=i+1) begin
raddr = raddr + 4'b1;
#10;
end
end



endmodule
