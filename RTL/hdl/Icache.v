


module Icache #(
            parameter ADDR_WIDTH = 8,
            parameter ADDR_NUM = 256
        ) (
            input clk,
            input rst_n,
            input wen,
            input pc_running,
            input [7:0] boot_addr,
            input [31:0] pc, 
            input [32-1:0] wdata,
            output reg [32-1: 0] rdata
        );

// reg [32-1: 0] mem [256-1: 0];
// reg [32-1: 0] mem_n [256-1: 0];
// reg [32-1: 0] mem [256-1: 0];
// reg [32-1: 0] mem_n [256-1: 0];
// integer i;

// wire [8-1: 0] addr;
// assign addr = pc_running ? pc[8 + 1: 2] : boot_addr;

// wire [7:0] addr_forcheck;
// assign addr_forcheck = addr + 1;

// always @ (posedge clk) 
//     if (~rst_n) begin
//         for(i = 0; i < 256; i = i + 1) mem[i] <= 0;
//     end
//     else begin
//         for(i = 0; i < 256; i = i + 1) mem[i] <= mem_n[i];
//     end

// always@* 
//     rdata = mem[addr];

// always @(*) begin
// 	for(i = 0; i < 256; i = i + 1) begin
// 		mem_n[i] = (wen && (i == addr)) ? wdata : mem[i];
// 	end
// end
reg [32-1: 0] mem0 [128-1: 0];
reg [32-1: 0] mem0_n [128-1: 0];
reg [32-1: 0] mem1 [128-1: 0];
reg [32-1: 0] mem1_n [128-1: 0];
integer i;

wire [8-1: 0] addr;
assign addr = pc_running ? pc[8 + 1: 2] : boot_addr;

wire [7:0] addr_forcheck;
assign addr_forcheck = addr + 1;

always @ (posedge clk) 
    if (~rst_n) begin
        for(i = 0; i < 128; i = i + 1) mem0[i] <= 0;
        for(i = 0; i < 128; i = i + 1) mem1[i] <= 0;
    end
    else begin
        for(i = 0; i < 128; i = i + 1) mem0[i] <= mem0_n[i];
        for(i = 0; i < 128; i = i + 1) mem1[i] <= mem1_n[i];
    end

always@* 
    rdata = (addr[7])? mem1[addr[6:0]]: mem0[addr[6:0]];

always @(*) begin
	for(i = 0; i < 128; i = i + 1) begin
		mem0_n[i] = (wen && (i == addr[6:0]) && addr[7] == 0) ? wdata : mem0[i];
		mem1_n[i] = (wen && (i == addr[6:0]) && addr[7] == 1) ? wdata : mem1[i];
	end
end

endmodule










