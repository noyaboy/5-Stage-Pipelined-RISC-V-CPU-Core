set power_enable_analysis true
set power_analysis_mode time_based
set power_enable_clock_scaling true

set search_path ". /usr/cadtool/GPDK45/gsclib045_svt_v4.4/gsclib045/db/  \
                   /usr/cadtool/GPDK45/gsclib045_svt_v4.4/gsclib045/verilog/ \
                   /usr/cad/synopsys/synthesis/cur/libraries/syn/ \
                   $search_path"
set target_library  "slow_vdd1v2_basicCells.db \
                     fast_vdd1v2_basicCells.db "
set link_library  "  * $target_library  \
                       dw_foundation.sldb "
read_verilog  ../../APR/post_layout/CHIP.v
current_design  top_riscv_core
link
read_sdc ../../APR/post_layout/CHIP_layout.sdc
# read spef here
read_parasitics ../../APR/post_layout/CHIP_layout.gz
# read waveform
read_fsdb ../../RTL/sim/gatesim_quicksort.fsdb -strip_path test_top_quicksort/top_riscv_core_U0

check_power
update_power
report_power  -hier > report_power_hier.rpt
report_power  > report_power.rpt
exit
