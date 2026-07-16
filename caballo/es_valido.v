module es_valido(
input [2:0]c_actual,
input [2:0]f_actual,
input [63:0] pos_movi,

output ju_valida
);

wire [5:0] indice_plano = (f_actual * 8) + c_actual;

assign ju_valida = pos_mov[indice_plano];

endmodule