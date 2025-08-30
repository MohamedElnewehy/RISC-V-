`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 01:00:04 AM
// Design Name: 
// Module Name: RISC_V_tb
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


module RISC_V_tb();
    reg clk;
    reg reset;
    
    RISC_V uut(
        .clk(clk),
        .reset(reset)
    );
    
    initial clk = 0;
    always #50 clk = ~clk;
    
    initial begin
        reset = 1;
        #2;
        reset = 0; // release reset ??? 20ns
        #2;
        reset = 1;
    end

    // Monitor Outputs
    always@(posedge clk)
    begin
        $display("Time=%0t | PC=%h | Instruction=%h", 
                 $time, uut.pc, uut.instr);
    end
endmodule
