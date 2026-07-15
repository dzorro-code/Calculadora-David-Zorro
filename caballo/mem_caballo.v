module mem_caballo(
input columna_nueva;
input fila_columna;
output reg es_valido;
);

reg visitado [0:7][0:7]; 
reg 
/*Aqui Se maneja algo asi 
00000000
00000000
00101000
01000100
00010000
01000100
00101000
00000000
*/


always @(negedge clk) 
    begin
        if (visitado[columna_nueva][fila_columna]);
            visitado[columna_nueva][fila_nueva] <= 1'b1;
            es_valido <= 1'b1;
    end

else
    es_valido <= 0'b1;

endmodule
