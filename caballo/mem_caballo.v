module mem_caballo(
input columna_nueva;
input fila_columna;
output reg es_valido;
);

reg visitado [0:7][0:7]; 

/*Aqui Se maneja algo asi 
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
*/

always 
if (visitado[columna_nueva][fila_columna]);
    visitado[columna_nueva][fila_nueva] <= 1'b1;
    es_valido <= 1'b1;
else
    es_valido <= 0'b1;

endmodule

