`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:48:34 AM
// Design Name: 
// Module Name: Register_File
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
/*? The Register File contains the 32-bit registers.
? The register file has two read output ports (RD1 and RD2) and a single input
write port (WD3), RD1 and RD2 are read with no respect to the clock edge.
? The register file is read asynchronously and written synchronously at the
rising edge of the clock.
? The register file supports simultaneous read and writes. The register file
has width = 32 bits and depth = 32 entries supports simultaneous read and
writes.
? The register file has active low asynchronous reset signal.
? A1 is the register address from which the data are read through the output
port RD1. Whereas A2 is corresponding to the register address of output
port RD2.*/
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Register_File(
    input wire        clk, // input clock signal
    input wire        RST, // input reset signal
    input wire        WE3, // input write enable
    input wire [31:0] WD3, // input write port
    input wire [4:0]  A1,  // Address from which the data are read through the output port RD1
    input wire [4:0]  A2,  // Address from which the data are read through the output port RD2
    input wire [4:0]  A3,  // Storing Dara Address 
    output reg [31:0] RD1, // output bus 1 port
    output reg [31:0] RD2  // output bus 2 port
    );
    // Memory
    reg [31:0] Register_File [0:31];
    // Read Asynchronously
    integer i = 0;
    always@(*)
    begin
        RD1 = Register_File [A1];
        RD2 = Register_File [A2];
    end
    // Write Synchronously
    always@(posedge clk or negedge RST)
    begin
        if(!RST) 
             for(i = 0 ; i < 32 ; i = i + 1)
                    Register_File [i] <= 32'b0;
        else if(WE3 && A3!=5'd0) 
             Register_File [A3] <= WD3;
        // no need for else to keep data becouse it is already in registers
    end
endmodule
