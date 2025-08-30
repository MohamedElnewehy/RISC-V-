`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 11:42:22 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input wire        clk,         // clock signal 
    input wire        areset,      // Asynchronous reset
    //input wire        load,      // always high except for the HLT instruction
    input wire [31:0] nextAddress, // the next instruction's address 
    output reg [31:0] PC           // instruction pointer register
    );
    // internal reg
    reg [31:0] PC_next;
    // PC synchronous always
    always@(posedge clk or negedge areset)
    begin
        if(!areset) PC <= 32'd0;   // Active low Asynchronous reset
        else        PC <= PC_next;
    end
    // PC content logic
    always@(*)
    begin
       /* if(load)*/ PC_next = nextAddress;
       //else     PC_next <= PC_next;
    end    
endmodule
