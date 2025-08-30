`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 09:27:31 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input wire [6:0]   OP,          
    input wire [2:0]   funct3,
    input wire         funct7,
    input wire         zero, // zero flag
    input wire         sign, // sign flag
    output reg         PCSrc,
    output reg         ResultSrc,
    output reg         MemWrite,
    output reg [2:0]   ALUControl,
    output reg         ALUsrc,
    output reg [1:0]   ImmSrc,
    output reg         RegWrite
    );
    // internal ignals
    reg  Branch;
    wire Beq; // branch if equal
    wire Bnq; // branch if not equal
    wire Blt; // branch if less than
    reg [1:0] ALUOP;
    // main decoder
    always@(*)
    begin
        case(OP)
            7'b000_0011: begin               // load
                RegWrite = 1'b1 ; 
                ImmSrc = 2'b00 ;
                ALUsrc = 1'b1;
                MemWrite = 1'b0;
                ResultSrc = 1'b1;
                Branch = 1'b0;
                ALUOP = 2'b00;
            end
            7'b010_0011: begin               // store
                RegWrite = 1'b0 ;
                ImmSrc = 2'b01 ;
                ALUsrc = 1'b1;
                MemWrite = 1'b1;
                ResultSrc = 1'bx;
                Branch = 1'b0;
                ALUOP = 2'b00;
            end
            7'b011_0011: begin               // R-type
                RegWrite = 1'b1 ;
                ImmSrc = 2'bxx ;
                ALUsrc = 1'b0;
                MemWrite = 1'b0;
                ResultSrc = 1'b0;
                Branch = 1'b0;
                ALUOP = 2'b10;
            end
            7'b001_0011: begin               // I-type
                RegWrite = 1'b1 ;
                ImmSrc = 2'b00 ;
                ALUsrc = 1'b1;
                MemWrite = 1'b0;
                ResultSrc = 1'b0;
                Branch = 1'b0;
                ALUOP = 2'b10;
            end
            7'b110_0011: begin               // Branch instructions
                RegWrite = 1'b0 ;
                ImmSrc = 2'b10 ;
                ALUsrc = 1'b0;
                MemWrite = 1'b0;
                ResultSrc = 1'bx;
                Branch = 1'b1;
                ALUOP = 2'b01;
            end
            default: begin
                RegWrite = 1'b0 ;
                ImmSrc = 2'b00 ;
                ALUsrc = 1'b0;
                MemWrite = 1'b0;
                ResultSrc = 1'b0;
                Branch = 1'b0;
                ALUOP = 2'b00;
            end
        endcase
    end
    // ALU Decoder
    always@(*)
    begin
        casex({ALUOP, funct3, OP[5], funct7})
            7'b00_XXX_X_X: ALUControl = 3'b000;
            
            7'b01_000_X_X: ALUControl = 3'b010;
            7'b01_001_X_X: ALUControl = 3'b010;
            7'b01_100_X_X: ALUControl = 3'b010;
            
            7'b10_000_0_0: ALUControl = 3'b000;
            7'b10_000_0_1: ALUControl = 3'b000;
            7'b10_000_1_0: ALUControl = 3'b000;
            7'b10_000_1_1: ALUControl = 3'b010;
            7'b10_001_X_X: ALUControl = 3'b001;
            7'b10_100_X_X: ALUControl = 3'b100;
            7'b10_101_X_X: ALUControl = 3'b101;
            7'b10_110_X_X: ALUControl = 3'b110;
            7'b10_111_X_X: ALUControl = 3'b111;
            
            default: ALUControl = 3'b000;
      endcase          
    end
    // PCSrc logic
    assign Beq = Branch & zero;
    assign Bnq = Branch & ~zero;
    assign Blt = Branch & sign;
    always@(*)
    begin
        if(ALUOP == 2'b01)
        case(funct3)
            3'b000: PCSrc = Beq;
            3'b001: PCSrc = Bnq;
            3'b100: PCSrc = Blt;
            default: PCSrc = 1'b0;
        endcase
        else
            PCSrc = 1'b0;
    end
endmodule
