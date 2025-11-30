// OPCODE
`timescale 1ns/1ps
`define R_TYPE        7'b0110011
`define I_TYPE_OP_IMM 7'b0010011
`define I_TYPE_LOAD   7'b0000011
`define S_TYPE        7'b0100011
`define B_TYPE        7'b1100011
`define J_TYPE        7'b1101111
`define I_TYPE_JALR   7'b1100111
`define U_TYPE_LUI    7'b0110111
`define U_TYPE_AUIPC  7'b0010111

// FUNCT3
// R_TYPE
`define FUNCT3_ADD  3'h0
`define FUNCT3_SUB  3'h0
`define FUNCT3_XOR  3'h4
`define FUNCT3_OR   3'h6
`define FUNCT3_AND  3'h7
`define FUNCT3_SLL  3'h1
`define FUNCT3_SRL  3'h5
`define FUNCT3_SRA  3'h5
`define FUNCT3_SLT  3'h2
`define FUNCT3_SLTU 3'h3
// I_TYPE_OP_IMM
`define FUNCT3_ADDI  3'h0
`define FUNCT3_XORI  3'h4
`define FUNCT3_ORI   3'h6
`define FUNCT3_ANDI  3'h7
`define FUNCT3_SLLI  3'h1
`define FUNCT3_SRLI  3'h5
`define FUNCT3_SRAI  3'h5
`define FUNCT3_SLTI  3'h2
`define FUNCT3_SLTIU 3'h3
// I_TYPE_LOAD
`define FUNCT3_LB  3'h0
`define FUNCT3_LH  3'h1
`define FUNCT3_LW  3'h2
`define FUNCT3_LBU 3'h4
`define FUNCT3_LHU 3'h5
// S_TYPE
`define FUNCT3_SB 3'h0
`define FUNCT3_SH 3'h1
`define FUNCT3_SW 3'h2
// B_TYPE
`define FUNCT3_BEQ  3'h0
`define FUNCT3_BNE  3'h1
`define FUNCT3_BLT  3'h4
`define FUNCT3_BGE  3'h5
`define FUNCT3_BLTU 3'h6
`define FUNCT3_BGEU 3'h7
// J_TYPE
`define FUNCT3_JAL  3'h0  // no funct3
// I_TYPE_JALR
`define FUNCT3_JALR 3'h0
// U_TYPE_LUI
`define FUNCT3_LUI   3'h0 // no funct3
// U_TYPE_AUIPC
`define FUNCT3_AUIPC 3'h0 // no funct3

// FUNCT7
// R_TYPE
`define FUNCT7_ADD  7'h00
`define FUNCT7_SUB  7'h20
`define FUNCT7_XOR  7'h00
`define FUNCT7_OR   7'h00
`define FUNCT7_AND  7'h00
`define FUNCT7_SLL  7'h00
`define FUNCT7_SRL  7'h00
`define FUNCT7_SRA  7'h20
`define FUNCT7_SLT  7'h00
`define FUNCT7_SLTU 7'h00
// I_TYPE_OP_IMM
`define FUNCT7_ADDI  7'h00 // no funct7
`define FUNCT7_XORI  7'h00 // no funct7
`define FUNCT7_ORI   7'h00 // no funct7
`define FUNCT7_ANDI  7'h00 // no funct7
`define FUNCT7_SLLI  7'h00
`define FUNCT7_SRLI  7'h00
`define FUNCT7_SRAI  7'h20
`define FUNCT7_SLTI  7'h00 // no funct7
`define FUNCT7_SLTIU 7'h00 // no funct7
// I_TYPE_LOAD
`define FUNCT7_LB  7'h00   // no funct7
`define FUNCT7_LH  7'h00   // no funct7
`define FUNCT7_LW  7'h00   // no funct7
`define FUNCT7_LBU 7'h00   // no funct7
`define FUNCT7_LHU 7'h00   // no funct7
// S_TYPE
`define FUNCT7_SB 7'h00    // no funct7
`define FUNCT7_SH 7'h00    // no funct7
`define FUNCT7_SW 7'h00    // no funct7
// B_TYPE
`define FUNCT7_BEQ  7'h00  // no funct7
`define FUNCT7_BNE  7'h00  // no funct7
`define FUNCT7_BLT  7'h00  // no funct7
`define FUNCT7_BGE  7'h00  // no funct7
`define FUNCT7_BLTU 7'h00  // no funct7
`define FUNCT7_BGEU 7'h00  // no funct7
// J_TYPE
`define FUNCT7_JAL  7'h00  // no funct7
// I_TYPE_JALR
`define FUNCT7_JALR 7'h00  // no funct7
// U_TYPE_LUI
`define FUNCT7_LUI   7'h00 // no funct7
// U_TYPE_AUIPC
`define FUNCT7_AUIPC 7'h00 // no funct7