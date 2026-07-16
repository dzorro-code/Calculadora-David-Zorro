module pos_mov (
    input clk,
    input rst,
    input cal_mov_va,               // Señal para que calcule los mov
    
    input [2:0] c,                  // Posición actual del caballo columna (0 a 7)
    input [2:0] f,                  // Posición actual del caballo fila (0 a 7)
    input [63:0] jugadas,           // Matriz aplanada: 1 = ya jugada, 0 = libre

    output reg done,
    output reg q_m,                 // 0 y done=1 significa que ya no quedan movimientos
    output reg [63:0] pos_movi      // Matriz aplanada de salida con jugadas posibles
); 

    // Variables internas para el bucle (Yosys las desenrollará en paralelo)
    integer i, j;
    
    // Matrices internas para trabajar la lógica cómodamente en 2D
    reg jugadas_2d [7:0][7:0];
    reg pos_movi_2d [7:0][7:0];

    // Convertimos a 4 bits con signo para manejar desbordamientos matemáticos (ej: 0 - 2 = -2)
    wire signed [3:0] f_actual = {1'b0, f};
    wire signed [3:0] c_actual = {1'b0, c};

    // Bloque combinacional para mapear los vectores planos a matrices 2D y viceversa
    always @(*) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                // Reconstruye la matriz de entrada desde el vector de 64 bits
                jugadas_2d[i][j] = jugadas[(i * 8) + j];
                
                // Aplana la matriz de salida de 2D hacia el vector de 64 bits
                pos_movi[(i * 8) + j] = pos_movi_2d[i][j];
            end
        end
    end

    // Lógica secuencial principal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Al resetear, la salida se llena de unos porque todos los movimientos son posibles
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    pos_movi_2d[i][j] <= 1'b1;
                end
            end
            done <= 1'b0;
            q_m  <= 1'b1;
        end 
        else if (cal_mov_va) begin
            q_m <= 1'b0; // Por defecto asumimos que no hay movimientos hasta encontrar uno

            // El bucle "for" se ejecuta en paralelo (0 ciclos de reloj adicionales)
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    
                    // Condición matemática del movimiento en "L" del caballo
                    if ( ((i - f_actual == 1 || f_actual - i == 1) && (j - c_actual == 2 || c_actual - j == 2)) ||
                        ((i - f_actual == 2 || f_actual - i == 2) && (j - c_actual == 1 || c_actual - j == 1)) ) begin
                        
                        // Si la casilla destino está libre (es 0 en la matriz jugadas)
                        if (jugadas_2d[i][j] == 1'b0) begin
                            pos_movi_2d[i][j] <= 1'b1;
                            q_m <= 1'b1; // Encontró al menos una opción válida
                        end else begin
                            pos_movi_2d[i][j] <= 1'b0; // Ya fue jugada
                        end
                        
                    end else begin
                        pos_movi_2d[i][j] <= 1'b0; // No es un movimiento válido de caballo
                    end
                end
            end
            done <= 1'b1; // Indicamos que el cálculo terminó en este flanco de reloj
        end
        else begin
            done <= 1'b0; // Mantiene la señal abajo si no se está solicitando cálculo
        end
    end

endmodule
