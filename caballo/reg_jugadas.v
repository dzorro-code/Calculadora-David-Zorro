module reg_jugadas (
    input clk,
    input rst,
    input anadir_jugada,
    
    input [2:0] c_actual,       // Columna actual (0 a 7)
    input [2:0] f_actual,       // Fila actual (0 a 7)
    
    output cas_llenas,          // 1 cuando las 64 casillas sean 1
    output reg [63:0] jugadas   // Vector plano de 64 bits con el historial
);

    // Calcula el índice plano (0 a 63) a partir de la fila y columna actuales
    // Yosys optimizará la multiplicación (*8) usando un simple desplazamiento de bits en hardware
    wire [5:0] indice_plano = (f_actual * 8) + c_actual;

    // Operador de reducción: Evalúa un AND bit a bit sobre todo el vector.
    // Si todos los 64 bits son 1, cas_llenas se pone en 1 automáticamente.
    assign cas_llenas = &jugadas;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Al resetear el juego, el tablero inicia completamente limpio (en ceros)
            jugadas <= 64'b0;
        end 
        else if (anadir_jugada) begin
            // Usamos un desplazador dinámico para poner un '1' exactamente en la posición indicada
            // y lo sumamos (u operamos con OR) al registro actual de jugadas
            jugadas <= jugadas | (64'b1 << indice_plano);
        end
    end

endmodule
