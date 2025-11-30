# 5-Stage Pipelined RISC-V CPU Core

A 5-stage pipelined processor implementing the RISC-V RV32I instruction set architecture, developed for the IC Design Laboratory course at National Tsing Hua University.

## Features

- **5-Stage Pipeline**: IF, ID, EX, MEM, WB stages with pipeline registers
- **RV32I Support**: Complete base integer instruction set
- **Hazard Resolution**: Data forwarding unit and stall unit for hazard control
- **Memory**: Dual-bank instruction cache (256 words), single-port data cache (128 words)

## Supported Instructions

| Type | Instructions |
|------|-------------|
| R-Type | ADD, SUB, XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU |
| I-Type (ALU) | ADDI, XORI, ORI, ANDI, SLLI, SRLI, SRAI, SLTI, SLTIU |
| Load | LW, LB |
| Store | SW, SB |
| Branch | BEQ, BNE |
| Jump | JAL, JALR |
| U-Type | LUI, AUIPC |

## Project Structure

```
ICLAB/
├── RTL/
│   ├── hdl/                   # Verilog RTL source files
│   │   ├── Def.v              # Opcode and function definitions
│   │   ├── top_riscv_core.v   # Top-level module
│   │   ├── ALU.v              # Arithmetic Logic Unit
│   │   ├── Control.v          # Control unit
│   │   ├── PC.v               # Program counter
│   │   ├── Icache.v           # Instruction cache (2x128 words)
│   │   ├── Dcache.v           # Data cache (128 words)
│   │   ├── regfile.v          # Register file (32x32-bit)
│   │   ├── imm_gen.v          # Immediate generator
│   │   ├── forward_unit.v     # Data forwarding unit
│   │   ├── stall_unit.v       # Stall detection unit
│   │   ├── nop_mux.v          # NOP insertion multiplexer
│   │   ├── IF_ID.v            # IF/ID pipeline register
│   │   ├── ID_EX.v            # ID/EX pipeline register
│   │   ├── EX_M.v             # EX/MEM pipeline register
│   │   └── M_RB.v             # MEM/WB pipeline register
│   └── sim/                   # Simulation testbench
│       ├── test_top.v
│       └── run_sim.sh
├── SYN/                       # Synthesis scripts (Design Compiler)
│   ├── synthesis.tcl          # Main synthesis script
│   ├── 0_readfile.tcl         # Read design files
│   ├── 1_setting.tcl          # Timing constraints
│   ├── 2_compile.tcl          # Compile design
│   └── 3_report.tcl           # Generate reports
├── APR/                       # Place & Route (Innovus)
├── LEC/                       # Logic Equivalence Checking
└── SW/                        # Test pattern generation
    ├── assem_gen_recur.py     # Assembly test generator
    └── TP/                    # Generated test patterns
```

## Quick Start

### RTL Simulation

```bash
cd RTL/sim
./run_sim.sh
```

This runs 999 random test patterns and verifies register/memory values against golden references.

### Synthesis

```bash
cd SYN
dc_shell -f synthesis.tcl | tee synthesis.log
```

Or use the provided shell script:
```bash
cd SYN
./run_syn.sh
```

### Test Pattern Generation

```bash
cd SW
python assem_gen_recur.py <pattern_number>
```

## Architecture

```
┌────┐   ┌───────┐   ┌────┐   ┌────────┐   ┌────┐   ┌───────┐   ┌─────┐   ┌──────┐   ┌────┐
│ IF │──▶│ IF/ID │──▶│ ID │──▶│ ID/EX  │──▶│ EX │──▶│ EX/M  │──▶│ MEM │──▶│ M/WB │──▶│ WB │
└────┘   └───────┘   └────┘   └────────┘   └────┘   └───────┘   └─────┘   └──────┘   └────┘
   │                    │                     │         │          │
   │                    └─────────────────────┴─────────┴──────────┘
   │                              Forwarding Paths
   │
   └──── Stall/Flush Control ────────────────────────────────────────
```

## Synthesis Results

| Metric | Value |
|--------|-------|
| Technology | GPDK 45nm |
| Clock Period | 5.58 ns |
| Clock Frequency | 179.21 MHz |
| Total Cell Area | 158,257.43 μm² |
| Combinational Area | 39,355.31 μm² |
| Sequential Area | 118,902.12 μm² |
| Total Power | 5.109 mW |

## EDA Tools

- **Simulation**: Synopsys VCS
- **Synthesis**: Synopsys Design Compiler
- **Place & Route**: Cadence Innovus
- **LEC**: Cadence Conformal

## License

For educational purposes only - IC Design Lab, NTHU.
