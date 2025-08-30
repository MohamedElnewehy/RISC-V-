`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 09:16:30 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input  wire         clk,   // input clock signal
    input  wire         WE,    // input write enable
    input  wire  [31:0] WD,    // input data bus
    input  wire  [31:0] A,     // input Read/write adderss 
    output wire  [31:0] RD     // output data bus
    );
    // Data_Memory
    reg [31:0] Data_Memory [0:63];
    // Read Asynchronously
    assign RD = Data_Memory [A[31:2]];
    // Write Synchronously
    always@(posedge clk)
    begin
        if(WE)
            Data_Memory[A[31:2]] <= WD;
        // no need for else to keep data becouse it is already in registers
    end
endmodule
