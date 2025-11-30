// `include "Def.v"
// OPCODE

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
module control_unit(
    input [31:0] instr_ID,

    // EX ouput
    output reg ALU_src, // 1: read rs2, 0: read imm
    output reg [3:0] ALU_ctrl,

    // M
    output reg branch,
    output reg MemWrite,
    // output MemRead,
    output reg jal,
    output reg jalr,

    // RB
    output reg [1:0] PMAItoReg, // 11: PC, 10: Mem, 01: Alu, 00: Imm
    output reg rd_wen

); 

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

assign opcode = instr_ID[6:0];
assign funct3 = instr_ID[14:12];
assign funct7 = instr_ID[31:25];

reg state, state_n;

wire r_type;
wire i_type;
wire i_type_load;
wire i_type_jalr;
wire s_type;
wire b_type;
wire u_type_lui;
wire u_type_auipc;
wire j_type;

assign r_type		= (opcode == `R_TYPE);
assign i_type		= (opcode == `I_TYPE_OP_IMM);
assign i_type_load	= (opcode == `I_TYPE_LOAD);
assign i_type_jalr	= (opcode == `I_TYPE_JALR);
assign s_type		= (opcode == `S_TYPE);
assign b_type		= (opcode == `B_TYPE);
assign u_type_lui	= (opcode == `U_TYPE_LUI);
assign u_type_auipc	= (opcode == `U_TYPE_AUIPC);
assign j_type		= (opcode == `J_TYPE);




always@* begin
    case(1'b1) 
        i_type_jalr: begin
            jal = 0;
            jalr = 1;
        end
        j_type: begin
            jal = 1;
            jalr = 0;
        end
        default: begin
            jal = 0;
            jalr = 0;
        end
    endcase
end

always@* begin
    case(1'b1) 
        r_type: begin 
            ALU_src = 1'b1;
            ALU_ctrl[2:0] = funct3;
            ALU_ctrl[3] = funct7[5];
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b01;
            rd_wen = 1'b1;
        end
        i_type: begin 
            ALU_src = 1'b0;
            ALU_ctrl[2:0] = funct3;
            ALU_ctrl[3] = (funct3 == `FUNCT3_SLLI | funct3 == `FUNCT3_SRLI | funct3 == `FUNCT3_SRAI)? funct7[5]:
                          0;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b01;
            rd_wen = 1'b1;
        end
        i_type_load: begin 
            ALU_src = 1'b0;
            ALU_ctrl[2:0] = `FUNCT3_ADD;
            ALU_ctrl[3] = 0;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b1;
            PMAItoReg = 2'b10;
            rd_wen = 1'b1;
        end
        i_type_jalr: begin 
            ALU_src = 1'b0;
            ALU_ctrl[2:0] = funct3;
            ALU_ctrl[3] = 0;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b11;
            rd_wen = 1'b1;
        end
        s_type: begin 
            ALU_src = 1'b0;
            ALU_ctrl[2:0] = `FUNCT3_ADD;
            ALU_ctrl[3] = 0;
            branch = 1'b0;
            MemWrite = 1'b1;
            // MemRead = 1'b0;
            PMAItoReg = 2'b00;
            rd_wen = 1'b0;
        end
        b_type: begin 
            ALU_src = 1'b1;
            ALU_ctrl[2:0] = `FUNCT3_SUB;
            ALU_ctrl[3] = 1;
            branch = 1'b1;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b00;
            rd_wen = 1'b0;
        end
        u_type_lui: begin // no ALU passing
            ALU_src = 1'b1;
            ALU_ctrl[2:0] = funct3;
            ALU_ctrl[3] = funct7;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b00;
            rd_wen = 1'b1;
        end
        u_type_auipc: begin 
            ALU_src = 1'b0;
            ALU_ctrl[2:0] = `FUNCT3_ADD;
            ALU_ctrl[3] = 0;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b01;
            rd_wen = 1'b1;
        end
        j_type: begin 
            ALU_src = 1'b1;
            ALU_ctrl[2:0] = `FUNCT3_ADD;
            ALU_ctrl[3] = 0;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b11;
            rd_wen = 1'b1;
        end
        default: begin 
            ALU_src = 1'b0;
            ALU_ctrl[2:0] = funct3;
            ALU_ctrl[3] = funct7;
            branch = 1'b0;
            MemWrite = 1'b0;
            // MemRead = 1'b0;
            PMAItoReg = 2'b00;
            rd_wen = 1'b0;
        end
    endcase
end

endmodule
