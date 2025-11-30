


module EX_M(
    input clk,
    input rst_n,
    input [31:0] PC_EX,
    input [31:0] imm_EX,
    input [31:0] rs2_rdata_EX,
    input [4:0] rd_waddr_EX,
    
    input [31:0] alu_result_EX,

    input MemWrite_EX,
    input jalr_EX,

    input [1:0] PMAItoReg_EX,
    input rd_wen_EX,

    input [32-1:0] instr_EX,
    output reg [32-1:0] instr_M,

    output reg [31:0] PC_M,
    output reg [31:0] imm_M,
    output reg [31:0] rs2_rdata_M,
    output reg [4:0] rd_waddr_M,
    
    output reg [2:0] funct3_M,
    // output reg zero_M,
    output reg [31:0] alu_result_M,

    output reg MemWrite_M,
    output reg jalr_M,

    output reg [1:0] PMAItoReg_M,
    output reg rd_wen_M
);

wire [2:0] funct3_EX;    
assign funct3_EX = instr_EX[14:12];

always@(posedge clk) begin
    if(!rst_n) begin
        rd_wen_M <= 0;
        MemWrite_M <= 0;
    end
    else begin
        rd_wen_M <= rd_wen_EX;
        MemWrite_M <= MemWrite_EX;
    end
end

always@(posedge clk) begin
    PC_M <= PC_EX;
    imm_M <= imm_EX;
    rs2_rdata_M <= rs2_rdata_EX;
    rd_waddr_M <= rd_waddr_EX;
    
    funct3_M <= funct3_EX;
    // zero_M <= zero_EX;
    alu_result_M <= alu_result_EX;

    jalr_M <= jalr_EX;

    PMAItoReg_M <= PMAItoReg_EX;

    instr_M <= instr_EX;

end

endmodule
