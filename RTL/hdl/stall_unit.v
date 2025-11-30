

// `include "Def.v"// OPCODE
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
module stall_unit
(
    input clk,
    input [31:0] instr_ID,
    input [31:0] instr_EX,
    input [31:0] instr_M,
    output reg keep_PC,
    output reg keep_instr,
    output reg nop_sel,
    output reg nop_sel_f
);

wire [6:0] opcode_ID;
wire [6:0] opcode_EX;
wire [6:0] opcode_M;
wire [4:0] rd_ID;
wire [4:0] rd_EX;
wire [4:0] rd_M;
wire [4:0] rs1_ID;
wire [4:0] rs1_EX;
wire [4:0] rs1_M;
wire [4:0] rs2_ID;
wire [4:0] rs2_EX;
wire [4:0] rs2_M;
assign opcode_ID = instr_ID[6:0];
assign opcode_EX = instr_EX[6:0];
assign opcode_M  = instr_M[6:0];
assign rd_ID = instr_ID[11:7];
assign rd_EX = instr_EX[11:7];
assign rd_M  = instr_M[11:7];
assign rs1_ID = instr_ID[19:15];
assign rs1_EX = instr_EX[19:15];
assign rs1_M  = instr_M[19:15];
assign rs2_ID = instr_ID[24:20];
assign rs2_EX = instr_EX[24:20];
assign rs2_M  = instr_M[24:20];

always @(posedge clk) begin
    nop_sel_f <= nop_sel;
end

always @(*) begin
    case(1'b1)
        // lw cases
        (opcode_EX == `I_TYPE_LOAD && opcode_ID == `R_TYPE): begin
            case(1'b1)
                (rd_EX == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                (rd_EX == rs2_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                default:           {keep_PC, keep_instr, nop_sel} = 3'b000;
            endcase
        end
        (opcode_EX == `I_TYPE_LOAD && opcode_ID == `I_TYPE_OP_IMM): begin
            case(1'b1)
                (rd_EX == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                default:           {keep_PC, keep_instr, nop_sel} = 3'b000;
            endcase
        end
        (opcode_EX == `I_TYPE_LOAD && opcode_ID == `S_TYPE): begin
            case(1'b1)
                (rd_EX == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                default:           {keep_PC, keep_instr, nop_sel} = 3'b000;
            endcase
        end
        // branch cases
        // (opcode_EX == `R_TYPE && opcode_ID == `B_TYPE): begin
        //     case(1'b1)
        //         (rd_EX == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
        //         (rd_EX == rs2_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
        //         default:           {keep_PC, keep_instr, nop_sel} = 3'b000;
        //     endcase
        // end
        // (opcode_EX == `I_TYPE_OP_IMM && opcode_ID == `B_TYPE): begin
        //     case(1'b1)
        //         (rd_EX == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
        //         (rd_EX == rs2_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
        //         default:           {keep_PC, keep_instr, nop_sel} = 3'b000;
        //     endcase
        // end
        (opcode_EX == `I_TYPE_LOAD && opcode_ID == `B_TYPE): begin
            case(1'b1)
                (rd_EX == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                (rd_EX == rs2_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                default:           {keep_PC, keep_instr, nop_sel} = 3'b000;
            endcase
        end
        (opcode_M == `I_TYPE_LOAD && opcode_ID == `B_TYPE): begin
            case(1'b1)
                (rd_M == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                (rd_M == rs2_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
                default:          {keep_PC, keep_instr, nop_sel} = 3'b000;
            endcase
        end
        // (opcode_M == `R_TYPE && opcode_ID == `B_TYPE): begin
        //     case(1'b1)
        //         (rd_M == rs1_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
        //         (rd_M == rs2_ID): {keep_PC, keep_instr, nop_sel} = 3'b111;
        //         default:          {keep_PC, keep_instr, nop_sel} = 3'b000;
        //     endcase
        // end
        // jal case
        // (opcode_ID == `J_TYPE): begin
        //     {keep_PC, keep_instr, nop_sel} = 3'b111;
        // end
        /*
        (opcode_M == `J_TYPE): begin
            {keep_PC, keep_instr, nop_sel} = 3'b111;
        end
        */
        // beq cases
        (opcode_EX == `B_TYPE && ~(opcode_ID == `J_TYPE) ): begin
            {keep_PC, keep_instr, nop_sel} = 3'b111;
        end
        default: {keep_PC, keep_instr, nop_sel} = 3'b000;
    endcase
end

endmodule
