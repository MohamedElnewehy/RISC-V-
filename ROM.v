`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:48:14 AM
// Design Name: 
// Module Name: ROM
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


module instruction_ROM(
    input wire  [31:0] A,           // input PC (address) -- PC/4 becouse first two bits are always zeros
    output wire [31:0] instruction  // output instruction
    );
    // 2D memory
    reg [31:0] Mem [0:63];
    // data
    initial begin
    $readmemh("fib.mem", Mem);   end
    // logic
    assign instruction = Mem [A[31:2]];
endmodule
