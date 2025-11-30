//==================================================================================================
//  Note:          Use only for teaching materials of IC Design Lab, NTHU.
//  Copyright: (c) 2022 Vision Circuits and Systems Lab, NTHU, Taiwan. ALL Rights Reserved.
//==================================================================================================
`define PAT_L 1
`define PAT_U 999
`define NUM_PAT (`PAT_U-`PAT_L+1)

`define PAT_NAME_LENGTH 3

`include "../hdl/Def.v"
module test_top;

parameter PERIOD = 8.6;
parameter WORD = 255;
parameter ADDR_WIDTH = 8;
parameter ADDR_NUM = 256;

//input
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
	$fsdbDumpfile("./gatesim_random.fsdb");
	$fsdbDumpvars;
	$fsdbDumpvars("+mda");
	$sdf_annotate("../../SYN/netlist/top_riscv_core_syn.sdf",top_riscv_core_U0);
`else
	$fsdbDumpfile("./sim_random.fsdb");
	$fsdbDumpvars("+mda");
	$fsdbDumpvars;
`endif
end

parameter BOOT_CODE_SIZE = 175;

reg [31:0] mem [0:BOOT_CODE_SIZE-1];
reg [31:0] regs [0:42-1];

integer f_golden, cnt;

//read instuction from instruction.txt to Icache

always #(PERIOD/2) clk = ~clk;

integer j;





//fsdb result
integer r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
integer d2,d4,d6,d8;
integer pat_idx;
reg [46*8-1:0] instruction_file;
reg [45*8-1:0] golden_file;
integer total_err_pat;

reg [8-1:0] index_digit_2_, index_digit_1_, index_digit_0_;

initial begin
	total_err_pat = 0;
	for(pat_idx  =`PAT_L; pat_idx<=`PAT_U; pat_idx = pat_idx + 1)begin
		instruction_file = "../../SW/TP/decoder/instruction_000.txt";

		index_digit_2_ = (pat_idx%1000)/100+48;
        index_digit_1_ = (pat_idx%100)/10+48;
        index_digit_0_ = (pat_idx%10)+48;

		instruction_file[4*8+`PAT_NAME_LENGTH*8 - 1:4*8] = {index_digit_2_, index_digit_1_, index_digit_0_};

		$readmemb(instruction_file, mem, 0 , BOOT_CODE_SIZE-1);


        $display("\n================================================================");
        $display("======================== Pattern No. %02d ========================", pat_idx);
        $display("================================================================");
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


		#(2*PERIOD);
		// @(negedge boot_up);
		// @(negedge clk);
		// @(negedge clk);

		@(posedge valid)
		// #(PERIOD*(256));
		// #(PERIOD*BOOT_CODE_SIZE+5);

		load_golden(pat_idx);
		show_register_value();
	end		
		if (total_err_pat == 0) begin
			$display("================================");
			$display("=       Congratulations!       =");
			$display("================================");
		end

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

	if(error!=0) $finish;

	total_err_pat = total_err_pat + error;

	end
endtask


task load_golden(
    input integer index
);
    reg [8-1:0] index_digit_2, index_digit_1, index_digit_0;
	integer k;

    begin
        golden_file  = "../../SW/TP/interpreter/golden_000.txt"; 

        index_digit_2 = (index%1000)/100+48;
        index_digit_1 = (index%100)/10+48;
        index_digit_0 = (index%10)+48;

        golden_file[4*8+:`PAT_NAME_LENGTH*8] = {index_digit_2, index_digit_1, index_digit_0};
       
        // golden
    	f_golden = $fopen(golden_file, "r");
		for(k = 0; k < 42; k = k + 1) begin
			cnt = $fscanf(f_golden, "%d", regs[k]);
		end
		$fclose(f_golden);

    end


endtask










endmodule
