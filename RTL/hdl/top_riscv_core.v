

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
module top_riscv_core 
#(
  parameter ADDR_WIDTH = 8,
  parameter ADDR_NUM = 256
) 
(
    input clk,
    input rst_n,
    input boot_up,
    input [ADDR_WIDTH-1:0] boot_addr,
    output valid,
    input [32-1 :0] boot_datai
    
);


    wire [3-1: 0] rs1_ID_fwd;
    wire [3-1: 0] rs2_ID_fwd;
    wire [2-1: 0] rs2_EX_fwd;
    wire [32-1: 0] pc;
    wire [32-1: 0] pc_ID;
    wire [32-1: 0] pc_ID_org;
    wire [32-1 :0] pc_EX;
    wire [32-1: 0] pc_EX_org;
    wire [32-1 :0] pc_M;
    wire [32-1 :0] pc_RB;
    wire [32-1: 0] instr_IF;
    wire [32-1: 0] instr_ID;
    wire [32-1:0] instr_EX;
    wire [32-1:0] instr_M;
    wire [32-1:0] instr_RB;
    wire [32-1 :0] alu_result_EX;
    wire [32-1: 0] alu_result_M;
    wire [32-1 :0] alu_result_RB;
    wire [32-1: 0] rd_wdata_RB;
    wire branch_valid;
    wire jalr_ID;
    wire jalr_EX;
    wire jalr_M;
    wire [32-1: 0] mem_rdata_M;
    wire [32-1: 0] mem_rdata_RB;
    wire alu_src_EX;
    wire alu_src_ID;
    wire [4-1: 0] alu_ctrl_ID;
    wire [4-1: 0] alu_ctrl_EX;
    wire [2-1: 0] PMAItoReg_ID;
    wire [2-1: 0] PMAItoReg_EX;
    wire [2-1: 0] PMAItoReg_M;
    wire [2-1: 0] PMAItoReg_RB;
    wire [32-1: 0] imm_ID;
    wire [32-1: 0] imm_EX;
    wire [32-1: 0] imm_M;
    wire [32-1: 0] imm_RB;
    wire [32-1: 0] rs1_rdata_ID;
    wire [32-1: 0] rs1_rdata_EX;
    wire [32-1: 0] rs2_rdata_ID;
    wire [32-1: 0] rs2_rdata_EX;
    wire [32-1: 0] rs2_rdata_M;
    wire [5-1: 0] rd_waddr_ID;
    wire [5-1: 0] rd_waddr_EX;
    wire [5-1: 0] rd_waddr_M;
    wire [5-1: 0] rd_waddr_RB;
    wire rd_wen_ID;
    wire rd_wen_EX;
    wire rd_wen_M;
    wire rd_wen_RB;
    wire branch_ID;
    wire [32-1 :0] opr1; 
    wire [32-1 :0] opr2;
    wire [3-1: 0] funct3_M;
    wire mem_write_ID;
    wire mem_write_EX;
    wire mem_write_M;
    wire jal_ID;
    wire [5-1: 0] rs1_raddr_ID;
    wire [5-1: 0] rs2_raddr_ID;
    wire [5-1: 0] rs2_raddr_EX;
    wire [32-1:0] instr_ID_mux;
    wire keep_pc;
    wire keep_instr;
    wire nop_sel;    
    wire nop_sel_f;
    wire pc_running;
    wire [31:0] pc_branch_ID;
    wire auipc_EX;
    wire [32-1: 0] rs1_rdata_ID_muxed;
    wire [32-1: 0] rs2_rdata_ID_muxed;
    wire [32-1: 0] rs2_rdata_EX_muxed;
    wire beq_ID;
    wire bne_ID;

    assign rs1_rdata_ID_muxed = (rs1_ID_fwd == 0)? rs1_rdata_ID:
        (rs1_ID_fwd == 1)? alu_result_EX:
        (rs1_ID_fwd == 2)? alu_result_M: 
        (rs1_ID_fwd == 4)? rd_wdata_RB: 
        (rs1_ID_fwd == 5)? pc_M: mem_rdata_M;

    assign rs2_rdata_ID_muxed = (rs2_ID_fwd == 0)? rs2_rdata_ID:
        (rs2_ID_fwd == 1)? alu_result_EX:
        (rs2_ID_fwd == 2)? alu_result_M:
        (rs2_ID_fwd == 4)? rd_wdata_RB: 
        (rs2_ID_fwd == 5)? pc_M: mem_rdata_M;

    assign rs2_rdata_EX_muxed = (rs2_EX_fwd == 0)? rs2_rdata_EX:
        (rs2_EX_fwd == 1)? alu_result_M: mem_rdata_M;

    assign rd_wdata_RB = (PMAItoReg_RB == 2'd3)? pc_RB:
        (PMAItoReg_RB == 2'd2)? mem_rdata_RB:
        (PMAItoReg_RB == 2'd1)? alu_result_RB: imm_RB;

    assign opr1 = (auipc_EX) ? pc_EX_org : rs1_rdata_EX;
    assign opr2 = (alu_src_EX)? rs2_rdata_EX: imm_EX;
    assign pc_branch_ID = (jal_ID || (branch_ID && ~(nop_sel || nop_sel_f))) ? pc_ID_org + $signed(imm_ID) : pc_ID_org + $signed(imm_ID) - 4;

    reg [4-1: 0] counter;
    assign valid = (counter == 12);
    always @(posedge clk) begin
        if (~rst_n) counter <= 0;
        else if (boot_up == 0 && instr_IF == 0) counter <= counter + 1;
        else counter <= 0;
    end
    
    assign beq_ID = (instr_ID_mux[14:12] == 3'b000) && (rs1_rdata_ID_muxed == rs2_rdata_ID_muxed);
    assign bne_ID = (instr_ID_mux[14:12] == 3'b001) && ~(rs1_rdata_ID_muxed == rs2_rdata_ID_muxed);
    assign branch_valid = ((beq_ID || bne_ID) && branch_ID) || jal_ID;

    ///////////// IF_STAGE && RB_STAGE /////////// 

    PC PC_U0 (
        .clk(clk),
        .rst_n(rst_n),
        .alu_result_M(alu_result_M),
        .boot_up(boot_up),
        .keep_PC(keep_pc),
        .branch_valid(branch_valid),
        .jalr_M(jalr_M),
        .pc(pc),
        .pc_running(pc_running),
        .pc_branch_ID(pc_branch_ID)
    );

    Icache Icache_U0 (
        .clk(clk),
        .rst_n(rst_n),
        .pc_running(pc_running),
        .pc(pc),
        .boot_addr(boot_addr),
        .wen(boot_up),
        .wdata(boot_datai),
        .rdata(instr_IF)
    );

    ///////////// IF_STAGE && RB_STAGE /////////// 
    
    IF_ID IF_ID_U0 (
        .clk(clk),
        .rst_n(rst_n),
        .pc_running(pc_running),
        .pc(pc),
        .instr_IF(instr_IF),
        .keep_instr(keep_instr),

        .jalr_ID(jalr_ID),
        .jalr_EX(jalr_EX),
        .jalr_M(jalr_M),

        .PC_ID(pc_ID),
        .PC_ID_org(pc_ID_org),
        .instr_ID(instr_ID),
        .rs1_raddr(rs1_raddr_ID),
        .rs2_raddr(rs2_raddr_ID),
        .rd_waddr_ID(rd_waddr_ID),
        .branch_valid(branch_valid)
    );

    ////////////////// ID_STAGE //////////////////

    control_unit control_unit_U0 (
        .instr_ID(instr_ID_mux), 
        .ALU_src(alu_src_ID), 
        .ALU_ctrl(alu_ctrl_ID),
        .branch(branch_ID), 
        .MemWrite(mem_write_ID), 
        .jal(jal_ID),
        .jalr(jalr_ID), 
        .PMAItoReg(PMAItoReg_ID), 
        .rd_wen(rd_wen_ID)
    );

    imm_gen imm_gen_U0 (
        .instr(instr_ID_mux), 
        .imm(imm_ID)
    );

    regfile regfile_U0 (
        .clk(clk), 
        .srst_n(rst_n), 
        .raddr1(rs1_raddr_ID), 
        .raddr2(rs2_raddr_ID),
        .wen(rd_wen_RB), 
        .waddr(rd_waddr_RB), 
        .wdata(rd_wdata_RB),
        .rdata1(rs1_rdata_ID), 
        .rdata2(rs2_rdata_ID)
    );

    ////////////////// ID_STAGE ////////////////// 

    ID_EX ID_EX_U0 (
        .clk(clk), 
        .rst_n(rst_n),
        .PC_ID(pc_ID),
        .PC_ID_org(pc_ID_org),
        .imm_ID(imm_ID),
        .rs1_rdata_ID(rs1_rdata_ID_muxed),
        .rs2_rdata_ID(rs2_rdata_ID_muxed),
        .rd_waddr_ID(rd_waddr_ID),
        .ALU_src_ID(alu_src_ID),
        .ALU_ctrl_ID(alu_ctrl_ID),
        .MemWrite_ID(mem_write_ID),
        .jalr_ID(jalr_ID),
        .PMAItoReg_ID(PMAItoReg_ID),
        .rd_wen_ID(rd_wen_ID),
        .PC_EX(pc_EX),
        .PC_EX_org(pc_EX_org),
        .imm_EX(imm_EX),
        .rs1_rdata_EX(rs1_rdata_EX),
        .rs2_rdata_EX(rs2_rdata_EX),
        .rd_waddr_EX(rd_waddr_EX),
        .ALU_src_EX(alu_src_EX),
        .ALU_ctrl_EX(alu_ctrl_EX),
        .MemWrite_EX(mem_write_EX),
        .jalr_EX(jalr_EX),
        .PMAItoReg_EX(PMAItoReg_EX),
        .rd_wen_EX(rd_wen_EX),
        .rs2_raddr_ID(rs2_raddr_ID),
        .rs2_raddr_EX(rs2_raddr_EX),
        .instr_ID(instr_ID_mux), 
        .instr_EX(instr_EX),
        .auipc_EX(auipc_EX)
    );

    ////////////////// EX_STAGE ////////////////// 

    ALU ALU_U0 (
        .opr1(opr1), .opr2(opr2), 
        .alu_ctrl(alu_ctrl_EX), 
        .alu_out(alu_result_EX)
    );

    ////////////////// EX_STAGE ////////////////// 

    EX_M EX_M_U0(
        .clk(clk),
        .rst_n(rst_n),
        .PC_EX(pc_EX),
        .imm_EX(imm_EX),
        .rs2_rdata_EX(rs2_rdata_EX_muxed),
        .rd_waddr_EX(rd_waddr_EX),
        .alu_result_EX(alu_result_EX),
        .MemWrite_EX(mem_write_EX),
        .jalr_EX(jalr_EX),
        .PMAItoReg_EX(PMAItoReg_EX),
        .rd_wen_EX(rd_wen_EX),
        .PC_M(pc_M),
        .imm_M(imm_M),
        .rs2_rdata_M(rs2_rdata_M),
        .rd_waddr_M(rd_waddr_M),
        .funct3_M(funct3_M),
        .alu_result_M(alu_result_M),
        .MemWrite_M(mem_write_M),
        .jalr_M(jalr_M),
        .PMAItoReg_M(PMAItoReg_M),
        .rd_wen_M(rd_wen_M),
        .instr_EX(instr_EX),
        .instr_M(instr_M)
    );

    ////////////////// M_STAGE /////////////////// 

    Dcache Dcache_U0(
        .clk(clk),
        .rst_n(rst_n),
        .MemWrite(mem_write_M), 
        .alu_result_M(alu_result_M), 
        .rs2_rdata_M(rs2_rdata_M),
        .funct3(funct3_M),
        .mem_rdata(mem_rdata_M)
    );

    ////////////////// M_STAGE /////////////////// 

    M_RB M_RB_U0(
        .clk(clk),
        .rst_n(rst_n),
        .PMAItoReg_M(PMAItoReg_M),
        .rd_wen_M(rd_wen_M),
        .imm_M(imm_M),
        .mem_rdata_M(mem_rdata_M),
        .alu_result_M(alu_result_M),
        .PC_M(pc_M),
        .rd_waddr_M(rd_waddr_M),
        .PMAItoReg_RB(PMAItoReg_RB),
        .rd_wen_RB(rd_wen_RB),
        .imm_RB(imm_RB),
        .mem_rdata_RB(mem_rdata_RB),
        .alu_result_RB(alu_result_RB),
        .PC_RB(pc_RB),
        .rd_waddr_RB(rd_waddr_RB),
        .instr_M(instr_M),
        .instr_RB(instr_RB)
    );

    ////////////////// STALL_UNIT /////////////////// 

    stall_unit stall_unit_U0(
        .clk(clk),
        .instr_ID(instr_ID),
        .instr_EX(instr_EX),
        .instr_M(instr_M),
        .keep_PC(keep_pc),
        .keep_instr(keep_instr),
        .nop_sel(nop_sel),
        .nop_sel_f(nop_sel_f)
    );

    nop_mux nop_mux_U0(
        .instr_ID(instr_ID),
        .nop_sel(nop_sel),
        .instr_ID_mux(instr_ID_mux)
    );

    ////////////////// Forward_UNIT ///////////////////      

    forward_unit forward_unit(
        .instr_ID(instr_ID_mux),
        .instr_EX(instr_EX),
        .instr_M(instr_M),
        .instr_RB(instr_RB),
        .rs1_raddr_ID(rs1_raddr_ID),
        .rs2_raddr_ID(rs2_raddr_ID),
        .rs2_raddr_EX(rs2_raddr_EX),
        .rd_waddr_EX(rd_waddr_EX),
        .rd_waddr_M(rd_waddr_M),
        .rd_waddr_RB(rd_waddr_RB),

        .rs1_ID_fwd(rs1_ID_fwd),
        .rs2_ID_fwd(rs2_ID_fwd),
        .rs2_EX_fwd(rs2_EX_fwd)
    );

endmodule
