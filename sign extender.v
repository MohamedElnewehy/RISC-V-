`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 12:06:01 AM
// Design Name: 
// Module Name: sign extender
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


module sign_extender(
    input wire [31:0] instr_31to7,
    input wire [1:0]  ImmScr,
    output reg [31:0] ImmExt
    );
    // sign_extender logic
    always@(*)
    begin
        case(ImmScr)
            2'b00: begin
                ImmExt = {{20{instr_31to7[31]}}, instr_31to7[31:20]}; // for I type
            end
            2'b01: begin
                ImmExt = {{20{instr_31to7[31]}}, instr_31to7[31:25], instr_31to7[11:7]}; // for S type
            end
            2'b10: begin
                ImmExt = {{20{instr_31to7[31]}}, instr_31to7[7], instr_31to7[30:25], instr_31to7[11:8], 1'b0}; // for B type
            end
            default: ImmExt = {{20{instr_31to7[31]}}, instr_31to7[31:20]};
         endcase
    end
endmodule
