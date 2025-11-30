

module M_RB(
    input clk,
    input rst_n,
    input [1:0] PMAItoReg_M,
    input rd_wen_M,

    input [31:0] imm_M,
    input [31:0] mem_rdata_M,

    input [31:0] alu_result_M,
    input [31:0] PC_M,
    input [4:0] rd_waddr_M,

    input [31:0] instr_M,
    output reg [31:0] instr_RB,

    output reg [1:0] PMAItoReg_RB,
    output reg rd_wen_RB,

    output reg [31:0] imm_RB,
    output reg [31:0] mem_rdata_RB,

    output reg [31:0] alu_result_RB,
    output reg [31:0] PC_RB,
    output reg [4:0] rd_waddr_RB
);

always@(posedge clk) begin
    if(!rst_n) begin
        rd_wen_RB <= 0;
    end
    else begin
        rd_wen_RB <= rd_wen_M;
    end
end

always@(posedge clk) begin
    PMAItoReg_RB <= PMAItoReg_M;
    imm_RB <= imm_M;
    mem_rdata_RB <= mem_rdata_M;
    alu_result_RB <= alu_result_M;
    PC_RB <= PC_M;
    rd_waddr_RB <= rd_waddr_M;
    instr_RB <= instr_M;
end

endmodule


