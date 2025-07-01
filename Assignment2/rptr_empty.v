`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 12:17:26
// Design Name: 
// Module Name: rptr_empty
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

module rptr_empty #(parameter ADDR_SIZE = 4)(
    output reg rempty,                  // Empty flag
    output [ADDR_SIZE-1:0] raddr,       // Read address
    output reg [ADDR_SIZE :0] rptr,     // Read pointer
    input [ADDR_SIZE :0] wptr,      // Write pointer from write domain
    input rinc, rclk, rrst_n            // Read increment, read-clock, and reset
    );

    reg [ADDR_SIZE:0] rbin;                     // Binary read pointer
    reg [ADDR_SIZE:0] rq1_wptr, rq2_wptr;
    wire [ADDR_SIZE:0] rgray_next, rbin_next;   // Next read pointer in gray and binary code
    wire rempty_val;                            // Empty flag value
    

    // Synchronous FIFO read pointer (gray code)
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n)                // Reset the FIFO
            {rbin, rptr} <= 0;
        else 
            {rbin, rptr} <= {rbin_next, rgray_next};  // Shift the read pointer
    end
    
    
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rq1_wptr <= 0;
            rq2_wptr <= 0;
        end else begin
            rq1_wptr <= wptr;
            rq2_wptr <= rq1_wptr;
    end
   end
    

    assign raddr = rbin[ADDR_SIZE-1:0];                 // Read address calculation from the read pointer
    assign rbin_next = rbin + (rinc & ~rempty);         // Increment the read pointer if not empty
    assign rgray_next = (rbin_next>>1) ^ rbin_next;     // Convert binary to gray code

    // Check if the FIFO is empty
    assign rempty_val = (rgray_next == rq2_wptr);       // Empty flag calculation

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n)                // Reset the empty flag
            rempty <= 1'b1;
        else 
            rempty <= rempty_val;  // Update the empty flag
    end
    
endmodule

module wptr_full #(parameter ADDR_SIZE = 4)(
    output reg wfull,                   // Full flag
    output [ADDR_SIZE-1:0] waddr,       // Write address
    output reg [ADDR_SIZE :0] wptr,     // Write pointer
    output reg [ADDR_SIZE:0]  wq2_rptr,
    input [ADDR_SIZE :0] rptr,      // Read pointer 
    input winc, wclk, wrst_n            // Write increment, write-clock, and reset
    );

    reg [ADDR_SIZE:0] wbin;                     // Binary write pointer
    reg [ADDR_SIZE:0] wq1_rptr;
    wire [ADDR_SIZE:0] wgray_next, wbin_next;   // Next write pointer in gray and binary code
    wire wfull_val;                             // Full flag value
    
    // Synchronous FIFO write pointer (gray code)
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n)            // Reset the FIFO
            {wbin, wptr} <= 0;
        else 
            {wbin, wptr} <= {wbin_next, wgray_next}; // Shift the write pointer
    end


    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wq1_rptr <= 0;
            wq2_rptr <= 0;
        end else begin
            wq1_rptr <= rptr;
            wq2_rptr <= wq1_rptr;
    end
   end
   
   
    assign waddr = wbin[ADDR_SIZE-1:0];             // Write address calculation from the write pointer
    assign wbin_next = wbin + (winc & ~wfull);       // Increment the write pointer if not full
    assign wgray_next = (wbin_next>>1) ^ wbin_next;    // Convert binary to gray code

    // Check if the FIFO is full
    //------------------------------------------------------------------
    // Simplified version of the three necessary full-tests:
    // assign wfull_val=((wg_next[ADDR_SIZE] !=wq2_rptr[ADDR_SIZE] ) &&
    // (wg_next[ADDR_SIZE-1] !=wq2_rptr[ADDR_SIZE-1]) &&
    // (wg_next[ADDR_SIZE-2:0]==wq2_rptr[ADDR_SIZE-2:0]));
    //------------------------------------------------------------------
    assign wfull_val = (wgray_next=={~wq2_rptr[ADDR_SIZE:ADDR_SIZE-1], wq2_rptr[ADDR_SIZE-2:0]});

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n)            // Reset the full flag
            wfull <= 1'b0;
        else 
            wfull <= wfull_val; // Update the full flag
    end
endmodule
