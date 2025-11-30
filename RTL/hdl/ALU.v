// `include "Def.v"
// OPCODE
//`timescale 1ns/1ps
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
module ALU
(
    input [31:0] opr1,
    input [31:0] opr2,
    input [3:0]  alu_ctrl,
    output reg [31:0] alu_out
);


always @(*) begin
    case(1'b1)
        (alu_ctrl == {1'b0, `FUNCT3_ADD}):  alu_out = $signed(opr1) + $signed(opr2);
        (alu_ctrl == {1'b1, `FUNCT3_SUB}):  alu_out = $signed(opr1) - $signed(opr2);
        (alu_ctrl == {1'b0, `FUNCT3_XOR}):  alu_out = opr1 ^ opr2;
        (alu_ctrl == {1'b0, `FUNCT3_OR}):   alu_out = opr1 | opr2;
        (alu_ctrl == {1'b0, `FUNCT3_AND}):  alu_out = opr1 & opr2;
        (alu_ctrl == {1'b0, `FUNCT3_SLL}):  alu_out = opr1 << opr2[4:0];
        (alu_ctrl == {1'b0, `FUNCT3_SRL}):  alu_out = opr1 >> opr2[4:0];
        (alu_ctrl == {1'b1, `FUNCT3_SRA}):  alu_out = $signed(opr1) >>> opr2[4:0];
        (alu_ctrl == {1'b0, `FUNCT3_SLT}):  alu_out = ($signed(opr1) < $signed(opr2)) ? 1 : 0;
        (alu_ctrl == {1'b0, `FUNCT3_SLTU}): alu_out = (opr1 < opr2) ? 1 : 0;
        default:                            alu_out = 0;
    endcase
end

endmodule


// reg [31:0] alu_out;
// wire ext;

// assign alu_out_ = alu_out;

// assign alu_out_ = (opr2 > 31 && alu_ctrl[2:0] == `FUNCT3_SRA)? {32{ext}} : alu_out;
// assign ext = (~alu_ctrl[3]) ? 1'b0 : opr1[31];
        // "<<"
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd00): alu_out = opr1;
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd01): alu_out = {opr1[30:0], 1'b0};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd02): alu_out = {opr1[29:0], {2{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd03): alu_out = {opr1[28:0], {3{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd04): alu_out = {opr1[27:0], {4{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd05): alu_out = {opr1[26:0], {5{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd06): alu_out = {opr1[25:0], {6{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd07): alu_out = {opr1[24:0], {7{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd08): alu_out = {opr1[23:0], {8{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd09): alu_out = {opr1[22:0], {9{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd10): alu_out = {opr1[21:0], {10{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd11): alu_out = {opr1[20:0], {11{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd12): alu_out = {opr1[19:0], {12{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd13): alu_out = {opr1[18:0], {13{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd14): alu_out = {opr1[17:0], {14{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd15): alu_out = {opr1[16:0], {15{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd16): alu_out = {opr1[15:0], {16{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd17): alu_out = {opr1[14:0], {17{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd18): alu_out = {opr1[13:0], {18{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd19): alu_out = {opr1[12:0], {19{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd20): alu_out = {opr1[11:0], {20{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd21): alu_out = {opr1[10:0], {21{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd22): alu_out = {opr1[9:0],  {22{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd23): alu_out = {opr1[8:0],  {23{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd24): alu_out = {opr1[7:0],  {24{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd25): alu_out = {opr1[6:0],  {25{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd26): alu_out = {opr1[5:0],  {26{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd27): alu_out = {opr1[4:0],  {27{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd28): alu_out = {opr1[3:0],  {28{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd29): alu_out = {opr1[2:0],  {29{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd30): alu_out = {opr1[1:0],  {30{1'b0}}};
        // (alu_ctrl == {1'b0, `FUNCT3_SLL} && opr2[4:0] == 5'd31): alu_out = {opr1[0],    {31{1'b0}}};
        
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd0):  alu_out = {{0{ext}}, opr1[31:0]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd1):  alu_out = {{1{ext}}, opr1[31:1]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd2):  alu_out = {{2{ext}}, opr1[31:2]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd3):  alu_out = {{3{ext}}, opr1[31:3]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd4):  alu_out = {{4{ext}}, opr1[31:4]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd5):  alu_out = {{5{ext}}, opr1[31:5]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd6):  alu_out = {{6{ext}}, opr1[31:6]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd7):  alu_out = {{7{ext}}, opr1[31:7]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd8):  alu_out = {{8{ext}}, opr1[31:8]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd9):  alu_out = {{9{ext}}, opr1[31:9]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd10):  alu_out = {{10{ext}}, opr1[31:10]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd11):  alu_out = {{11{ext}}, opr1[31:11]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd12):  alu_out = {{12{ext}}, opr1[31:12]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd13):  alu_out = {{13{ext}}, opr1[31:13]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd14):  alu_out = {{14{ext}}, opr1[31:14]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd15):  alu_out = {{15{ext}}, opr1[31:15]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd16):  alu_out = {{16{ext}}, opr1[31:16]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd17):  alu_out = {{17{ext}}, opr1[31:17]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd18):  alu_out = {{18{ext}}, opr1[31:18]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd19):  alu_out = {{19{ext}}, opr1[31:19]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd20):  alu_out = {{20{ext}}, opr1[31:20]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd21):  alu_out = {{21{ext}}, opr1[31:21]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd22):  alu_out = {{22{ext}}, opr1[31:22]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd23):  alu_out = {{23{ext}}, opr1[31:23]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd24):  alu_out = {{24{ext}}, opr1[31:24]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd25):  alu_out = {{25{ext}}, opr1[31:25]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd26):  alu_out = {{26{ext}}, opr1[31:26]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd27):  alu_out = {{27{ext}}, opr1[31:27]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd28):  alu_out = {{28{ext}}, opr1[31:28]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd29):  alu_out = {{29{ext}}, opr1[31:29]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd30):  alu_out = {{30{ext}}, opr1[31:30]};
        // ((alu_ctrl[2:0] == `FUNCT3_SRA) & opr2[4:0] == 5'd31):  alu_out = {{31{ext}}, opr1[31]};
        
