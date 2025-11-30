

module nop_mux
(
    input [31:0] instr_ID,
    input nop_sel,
    output [31:0] instr_ID_mux
);

assign instr_ID_mux = (nop_sel) ? 32'd0 : instr_ID;


endmodule
