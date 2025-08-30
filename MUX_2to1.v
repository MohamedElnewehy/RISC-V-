`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:07:17 AM
// Design Name: 
// Module Name: MUX_2to1
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


module MUX_2to1 (
    input wire  [31 : 0] A,
    input wire  [31 : 0] B,
    input wire           S,
    output reg  [31 : 0] C
    );
    always@(*) begin
        if(S == 1'b1) C = A;
        else          C = B; end
endmodule
