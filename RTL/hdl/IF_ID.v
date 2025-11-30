

module IF_ID(
    input clk,
    input rst_n,
    input pc_running,
    input [31:0] pc,
    input [31:0] instr_IF,
    input branch_valid,

    input keep_instr,

    input jalr_ID,
    input jalr_EX,
    input jalr_M,

    output reg [31:0] PC_ID,
    output reg [31:0] PC_ID_org,
    output reg [31:0] instr_ID,
    output [4:0] rs1_raddr,
    output [4:0] rs2_raddr,
    output [4:0] rd_waddr_ID
);

wire [31:0] instr_ID_n;    
wire [31:0] PC_IF;
// assign instr_ID_n = (keep_instr) ? instr_ID : instr_IF;
assign PC_IF = pc + 4;
assign rs1_raddr = instr_ID[19:15];
assign rs2_raddr = instr_ID[24:20];
assign rd_waddr_ID = instr_ID[11:7];

always@(posedge clk) begin
    if(~(rst_n & pc_running))begin
        PC_ID <= 0;
        instr_ID <= 0;
        PC_ID_org <= 0;
    end
    else begin
        PC_ID <= PC_IF;
        instr_ID <= instr_ID_n;
        PC_ID_org <= pc;
    end
end

assign instr_ID_n = ((branch_valid) || jalr_EX || jalr_ID || jalr_M)? 0: (keep_instr) ? instr_ID : instr_IF;

endmodule
