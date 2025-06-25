`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 13:46:56
// Design Name: 
// Module Name: top_fifo
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


module top_fifo #(parameter ASIZE = 4)
(   output wfull,                   // Write full signal
    output rempty,                  // Read empty signal
    output [ASIZE-1:0] waddr, raddr,
    output [ASIZE:0] wptr, rptr, wq2_rptr,
    input winc, wclk, wrst_n,       // Write increment, write clock, write reset
    input rinc, rclk, rrst_n        // Read increment, read clock, read reset
    );

  



    rptr_empty #(ASIZE) rptr_empty(         // Read pointer and empty signal handling
        .rempty(rempty),
        .raddr(raddr),
        .rptr(rptr), 
        .wptr(wptr),
        .rinc(rinc), 
        .rclk(rclk),
        .rrst_n(rrst_n)
    );

    wptr_full #(ASIZE) wptr_full(           // Write pointer and full signal handling
        .wfull(wfull), 
        .waddr(waddr),
        .wptr(wptr), 
        .wq2_rptr(wq2_rptr),
        .rptr(rptr),
        .winc(winc), 
        .wclk(wclk),
        .wrst_n(wrst_n)
    );

endmodule

