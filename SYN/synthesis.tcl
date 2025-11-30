# set your TOPLEVEL here
set TOPLEVEL "top_riscv_core"

# change your timing constraint here
set TEST_CYCLE 5.58

# source each script (0_readfile ~ 3_report)
source -echo -verbose 0_readfile.tcl
source -echo -verbose 1_setting.tcl
source -echo -verbose 2_compile.tcl
source -echo -verbose 3_report.tcl

exit
