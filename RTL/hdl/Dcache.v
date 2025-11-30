

module Dcache 
#(
  parameter ADDR_WIDTH = 8,
  parameter ADDR_NUM = 256
) 
(
    input clk,
    input rst_n,
    input MemWrite,
    input [32-1: 0] alu_result_M,
    input [32-1: 0] rs2_rdata_M,
    input [2:0] funct3,
    output reg [32-1: 0] mem_rdata
);

wire [ADDR_WIDTH-1: 0] addr;
reg [32-1: 0] mem [128-1: 0];
reg [32-1: 0] mem_n [128-1: 0];
integer i;

wire ext;
wire mask_b;
wire mask_h;

assign ext = (funct3 == 0)? mem[addr][7]:
             (funct3 == 1)? mem[addr][15]:
             1'b0;

assign mask_b = (funct3 == 0)? 1'b1:
                (funct3 == 1)? 1'b0:
                1'b0;

assign mask_h = (funct3 == 0)? 1'b1:
                (funct3 == 1)? 1'b1:
                1'b0;

assign addr = alu_result_M [ADDR_WIDTH + 1: 2];

always @ (posedge clk) 
    if (~rst_n) begin
        for(i = 0; i < 128; i = i + 1) mem[i] <= 0;
    end
    else begin
        for(i = 0; i < 128; i = i + 1) mem[i] <= mem_n[i];
    end

always @(*) begin
    mem_rdata = 
    (mem[addr] & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) |
    ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
end

always @(*) begin
	for(i = 0; i < 128; i = i + 1) begin
        case(funct3)
            0: 
		        mem_n[i] = (MemWrite && (i == addr)) ? {mem[i][31:8], rs2_rdata_M[7:0]} : mem[i];
            1: 
		        mem_n[i] = (MemWrite && (i == addr)) ? {mem[i][31:16], rs2_rdata_M[15:0]} : mem[i];
            2: 
		        mem_n[i] = (MemWrite && (i == addr)) ? rs2_rdata_M : mem[i];
            default:
                mem_n[i] = (MemWrite && (i == addr)) ? rs2_rdata_M : mem[i];
        endcase
	end
end

// wire [ADDR_WIDTH-1: 0] addr;
// reg [32-1: 0] mem0;
// reg [32-1: 0] mem1;
// reg [32-1: 0] mem2;
// reg [32-1: 0] mem3;
// reg [32-1: 0] mem4;
// reg [32-1: 0] mem5;
// reg [32-1: 0] mem6;
// reg [32-1: 0] mem7;
// reg [32-1: 0] mem8;
// reg [32-1: 0] mem9;
// reg [32-1: 0] mem10;
// reg [32-1: 0] mem11;
// reg [32-1: 0] mem12;
// reg [32-1: 0] mem13;
// reg [32-1: 0] mem14;
// reg [32-1: 0] mem15;
// reg [32-1: 0] mem16;
// reg [32-1: 0] mem17;
// reg [32-1: 0] mem18;
// reg [32-1: 0] mem19;
// reg [32-1: 0] mem20;
// reg [32-1: 0] mem21;
// reg [32-1: 0] mem22;
// reg [32-1: 0] mem23;
// reg [32-1: 0] mem24;
// reg [32-1: 0] mem25;
// reg [32-1: 0] mem26;
// reg [32-1: 0] mem27;
// reg [32-1: 0] mem28;
// reg [32-1: 0] mem29;
// reg [32-1: 0] mem30;
// reg [32-1: 0] mem31;
// reg [32-1: 0] mem0_n;
// reg [32-1: 0] mem1_n;
// reg [32-1: 0] mem2_n;
// reg [32-1: 0] mem3_n;
// reg [32-1: 0] mem4_n;
// reg [32-1: 0] mem5_n;
// reg [32-1: 0] mem6_n;
// reg [32-1: 0] mem7_n;
// reg [32-1: 0] mem8_n;
// reg [32-1: 0] mem9_n;
// reg [32-1: 0] mem10_n;
// reg [32-1: 0] mem11_n;
// reg [32-1: 0] mem12_n;
// reg [32-1: 0] mem13_n;
// reg [32-1: 0] mem14_n;
// reg [32-1: 0] mem15_n;
// reg [32-1: 0] mem16_n;
// reg [32-1: 0] mem17_n;
// reg [32-1: 0] mem18_n;
// reg [32-1: 0] mem19_n;
// reg [32-1: 0] mem20_n;
// reg [32-1: 0] mem21_n;
// reg [32-1: 0] mem22_n;
// reg [32-1: 0] mem23_n;
// reg [32-1: 0] mem24_n;
// reg [32-1: 0] mem25_n;
// reg [32-1: 0] mem26_n;
// reg [32-1: 0] mem27_n;
// reg [32-1: 0] mem28_n;
// reg [32-1: 0] mem29_n;
// reg [32-1: 0] mem30_n;
// reg [32-1: 0] mem31_n;

// reg ext;
// wire mask_b;
// wire mask_h;

// always @(*) begin
//     ext = 0;
//     case (1'b1)
//         (funct3 == 0 && addr == 0): ext = mem0[7];
//         (funct3 == 0 && addr == 1): ext = mem1[7];
//         (funct3 == 0 && addr == 2): ext = mem2[7];
//         (funct3 == 0 && addr == 3): ext = mem3[7];
//         (funct3 == 0 && addr == 4): ext = mem4[7];
//         (funct3 == 0 && addr == 5): ext = mem5[7];
//         (funct3 == 0 && addr == 6): ext = mem6[7];
//         (funct3 == 0 && addr == 7): ext = mem7[7];
//         (funct3 == 0 && addr == 8): ext = mem8[7];
//         (funct3 == 0 && addr == 9): ext = mem9[7];
//         (funct3 == 0 && addr == 10): ext = mem10[7];
//         (funct3 == 0 && addr == 11): ext = mem11[7];
//         (funct3 == 0 && addr == 12): ext = mem12[7];
//         (funct3 == 0 && addr == 13): ext = mem13[7];
//         (funct3 == 0 && addr == 14): ext = mem14[7];
//         (funct3 == 0 && addr == 15): ext = mem15[7];
//         (funct3 == 0 && addr == 16): ext = mem16[7];
//         (funct3 == 0 && addr == 17): ext = mem17[7];
//         (funct3 == 0 && addr == 18): ext = mem18[7];
//         (funct3 == 0 && addr == 19): ext = mem19[7];
//         (funct3 == 0 && addr == 20): ext = mem20[7];
//         (funct3 == 0 && addr == 21): ext = mem21[7];
//         (funct3 == 0 && addr == 22): ext = mem22[7];
//         (funct3 == 0 && addr == 23): ext = mem23[7];
//         (funct3 == 0 && addr == 24): ext = mem24[7];
//         (funct3 == 0 && addr == 25): ext = mem25[7];
//         (funct3 == 0 && addr == 26): ext = mem26[7];
//         (funct3 == 0 && addr == 27): ext = mem27[7];
//         (funct3 == 0 && addr == 28): ext = mem28[7];
//         (funct3 == 0 && addr == 29): ext = mem29[7];
//         (funct3 == 0 && addr == 30): ext = mem30[7];
//         (funct3 == 0 && addr == 31): ext = mem31[7];
//         (funct3 == 1 && addr == 0): ext = mem0[15];
//         (funct3 == 1 && addr == 1): ext = mem1[15];
//         (funct3 == 1 && addr == 2): ext = mem2[15];
//         (funct3 == 1 && addr == 3): ext = mem3[15];
//         (funct3 == 1 && addr == 4): ext = mem4[15];
//         (funct3 == 1 && addr == 5): ext = mem5[15];
//         (funct3 == 1 && addr == 6): ext = mem6[15];
//         (funct3 == 1 && addr == 7): ext = mem7[15];
//         (funct3 == 1 && addr == 8): ext = mem8[15];
//         (funct3 == 1 && addr == 9): ext = mem9[15];
//         (funct3 == 1 && addr == 10): ext = mem10[15];
//         (funct3 == 1 && addr == 11): ext = mem11[15];
//         (funct3 == 1 && addr == 12): ext = mem12[15];
//         (funct3 == 1 && addr == 13): ext = mem13[15];
//         (funct3 == 1 && addr == 14): ext = mem14[15];
//         (funct3 == 1 && addr == 15): ext = mem15[15];
//         (funct3 == 1 && addr == 16): ext = mem16[15];
//         (funct3 == 1 && addr == 17): ext = mem17[15];
//         (funct3 == 1 && addr == 18): ext = mem18[15];
//         (funct3 == 1 && addr == 19): ext = mem19[15];
//         (funct3 == 1 && addr == 20): ext = mem20[15];
//         (funct3 == 1 && addr == 21): ext = mem21[15];
//         (funct3 == 1 && addr == 22): ext = mem22[15];
//         (funct3 == 1 && addr == 23): ext = mem23[15];
//         (funct3 == 1 && addr == 24): ext = mem24[15];
//         (funct3 == 1 && addr == 25): ext = mem25[15];
//         (funct3 == 1 && addr == 26): ext = mem26[15];
//         (funct3 == 1 && addr == 27): ext = mem27[15];
//         (funct3 == 1 && addr == 28): ext = mem28[15];
//         (funct3 == 1 && addr == 29): ext = mem29[15];
//         (funct3 == 1 && addr == 30): ext = mem30[15];
//         (funct3 == 1 && addr == 31): ext = mem31[15];
//     endcase
// end

// assign mask_b = (funct3 == 0)? 1'b1:
//                 (funct3 == 1)? 1'b0:
//                 1'b0;

// assign mask_h = (funct3 == 0)? 1'b1:
//                 (funct3 == 1)? 1'b1:
//                 1'b0;

// assign addr = alu_result_M [ADDR_WIDTH + 1: 2];

// always @ (posedge clk) 
//     if (~rst_n) begin
        
//         mem0 <= 0;
//         mem1 <= 0;
//         mem2 <= 0;
//         mem3 <= 0;
//         mem4 <= 0;
//         mem5 <= 0;
//         mem6 <= 0;
//         mem7 <= 0;
//         mem8 <= 0;
//         mem9 <= 0;
//         mem10 <= 0;
//         mem11 <= 0;
//         mem12 <= 0;
//         mem13 <= 0;
//         mem14 <= 0;
//         mem15 <= 0;
//         mem16 <= 0;
//         mem17 <= 0;
//         mem18 <= 0;
//         mem19 <= 0;
//         mem20 <= 0;
//         mem21 <= 0;
//         mem22 <= 0;
//         mem23 <= 0;
//         mem24 <= 0;
//         mem25 <= 0;
//         mem26 <= 0;
//         mem27 <= 0;
//         mem28 <= 0;
//         mem29 <= 0;
//         mem30 <= 0;
//         mem31 <= 0;
//     end
//     else begin
//         mem0 <= mem0_n;
//         mem1 <= mem1_n;
//         mem2 <= mem2_n;
//         mem3 <= mem3_n;
//         mem4 <= mem4_n;
//         mem5 <= mem5_n;
//         mem6 <= mem6_n;
//         mem7 <= mem7_n;
//         mem8 <= mem8_n;
//         mem9 <= mem9_n;
//         mem10 <= mem10_n;
//         mem11 <= mem11_n;
//         mem12 <= mem12_n;
//         mem13 <= mem13_n;
//         mem14 <= mem14_n;
//         mem15 <= mem15_n;
//         mem16 <= mem16_n;
//         mem17 <= mem17_n;
//         mem18 <= mem18_n;
//         mem19 <= mem19_n;
//         mem20 <= mem20_n;
//         mem21 <= mem21_n;
//         mem22 <= mem22_n;
//         mem23 <= mem23_n;
//         mem24 <= mem24_n;
//         mem25 <= mem25_n;
//         mem26 <= mem26_n;
//         mem27 <= mem27_n;
//         mem28 <= mem28_n;
//         mem29 <= mem29_n;
//         mem30 <= mem30_n;
//         mem31 <= mem31_n;
//     end

// always @(*) begin
//     mem_rdata = 0;
//     case (addr)
//         0: mem_rdata = (mem0 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         1: mem_rdata = (mem1 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         2: mem_rdata = (mem2 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         3: mem_rdata = (mem3 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         4: mem_rdata = (mem4 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         5: mem_rdata = (mem5 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         6: mem_rdata = (mem6 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         7: mem_rdata = (mem7 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         8: mem_rdata = (mem8 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         9: mem_rdata = (mem9 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         10: mem_rdata = (mem10 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         11: mem_rdata = (mem11 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         12: mem_rdata = (mem12 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         13: mem_rdata = (mem13 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         14: mem_rdata = (mem14 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         15: mem_rdata = (mem15 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         16: mem_rdata = (mem16 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         17: mem_rdata = (mem17 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         18: mem_rdata = (mem18 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         19: mem_rdata = (mem19 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         20: mem_rdata = (mem20 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         21: mem_rdata = (mem21 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         22: mem_rdata = (mem22 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         23: mem_rdata = (mem23 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         24: mem_rdata = (mem24 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         25: mem_rdata = (mem25 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         26: mem_rdata = (mem26 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         27: mem_rdata = (mem27 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         28: mem_rdata = (mem28 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         29: mem_rdata = (mem29 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         30: mem_rdata = (mem30 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//         31: mem_rdata = (mem31 & {{16{~(mask_b | mask_h)}}, {8{~mask_b}}, {8{1'b1}}}) | ({32{ext}} & {{16{(mask_b | mask_h)}}, {8{mask_b}}, {8{1'b0}}});
//     endcase

// end

// always @(*) begin

//     case(funct3)
//         0: begin
//             mem0_n = (MemWrite && (0 == addr)) ? {mem0[31:8], rs2_rdata_M[7:0]} : mem0; 
//             mem1_n = (MemWrite && (1 == addr)) ? {mem1[31:8], rs2_rdata_M[7:0]} : mem1; 
//             mem2_n = (MemWrite && (2 == addr)) ? {mem2[31:8], rs2_rdata_M[7:0]} : mem2; 
//             mem3_n = (MemWrite && (3 == addr)) ? {mem3[31:8], rs2_rdata_M[7:0]} : mem3; 
//             mem4_n = (MemWrite && (4 == addr)) ? {mem4[31:8], rs2_rdata_M[7:0]} : mem4; 
//             mem5_n = (MemWrite && (5 == addr)) ? {mem5[31:8], rs2_rdata_M[7:0]} : mem5; 
//             mem6_n = (MemWrite && (6 == addr)) ? {mem6[31:8], rs2_rdata_M[7:0]} : mem6; 
//             mem7_n = (MemWrite && (7 == addr)) ? {mem7[31:8], rs2_rdata_M[7:0]} : mem7; 
//             mem8_n = (MemWrite && (8 == addr)) ? {mem8[31:8], rs2_rdata_M[7:0]} : mem8; 
//             mem9_n = (MemWrite && (9 == addr)) ? {mem9[31:8], rs2_rdata_M[7:0]} : mem9; 
//             mem10_n = (MemWrite && (10 == addr)) ? {mem10[31:8], rs2_rdata_M[7:0]} : mem10; 
//             mem11_n = (MemWrite && (11 == addr)) ? {mem11[31:8], rs2_rdata_M[7:0]} : mem11; 
//             mem12_n = (MemWrite && (12 == addr)) ? {mem12[31:8], rs2_rdata_M[7:0]} : mem12; 
//             mem13_n = (MemWrite && (13 == addr)) ? {mem13[31:8], rs2_rdata_M[7:0]} : mem13; 
//             mem14_n = (MemWrite && (14 == addr)) ? {mem14[31:8], rs2_rdata_M[7:0]} : mem14; 
//             mem15_n = (MemWrite && (15 == addr)) ? {mem15[31:8], rs2_rdata_M[7:0]} : mem15; 
//             mem16_n = (MemWrite && (16 == addr)) ? {mem16[31:8], rs2_rdata_M[7:0]} : mem16; 
//             mem17_n = (MemWrite && (17 == addr)) ? {mem17[31:8], rs2_rdata_M[7:0]} : mem17; 
//             mem18_n = (MemWrite && (18 == addr)) ? {mem18[31:8], rs2_rdata_M[7:0]} : mem18; 
//             mem19_n = (MemWrite && (19 == addr)) ? {mem19[31:8], rs2_rdata_M[7:0]} : mem19; 
//             mem20_n = (MemWrite && (20 == addr)) ? {mem20[31:8], rs2_rdata_M[7:0]} : mem20; 
//             mem21_n = (MemWrite && (21 == addr)) ? {mem21[31:8], rs2_rdata_M[7:0]} : mem21; 
//             mem22_n = (MemWrite && (22 == addr)) ? {mem22[31:8], rs2_rdata_M[7:0]} : mem22; 
//             mem23_n = (MemWrite && (23 == addr)) ? {mem23[31:8], rs2_rdata_M[7:0]} : mem23; 
//             mem24_n = (MemWrite && (24 == addr)) ? {mem24[31:8], rs2_rdata_M[7:0]} : mem24; 
//             mem25_n = (MemWrite && (25 == addr)) ? {mem25[31:8], rs2_rdata_M[7:0]} : mem25; 
//             mem26_n = (MemWrite && (26 == addr)) ? {mem26[31:8], rs2_rdata_M[7:0]} : mem26; 
//             mem27_n = (MemWrite && (27 == addr)) ? {mem27[31:8], rs2_rdata_M[7:0]} : mem27; 
//             mem28_n = (MemWrite && (28 == addr)) ? {mem28[31:8], rs2_rdata_M[7:0]} : mem28; 
//             mem29_n = (MemWrite && (29 == addr)) ? {mem29[31:8], rs2_rdata_M[7:0]} : mem29; 
//             mem30_n = (MemWrite && (30 == addr)) ? {mem30[31:8], rs2_rdata_M[7:0]} : mem30; 
//             mem31_n = (MemWrite && (31 == addr)) ? {mem31[31:8], rs2_rdata_M[7:0]} : mem31; 
//         end
//         1: begin
//             mem0_n = (MemWrite && (0 == addr)) ? {mem0[31:16], rs2_rdata_M[15:0]} : mem0; 
//             mem1_n = (MemWrite && (1 == addr)) ? {mem1[31:16], rs2_rdata_M[15:0]} : mem1; 
//             mem2_n = (MemWrite && (2 == addr)) ? {mem2[31:16], rs2_rdata_M[15:0]} : mem2; 
//             mem3_n = (MemWrite && (3 == addr)) ? {mem3[31:16], rs2_rdata_M[15:0]} : mem3; 
//             mem4_n = (MemWrite && (4 == addr)) ? {mem4[31:16], rs2_rdata_M[15:0]} : mem4; 
//             mem5_n = (MemWrite && (5 == addr)) ? {mem5[31:16], rs2_rdata_M[15:0]} : mem5; 
//             mem6_n = (MemWrite && (6 == addr)) ? {mem6[31:16], rs2_rdata_M[15:0]} : mem6; 
//             mem7_n = (MemWrite && (7 == addr)) ? {mem7[31:16], rs2_rdata_M[15:0]} : mem7; 
//             mem8_n = (MemWrite && (8 == addr)) ? {mem8[31:16], rs2_rdata_M[15:0]} : mem8; 
//             mem9_n = (MemWrite && (9 == addr)) ? {mem9[31:16], rs2_rdata_M[15:0]} : mem9; 
//             mem10_n = (MemWrite && (10 == addr)) ? {mem10[31:16], rs2_rdata_M[15:0]} : mem10; 
//             mem11_n = (MemWrite && (11 == addr)) ? {mem11[31:16], rs2_rdata_M[15:0]} : mem11; 
//             mem12_n = (MemWrite && (12 == addr)) ? {mem12[31:16], rs2_rdata_M[15:0]} : mem12; 
//             mem13_n = (MemWrite && (13 == addr)) ? {mem13[31:16], rs2_rdata_M[15:0]} : mem13; 
//             mem14_n = (MemWrite && (14 == addr)) ? {mem14[31:16], rs2_rdata_M[15:0]} : mem14; 
//             mem15_n = (MemWrite && (15 == addr)) ? {mem15[31:16], rs2_rdata_M[15:0]} : mem15; 
//             mem16_n = (MemWrite && (16 == addr)) ? {mem16[31:16], rs2_rdata_M[15:0]} : mem16; 
//             mem17_n = (MemWrite && (17 == addr)) ? {mem17[31:16], rs2_rdata_M[15:0]} : mem17; 
//             mem18_n = (MemWrite && (18 == addr)) ? {mem18[31:16], rs2_rdata_M[15:0]} : mem18; 
//             mem19_n = (MemWrite && (19 == addr)) ? {mem19[31:16], rs2_rdata_M[15:0]} : mem19; 
//             mem20_n = (MemWrite && (20 == addr)) ? {mem20[31:16], rs2_rdata_M[15:0]} : mem20; 
//             mem21_n = (MemWrite && (21 == addr)) ? {mem21[31:16], rs2_rdata_M[15:0]} : mem21; 
//             mem22_n = (MemWrite && (22 == addr)) ? {mem22[31:16], rs2_rdata_M[15:0]} : mem22; 
//             mem23_n = (MemWrite && (23 == addr)) ? {mem23[31:16], rs2_rdata_M[15:0]} : mem23; 
//             mem24_n = (MemWrite && (24 == addr)) ? {mem24[31:16], rs2_rdata_M[15:0]} : mem24; 
//             mem25_n = (MemWrite && (25 == addr)) ? {mem25[31:16], rs2_rdata_M[15:0]} : mem25; 
//             mem26_n = (MemWrite && (26 == addr)) ? {mem26[31:16], rs2_rdata_M[15:0]} : mem26; 
//             mem27_n = (MemWrite && (27 == addr)) ? {mem27[31:16], rs2_rdata_M[15:0]} : mem27; 
//             mem28_n = (MemWrite && (28 == addr)) ? {mem28[31:16], rs2_rdata_M[15:0]} : mem28; 
//             mem29_n = (MemWrite && (29 == addr)) ? {mem29[31:16], rs2_rdata_M[15:0]} : mem29; 
//             mem30_n = (MemWrite && (30 == addr)) ? {mem30[31:16], rs2_rdata_M[15:0]} : mem30; 
//             mem31_n = (MemWrite && (31 == addr)) ? {mem31[31:16], rs2_rdata_M[15:0]} : mem31; 
//         end 
//         default: begin
//             mem0_n = (MemWrite && (0 == addr)) ? rs2_rdata_M : mem0; 
//             mem1_n = (MemWrite && (1 == addr)) ? rs2_rdata_M : mem1; 
//             mem2_n = (MemWrite && (2 == addr)) ? rs2_rdata_M : mem2; 
//             mem3_n = (MemWrite && (3 == addr)) ? rs2_rdata_M : mem3; 
//             mem4_n = (MemWrite && (4 == addr)) ? rs2_rdata_M : mem4; 
//             mem5_n = (MemWrite && (5 == addr)) ? rs2_rdata_M : mem5; 
//             mem6_n = (MemWrite && (6 == addr)) ? rs2_rdata_M : mem6; 
//             mem7_n = (MemWrite && (7 == addr)) ? rs2_rdata_M : mem7; 
//             mem8_n = (MemWrite && (8 == addr)) ? rs2_rdata_M : mem8; 
//             mem9_n = (MemWrite && (9 == addr)) ? rs2_rdata_M : mem9; 
//             mem10_n = (MemWrite && (10 == addr)) ? rs2_rdata_M : mem10; 
//             mem11_n = (MemWrite && (11 == addr)) ? rs2_rdata_M : mem11; 
//             mem12_n = (MemWrite && (12 == addr)) ? rs2_rdata_M : mem12; 
//             mem13_n = (MemWrite && (13 == addr)) ? rs2_rdata_M : mem13; 
//             mem14_n = (MemWrite && (14 == addr)) ? rs2_rdata_M : mem14; 
//             mem15_n = (MemWrite && (15 == addr)) ? rs2_rdata_M : mem15; 
//             mem16_n = (MemWrite && (16 == addr)) ? rs2_rdata_M : mem16; 
//             mem17_n = (MemWrite && (17 == addr)) ? rs2_rdata_M : mem17; 
//             mem18_n = (MemWrite && (18 == addr)) ? rs2_rdata_M : mem18; 
//             mem19_n = (MemWrite && (19 == addr)) ? rs2_rdata_M : mem19; 
//             mem20_n = (MemWrite && (20 == addr)) ? rs2_rdata_M : mem20; 
//             mem21_n = (MemWrite && (21 == addr)) ? rs2_rdata_M : mem21; 
//             mem22_n = (MemWrite && (22 == addr)) ? rs2_rdata_M : mem22; 
//             mem23_n = (MemWrite && (23 == addr)) ? rs2_rdata_M : mem23; 
//             mem24_n = (MemWrite && (24 == addr)) ? rs2_rdata_M : mem24; 
//             mem25_n = (MemWrite && (25 == addr)) ? rs2_rdata_M : mem25; 
//             mem26_n = (MemWrite && (26 == addr)) ? rs2_rdata_M : mem26; 
//             mem27_n = (MemWrite && (27 == addr)) ? rs2_rdata_M : mem27; 
//             mem28_n = (MemWrite && (28 == addr)) ? rs2_rdata_M : mem28; 
//             mem29_n = (MemWrite && (29 == addr)) ? rs2_rdata_M : mem29; 
//             mem30_n = (MemWrite && (30 == addr)) ? rs2_rdata_M : mem30; 
//             mem31_n = (MemWrite && (31 == addr)) ? rs2_rdata_M : mem31; 
//         end
//     endcase

// end

endmodule










