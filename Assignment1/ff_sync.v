`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 14:42:12
// Design Name: 
// Module Name: ff_sync
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


module ff_sync #(parameter SIZE = 4)( 
    output reg [SIZE-1:0] q2,   // Output of the second flip-flop
    input [SIZE-1:0] din,       // Input data
    input clk, rst_n           // Clock and reset
    );

    reg [SIZE-1:0] q1; // Output of the first flip-flop

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            {q2, q1} <= 0;          // Reset the FIFO
        else 
            {q2, q1} <= {q1, din};  // Shift the data
    end 

endmodule
    
