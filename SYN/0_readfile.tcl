set TOP_DIR $TOPLEVEL
set RPT_DIR report
set NET_DIR netlist

sh rm -rf ./$TOP_DIR
sh rm -rf ./$RPT_DIR
sh rm -rf ./$NET_DIR
sh mkdir ./$TOP_DIR
sh mkdir ./$RPT_DIR
sh mkdir ./$NET_DIR

# define a lib path here
define_design_lib $TOPLEVEL -path ./$TOPLEVEL

# Read Design File (add your files here)
set HDL_DIR "../RTL/hdl"

analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/Def.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/top_riscv_core.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/ALU.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/Control.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/Dcache.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/EX_M.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/Icache.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/ID_EX.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/IF_ID.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/imm_gen.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/M_RB.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/nop_mux.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/PC.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/regfile.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/stall_unit.v
analyze -library $TOPLEVEL -format verilog ./$HDL_DIR/forward_unit.v


# elaborate your design
elaborate $TOPLEVEL -architecture verilog -library $TOPLEVEL

# Solve Multiple Instance
set uniquify_naming_style "%s_mydesign_%d"
uniquify

# link the design
current_design $TOPLEVEL
link