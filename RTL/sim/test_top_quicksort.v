//==================================================================================================
//  Note:          Use only for teaching materials of IC Design Lab, NTHU.
//  Copyright: (c) 2022 Vision Circuits and Systems Lab, NTHU, Taiwan. ALL Rights Reserved.
//==================================================================================================
//`include "../hdl/Def.v"
`timescale  1ns/1ps
module test_top_quicksort;

parameter PERIOD = 8.28; //8.28
parameter WORD = 255;
parameter ADDR_WIDTH = 8;
parameter ADDR_NUM = 256;

//inputtest_top.v

reg clk;
reg rst_n;
reg [31:0] instruction [255:0];

//wire [15:0]PC_out;
wire EXE_alu_overflow;

reg boot_up;
reg [ADDR_WIDTH-1:0] boot_addr;
reg [31:0] boot_datai;
wire valid;

top_riscv_core top_riscv_core_U0(
	.clk(clk),
	.rst_n(rst_n),
	.boot_up(boot_up),
	.boot_addr(boot_addr),
	.boot_datai(boot_datai),
	.valid(valid)
);


initial begin
`ifdef GATESIM
	$fsdbDumpfile("gatesim_quicksort.fsdb");
	$fsdbDumpvars("+mda", top_riscv_core_U0);
		$sdf_annotate("../../SYN/netlist/top_riscv_core_syn.sdf", top_riscv_core_U0);
	$display("================================");
	$display("=           Gatesim!           =");
	$display("================================");
`elsif POSTSIM
	$fsdbDumpfile("./postsim_quicksort.fsdb");
	$fsdbDumpvars("+mda", top_riscv_core_U0);
	$sdf_annotate("../../APR/post_layout/CHIP.sdf", top_riscv_core_U0);
`else
	$fsdbDumpfile("./sim_quicksort.fsdb");
	$fsdbDumpvars("+mda");
	$fsdbDumpvars;
`endif
end

parameter BOOT_CODE_SIZE = 84;

reg [31:0] mem [0:BOOT_CODE_SIZE-1];
reg [31:0] regs [0:42-1];

integer f_golden, cnt;

integer k;
//read instuction from instruction.txt to Icache
initial begin
	// $readmemb("instruction.txt", mem, 0 , BOOT_CODE_SIZE-1);
	$readmemb("../../SW/TP/quicksort/instruction_quicksort.txt", mem, 0 , BOOT_CODE_SIZE-1);
	// $readmemb("./TP/decoder/instruction_001.txt", mem, 0 , BOOT_CODE_SIZE-1);
end

initial begin
	f_golden = $fopen("../../SW/TP/quicksort/golden_quicksort.txt", "r");
	// f_golden = $fopen("/.TP/interpreter/golden_001.txt", "r");
	for(k = 0; k < 42; k = k + 1) begin
		cnt = $fscanf(f_golden, "%d", regs[k]);
	end
	// $fclose(f_golden);
end


always #(PERIOD/2) clk = ~clk;

integer j;

initial begin
clk = 1;
rst_n = 1;
boot_up = 0;
boot_addr = 0;
boot_datai = 0;
@(negedge clk);
#(PERIOD) rst_n = 0;
#(PERIOD) rst_n = 1; boot_up =1;
for (j=0 ; j<256;j=j+1)begin
	if(j < BOOT_CODE_SIZE) begin
		#(PERIOD) boot_addr = j[ADDR_WIDTH-1:0];
		          boot_datai = mem[j];
	end
	else 	begin
		#(PERIOD) boot_addr = j[ADDR_WIDTH-1:0];
		          boot_datai = {32{1'b0}};
	end
end


#(PERIOD) boot_up =0; boot_addr = 0; boot_datai = 0;

end




//fsdb result
integer r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
integer d2,d4,d6,d8;

initial begin
#(PERIOD);
@(negedge boot_up);
@(negedge clk);
@(negedge clk);

#(PERIOD*(1000)); //1000
// #(PERIOD*52);

show_register_value();

#(PERIOD) $finish;
end



integer f_register;
integer std_out = 1;
integer write_to;
integer i;
integer error = 0;
task show_register_value;
begin

f_register = $fopen("./register_sim.txt");
write_to = f_register | std_out;
$fdisplay(write_to, "r1 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[1]), $signed(regs[1]));
$fdisplay(write_to, "r2 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[2]), $signed(regs[2]));
$fdisplay(write_to, "r3 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[3]), $signed(regs[3]));
$fdisplay(write_to, "r4 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[4]), $signed(regs[4]));
$fdisplay(write_to, "r5 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[5]), $signed(regs[5]));
$fdisplay(write_to, "r6 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[6]), $signed(regs[6]));
$fdisplay(write_to, "r7 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[7]), $signed(regs[7]));
$fdisplay(write_to, "r8 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[8]), $signed(regs[8]));
$fdisplay(write_to, "r9 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[9]), $signed(regs[9]));
$fdisplay(write_to, "r10 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[10]), $signed(regs[10]));
$fdisplay(write_to, "r11 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[11]), $signed(regs[11]));
$fdisplay(write_to, "r12 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[12]), $signed(regs[12]));
$fdisplay(write_to, "r13 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[13]), $signed(regs[13]));
$fdisplay(write_to, "r14 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[14]), $signed(regs[14]));
$fdisplay(write_to, "r15 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[15]), $signed(regs[15]));
$fdisplay(write_to, "r16 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[16]), $signed(regs[16]));
$fdisplay(write_to, "r17 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[17]), $signed(regs[17]));
$fdisplay(write_to, "r18 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[18]), $signed(regs[18]));
$fdisplay(write_to, "r19 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[19]), $signed(regs[19]));
$fdisplay(write_to, "r20 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[20]), $signed(regs[20]));
$fdisplay(write_to, "r21 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[21]), $signed(regs[21]));
$fdisplay(write_to, "r22 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[22]), $signed(regs[22]));
$fdisplay(write_to, "r23 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[23]), $signed(regs[23]));
$fdisplay(write_to, "r24 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[24]), $signed(regs[24]));
$fdisplay(write_to, "r25 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[25]), $signed(regs[25]));
$fdisplay(write_to, "r26 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[26]), $signed(regs[26]));
$fdisplay(write_to, "r27 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[27]), $signed(regs[27]));
$fdisplay(write_to, "r28 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[28]), $signed(regs[28]));
$fdisplay(write_to, "r29 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[29]), $signed(regs[29]));
$fdisplay(write_to, "r30 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[30]), $signed(regs[30]));
$fdisplay(write_to, "r31 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.regfile_U0.gpr[31]), $signed(regs[31]));

$fdisplay(write_to, "d0 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[0]), $signed(regs[32]));
$fdisplay(write_to, "d1 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[1]), $signed(regs[33]));
$fdisplay(write_to, "d2 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[2]), $signed(regs[34]));
$fdisplay(write_to, "d3 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[3]), $signed(regs[35]));
$fdisplay(write_to, "d4 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[4]), $signed(regs[36]));
$fdisplay(write_to, "d5 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[5]), $signed(regs[37]));
$fdisplay(write_to, "d6 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[6]), $signed(regs[38]));
$fdisplay(write_to, "d7 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[7]), $signed(regs[39]));
$fdisplay(write_to, "d8 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[8]), $signed(regs[40]));
$fdisplay(write_to, "d9 = %d ,the answer is %d\n", $signed(top_riscv_core_U0.Dcache_U0.mem[9]), $signed(regs[41]));

$fclose(f_register);

for(i = 0; i < 32; i = i + 1) begin
	if(top_riscv_core_U0.regfile_U0.gpr[i] != regs[i]) begin
		$display("Error at register %d", i);
		error = error + 1;
	end
end

for(i = 0; i < 10; i = i + 1) begin
	if(top_riscv_core_U0.Dcache_U0.mem[i] != regs[32+i]) begin
		$display("Error at memory %d", i);
		error = error + 1;
	end
end

// if(top_riscv_core_U0.regfile_U0.gpr0 != regs[0]) begin
// 	$display("Error at register 0");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr1 != regs[1]) begin
// 	$display("Error at register 1");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr2 != regs[2]) begin
// 	$display("Error at register 2");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr3 != regs[3]) begin
// 	$display("Error at register 3");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr4 != regs[4]) begin
// 	$display("Error at register 4");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr5 != regs[5]) begin
// 	$display("Error at register 5");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr6 != regs[6]) begin
// 	$display("Error at register 6");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr7 != regs[7]) begin
// 	$display("Error at register 7");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr8 != regs[8]) begin
// 	$display("Error at register 8");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr9 != regs[9]) begin
// 	$display("Error at register 9");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr10 != regs[10]) begin
// 	$display("Error at register 10");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr11 != regs[11]) begin
// 	$display("Error at register 11");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr12 != regs[12]) begin
// 	$display("Error at register 12");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr13 != regs[13]) begin
// 	$display("Error at register 13");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr14 != regs[14]) begin
// 	$display("Error at register 14");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr15 != regs[15]) begin
// 	$display("Error at register 15");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr16 != regs[16]) begin
// 	$display("Error at register 16");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr17 != regs[17]) begin
// 	$display("Error at register 17");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr18 != regs[18]) begin
// 	$display("Error at register 18");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr19 != regs[19]) begin
// 	$display("Error at register 19");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr20 != regs[20]) begin
// 	$display("Error at register 20");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr21 != regs[21]) begin
// 	$display("Error at register 21");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr22 != regs[22]) begin
// 	$display("Error at register 22");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr23 != regs[23]) begin
// 	$display("Error at register 23");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr24 != regs[24]) begin
// 	$display("Error at register 24");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr25 != regs[25]) begin
// 	$display("Error at register 25");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr26 != regs[26]) begin
// 	$display("Error at register 26");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr27 != regs[27]) begin
// 	$display("Error at register 27");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr28 != regs[28]) begin
// 	$display("Error at register 28");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr29 != regs[29]) begin
// 	$display("Error at register 29");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr30 != regs[30]) begin
// 	$display("Error at register 30");
// 	error = error + 1;
// end
// if(top_riscv_core_U0.regfile_U0.gpr31 != regs[31]) begin
// 	$display("Error at register 31");
// 	error = error + 1;
// end




// if(top_riscv_core_U0.Dcache_U0.mem0 != regs[32+0]) begin
// 	$display("Error at memory %d", 0);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem1 != regs[32+1]) begin
// 	$display("Error at memory %d", 1);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem2 != regs[32+2]) begin
// 	$display("Error at memory %d", 2);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem3 != regs[32+3]) begin
// 	$display("Error at memory %d", 3);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem4 != regs[32+4]) begin
// 	$display("Error at memory %d", 4);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem5 != regs[32+5]) begin
// 	$display("Error at memory %d", 5);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem6 != regs[32+6]) begin
// 	$display("Error at memory %d", 6);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem7 != regs[32+7]) begin
// 	$display("Error at memory %d", 7);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem8 != regs[32+8]) begin
// 	$display("Error at memory %d", 8);
// 	error = error + 1;
// end
// if(top_riscv_core_U0.Dcache_U0.mem9 != regs[32+9]) begin
// 	$display("Error at memory %d", 9);
// 	error = error + 1;
// end

if (error == 0) begin
	$display("================================");
	$display("=       Congratulations!       =");
	$display("================================");
end

end
endtask









endmodule
