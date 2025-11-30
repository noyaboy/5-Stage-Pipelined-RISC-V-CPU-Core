

module regfile(
	input clk,
	input srst_n,
	input [4:0] raddr1,
	input [4:0] raddr2,
	input wen,
	input [4:0]  waddr,
	input [31:0] wdata,
	output [31:0] rdata1,
	output [31:0] rdata2
	// output [31:0] sw_data
);

reg [31:0] gpr   [31:0];
reg [31:0] gpr_n [31:0];
integer i;

assign rdata1 = gpr[raddr1];
assign rdata2 = gpr[raddr2];

// assign sw_data = gpr[raddr2];

always @(posedge clk) begin
    if (~srst_n) begin
        for(i = 0; i < 32; i = i + 1) begin
		    gpr[i] <= 0;
	    end
    end
    else begin
		gpr [0] <= 0;
	    for(i = 1; i < 32; i = i + 1) begin
	    	gpr[i] <= gpr_n[i];
	    end
    end
end

always @(*) begin
	for(i = 0; i < 32; i = i + 1) begin
		gpr_n[i] = (wen && (i == waddr)) ? wdata : gpr[i];
	end
end


// reg [31:0] gpr0; 
// reg [31:0] gpr1; 
// reg [31:0] gpr2; 
// reg [31:0] gpr3; 
// reg [31:0] gpr4; 
// reg [31:0] gpr5; 
// reg [31:0] gpr6; 
// reg [31:0] gpr7; 
// reg [31:0] gpr8; 
// reg [31:0] gpr9; 
// reg [31:0] gpr10;
// reg [31:0] gpr11;
// reg [31:0] gpr12;
// reg [31:0] gpr13;
// reg [31:0] gpr14;
// reg [31:0] gpr15;
// reg [31:0] gpr16;
// reg [31:0] gpr17;
// reg [31:0] gpr18;
// reg [31:0] gpr19;
// reg [31:0] gpr20;
// reg [31:0] gpr21;
// reg [31:0] gpr22;
// reg [31:0] gpr23;
// reg [31:0] gpr24;
// reg [31:0] gpr25;
// reg [31:0] gpr26;
// reg [31:0] gpr27;
// reg [31:0] gpr28;
// reg [31:0] gpr29;
// reg [31:0] gpr30;
// reg [31:0] gpr31;
// reg [31:0] gpr0_n;
// reg [31:0] gpr1_n;
// reg [31:0] gpr2_n;
// reg [31:0] gpr3_n;
// reg [31:0] gpr4_n;
// reg [31:0] gpr5_n;
// reg [31:0] gpr6_n;
// reg [31:0] gpr7_n;
// reg [31:0] gpr8_n;
// reg [31:0] gpr9_n;
// reg [31:0] gpr10_n;
// reg [31:0] gpr11_n;
// reg [31:0] gpr12_n;
// reg [31:0] gpr13_n;
// reg [31:0] gpr14_n;
// reg [31:0] gpr15_n;
// reg [31:0] gpr16_n;
// reg [31:0] gpr17_n;
// reg [31:0] gpr18_n;
// reg [31:0] gpr19_n;
// reg [31:0] gpr20_n;
// reg [31:0] gpr21_n;
// reg [31:0] gpr22_n;
// reg [31:0] gpr23_n;
// reg [31:0] gpr24_n;
// reg [31:0] gpr25_n;
// reg [31:0] gpr26_n;
// reg [31:0] gpr27_n;
// reg [31:0] gpr28_n;
// reg [31:0] gpr29_n;
// reg [31:0] gpr30_n;
// reg [31:0] gpr31_n;

// always @(*) begin
// 	rdata1 = 0;
// 	case(raddr1)
// 		0: rdata1 = gpr0;  
// 		1: rdata1 = gpr1;  
// 		2: rdata1 = gpr2;  
// 		3: rdata1 = gpr3;  
// 		4: rdata1 = gpr4;  
// 		5: rdata1 = gpr5;  
// 		6: rdata1 = gpr6;  
// 		7: rdata1 = gpr7;  
// 		8: rdata1 = gpr8;  
// 		9: rdata1 = gpr9;  
// 		10: rdata1 = gpr10; 
// 		11: rdata1 = gpr11; 
// 		12: rdata1 = gpr12; 
// 		13: rdata1 = gpr13; 
// 		14: rdata1 = gpr14; 
// 		15: rdata1 = gpr15; 
// 		16: rdata1 = gpr16; 
// 		17: rdata1 = gpr17; 
// 		18: rdata1 = gpr18; 
// 		19: rdata1 = gpr19; 
// 		20: rdata1 = gpr20; 
// 		21: rdata1 = gpr21; 
// 		22: rdata1 = gpr22; 
// 		23: rdata1 = gpr23; 
// 		24: rdata1 = gpr24; 
// 		25: rdata1 = gpr25; 
// 		26: rdata1 = gpr26; 
// 		27: rdata1 = gpr27; 
// 		28: rdata1 = gpr28; 
// 		29: rdata1 = gpr29; 
// 		30: rdata1 = gpr30; 
// 		31: rdata1 = gpr31; 
// 	endcase
// end

// always @(*) begin
// 	rdata2 = 0;
// 	case(raddr2)
// 		0: rdata2 = gpr0;  
// 		1: rdata2 = gpr1;  
// 		2: rdata2 = gpr2;  
// 		3: rdata2 = gpr3;  
// 		4: rdata2 = gpr4;  
// 		5: rdata2 = gpr5;  
// 		6: rdata2 = gpr6;  
// 		7: rdata2 = gpr7;  
// 		8: rdata2 = gpr8;  
// 		9: rdata2 = gpr9;  
// 		10: rdata2 = gpr10; 
// 		11: rdata2 = gpr11; 
// 		12: rdata2 = gpr12; 
// 		13: rdata2 = gpr13; 
// 		14: rdata2 = gpr14; 
// 		15: rdata2 = gpr15; 
// 		16: rdata2 = gpr16; 
// 		17: rdata2 = gpr17; 
// 		18: rdata2 = gpr18; 
// 		19: rdata2 = gpr19; 
// 		20: rdata2 = gpr20; 
// 		21: rdata2 = gpr21; 
// 		22: rdata2 = gpr22; 
// 		23: rdata2 = gpr23; 
// 		24: rdata2 = gpr24; 
// 		25: rdata2 = gpr25; 
// 		26: rdata2 = gpr26; 
// 		27: rdata2 = gpr27; 
// 		28: rdata2 = gpr28; 
// 		29: rdata2 = gpr29; 
// 		30: rdata2 = gpr30; 
// 		31: rdata2 = gpr31; 
// 	endcase
// end

// always @(posedge clk) begin
//     if (~srst_n) begin
// 		gpr0 <= 0;  
// 		gpr1 <= 0;  
// 		gpr2 <= 0;  
// 		gpr3 <= 0;  
// 		gpr4 <= 0;  
// 		gpr5 <= 0;  
// 		gpr6 <= 0;  
// 		gpr7 <= 0;  
// 		gpr8 <= 0;  
// 		gpr9 <= 0;  
// 		gpr10 <= 0; 
// 		gpr11 <= 0; 
// 		gpr12 <= 0; 
// 		gpr13 <= 0; 
// 		gpr14 <= 0; 
// 		gpr15 <= 0; 
// 		gpr16 <= 0; 
// 		gpr17 <= 0; 
// 		gpr18 <= 0; 
// 		gpr19 <= 0; 
// 		gpr20 <= 0; 
// 		gpr21 <= 0; 
// 		gpr22 <= 0; 
// 		gpr23 <= 0; 
// 		gpr24 <= 0; 
// 		gpr25 <= 0; 
// 		gpr26 <= 0; 
// 		gpr27 <= 0; 
// 		gpr28 <= 0; 
// 		gpr29 <= 0; 
// 		gpr30 <= 0; 
// 		gpr31 <= 0; 
//     end
//     else begin
// 		gpr0 <= 0; 
// 		gpr1 <= gpr1_n; 
// 		gpr2 <= gpr2_n; 
// 		gpr3 <= gpr3_n; 
// 		gpr4 <= gpr4_n; 
// 		gpr5 <= gpr5_n; 
// 		gpr6 <= gpr6_n; 
// 		gpr7 <= gpr7_n; 
// 		gpr8 <= gpr8_n; 
// 		gpr9 <= gpr9_n; 
// 		gpr10 <= gpr10_n; 
// 		gpr11 <= gpr11_n; 
// 		gpr12 <= gpr12_n; 
// 		gpr13 <= gpr13_n; 
// 		gpr14 <= gpr14_n; 
// 		gpr15 <= gpr15_n; 
// 		gpr16 <= gpr16_n; 
// 		gpr17 <= gpr17_n; 
// 		gpr18 <= gpr18_n; 
// 		gpr19 <= gpr19_n; 
// 		gpr20 <= gpr20_n; 
// 		gpr21 <= gpr21_n; 
// 		gpr22 <= gpr22_n; 
// 		gpr23 <= gpr23_n; 
// 		gpr24 <= gpr24_n; 
// 		gpr25 <= gpr25_n; 
// 		gpr26 <= gpr26_n; 
// 		gpr27 <= gpr27_n; 
// 		gpr28 <= gpr28_n; 
// 		gpr29 <= gpr29_n; 
// 		gpr30 <= gpr30_n; 
// 		gpr31 <= gpr31_n; 
//     end
// end

// always @(*) begin

// 	gpr0_n = 0;
// 	gpr1_n = (wen && (1 == waddr)) ? wdata : gpr1;
// 	gpr2_n = (wen && (2 == waddr)) ? wdata : gpr2;
// 	gpr3_n = (wen && (3 == waddr)) ? wdata : gpr3;
// 	gpr4_n = (wen && (4 == waddr)) ? wdata : gpr4;
// 	gpr5_n = (wen && (5 == waddr)) ? wdata : gpr5;
// 	gpr6_n = (wen && (6 == waddr)) ? wdata : gpr6;
// 	gpr7_n = (wen && (7 == waddr)) ? wdata : gpr7;
// 	gpr8_n = (wen && (8 == waddr)) ? wdata : gpr8;
// 	gpr9_n = (wen && (9 == waddr)) ? wdata : gpr9;
// 	gpr10_n = (wen && (10 == waddr)) ? wdata : gpr10;
// 	gpr11_n = (wen && (11 == waddr)) ? wdata : gpr11;
// 	gpr12_n = (wen && (12 == waddr)) ? wdata : gpr12;
// 	gpr13_n = (wen && (13 == waddr)) ? wdata : gpr13;
// 	gpr14_n = (wen && (14 == waddr)) ? wdata : gpr14;
// 	gpr15_n = (wen && (15 == waddr)) ? wdata : gpr15;
// 	gpr16_n = (wen && (16 == waddr)) ? wdata : gpr16;
// 	gpr17_n = (wen && (17 == waddr)) ? wdata : gpr17;
// 	gpr18_n = (wen && (18 == waddr)) ? wdata : gpr18;
// 	gpr19_n = (wen && (19 == waddr)) ? wdata : gpr19;
// 	gpr20_n = (wen && (20 == waddr)) ? wdata : gpr20;
// 	gpr21_n = (wen && (21 == waddr)) ? wdata : gpr21;
// 	gpr22_n = (wen && (22 == waddr)) ? wdata : gpr22;
// 	gpr23_n = (wen && (23 == waddr)) ? wdata : gpr23;
// 	gpr24_n = (wen && (24 == waddr)) ? wdata : gpr24;
// 	gpr25_n = (wen && (25 == waddr)) ? wdata : gpr25;
// 	gpr26_n = (wen && (26 == waddr)) ? wdata : gpr26;
// 	gpr27_n = (wen && (27 == waddr)) ? wdata : gpr27;
// 	gpr28_n = (wen && (28 == waddr)) ? wdata : gpr28;
// 	gpr29_n = (wen && (29 == waddr)) ? wdata : gpr29;
// 	gpr30_n = (wen && (30 == waddr)) ? wdata : gpr30;
// 	gpr31_n = (wen && (31 == waddr)) ? wdata : gpr31;

// end

endmodule
