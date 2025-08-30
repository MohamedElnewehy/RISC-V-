`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:38:18 AM
// Design Name: 
// Module Name: 32_bit_Adder
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


module Adder_32_bit(
    input  wire  [31:0] A,
    input  wire  [31:0] B,
    output wire  [31:0] C
    );
    
    assign C = A + B;
endmodule
