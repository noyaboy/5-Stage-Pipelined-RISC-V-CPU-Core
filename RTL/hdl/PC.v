

module PC(
    input clk,
    input rst_n,
    input [31:0] alu_result_M,
    input boot_up,
    input branch_valid,
    input jalr_M,
    input keep_PC,
    output reg [31:0] pc,
    output pc_running,
    input [31:0] pc_branch_ID // PC_branch_ID
);

localparam  PC_IDLE = 2'b00,
            PC_LOAD = 2'b01,
            PC_RUN  = 2'b10;

wire [32-1: 0] pc_IF;
reg [1:0] state, state_n;
reg [31:0] pc_temp;

assign pc_running = (state == PC_RUN);
assign pc_IF = pc + 4;

always@(posedge clk)
    if(!rst_n)
        state <= PC_IDLE;
    else
        state <= state_n;

always@*
    case(state)
        PC_IDLE: state_n = boot_up ? PC_LOAD : PC_IDLE;
        PC_LOAD: state_n = ~boot_up ? PC_RUN : PC_LOAD;
        default   : state_n = PC_RUN;
    endcase

always@(posedge clk) begin
    if(~rst_n || (state != PC_RUN))
        pc <= 0;
    else
        pc <= pc_temp;
end

always@* begin
    case(1'b1)
        branch_valid: pc_temp = pc_branch_ID; // PC_branch_ID
        jalr_M: pc_temp = alu_result_M;

        keep_PC: pc_temp = pc;

        default: pc_temp = pc_IF;
    endcase
end

endmodule
