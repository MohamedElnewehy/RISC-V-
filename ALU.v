`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 11:26:26 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input  wire [2:0]  ALUControl, // choose ALU functionality
    input  wire [31:0] SrcA,       // first input bus
    input  wire [31:0] SrcB,       // second input bus
    output reg  [31:0] ALUResult,  // AlU result
    output wire        ZF,         // ALU zero flag -- wired to be assigned
    output wire        SF          // ALU sign flag -- wired to be assigned
    );
    // flags assignment
    assign ZF = (ALUResult == 32'd0);
    assign SF = ALUResult[31];
    // always block for ALU functions
    always@(*)
    begin
        case(ALUControl)
            3'b000:  ALUResult = SrcA + SrcB;
            3'b001:  ALUResult = SrcA << SrcB;
            3'b010:  ALUResult = SrcA - SrcB;
            3'b100:  ALUResult = SrcA ^ SrcB;
            3'b101:  ALUResult = SrcA >> SrcB;
            3'b110:  ALUResult = SrcA | SrcB;
            3'b111:  ALUResult = SrcA & SrcB;
            default: ALUResult = 32'd0;         // To handel case ALUControl = 011
        endcase
    end
endmodule
