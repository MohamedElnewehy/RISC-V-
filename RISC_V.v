`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 10:31:21 PM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(
    input clk,
    input reset
);
    // internal wires
    wire [31:0] pc;          // Current PC
    wire [31:0] pc_next;     // Next PC
    wire [31:0] pc_plus4;    // PC + 4
    wire [31:0] pc_target;   // PC + Imm (branch/jump target)
    wire [31:0] instr;       // Instruction word

    wire [31:0] rd1;         // Register read data 1
    wire [31:0] rd2;         // Register read data 2
    wire [31:0] result;      // Data to write back into register file

    wire [31:0] imm_ext;     // Extended immediate (from sign_extender)

    // srcA == rd1
    wire signed [31:0] srcB;        // ALU second operand (after MUX)
    wire signed [31:0] alu_result;  // ALU output
    wire               zero;        // ALU zero flag
    wire               sign;        // ALU sign flag

    wire [31:0] read_data;   // Data read from memory
    wire [31:0] write_data;  // Data to write into memory (comes from rd2)

    // ========== Control signals ==========
    wire        PCSrc;       // Select between PC+4 and branch target
    wire        ResultSrc;   // Select between ALUResult and MemReadData
    wire        MemWrite;    // Enable write in Data Memory
    wire        ALUSrc;      // Select ALU operand B: reg or imm
    wire        RegWrite;    // Enable write in Register File
    wire [2:0]  ALUControl;  // ALU control input
    wire [1:0]  ImmSrc;      // Immediate format selector
// instants
ALU ALU0 (
    .ALUControl(ALUControl),
    .SrcA(rd1),
    .SrcB(srcB),
    .ALUResult(alu_result),
    .ZF(zero),
    .SF(sign)
);

Control_Unit Control(
    .OP(instr[6:0]),
    .funct3(instr[14:12]),
    .funct7(instr[30]),
    .zero(zero),
    .sign(sign),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUControl(ALUControl),
    .ALUsrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite)
);


Data_Memory DM(
    .clk(clk),
    .WE(MemWrite),
    .WD(rd2),                    // write_data comes from rd2
    .A(alu_result),         
    .RD(read_data)
);

Register_File RF(
    .clk(clk),
    .RST(reset),
    .WE3(RegWrite),
    .WD3(result),
    .A1(instr[19:15]),           // rs1
    .A2(instr[24:20]),           // rs2  
    .A3(instr[11:7]),            // rd
    .RD1(rd1),   
    .RD2(rd2)   
);

PC PC0(
    .clk(clk),
    .areset(reset),
    .nextAddress(pc_next),
    .PC(pc)
);

MUX_2to1 PC_MUX(
    .A(pc_target),               // Branch target
    .B(pc_plus4),                // PC + 4
    .S(PCSrc),                   // Control signal
    .C(pc_next)
);

MUX_2to1 Result_Mux(
    .A(read_data),               // Memory read data
    .B(alu_result),              // ALU result
    .S(ResultSrc),               // Control signal
    .C(result)
);

MUX_2to1 ALU_MUX(
    .A(imm_ext),                 // Immediate value
    .B(rd2),                     // Register value
    .S(ALUSrc),                  // Control signal
    .C(srcB)
);

Adder_32_bit Adder_PC0 (
    .A(pc),
    .B(imm_ext),
    .C(pc_target)
);

Adder_32_bit Adder_PC1 (
    .A(pc),
    .B(32'd4),
    .C(pc_plus4)
);

sign_extender Sx(
    .instr_31to7(instr),
    .ImmScr(ImmSrc),
    .ImmExt(imm_ext)
);

instruction_ROM IR(
    .A(pc),                 
    .instruction(instr)
);
endmodule