module reg_tablero (
    input [2:0] c_actual,       // Columna del cursor o caballo
    input [2:0] f_actual,       // Fila del cursor o caballo
    input [63:0] jugadas,       // Historial de casillas ya pisadas
    input [63:0] pos_movi,      // Movimientos posibles 
    input [1:0] load,           // 00: Nada, 01: Cursor, 10: Caballo, 11: Reset
    
    // Salida: 64 LEDs x 24 bits/LED = 1536 bits directos al driver WS2812B
    output reg [1535:0] col_cas  
);

    integer i, j;
    reg [23:0] color_led; // Variable temporal para el cálculo de 24 bits
    
    // Índice plano del LED actual (0 a 63)
    wire [5:0] idx_actual = (f_actual * 8) + c_actual;

    always @(*) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                
                // 1. CUADRÍCULA BASE (Blanco y Azul alternado)
                if ((i + j) % 2 == 0)
                    color_led = 24'hFF_FF_FF; // Blanco (G=FF, R=FF, B=FF)
                else
                    color_led = 24'h00_00_FF; // Azul (G=00, R=00, B=FF)

                // 2. ESTADO DEL JUEGO
                // Si ya fue jugada -> Rojo (G=00, R=FF, B=00)
                if (jugadas[(i * 8) + j] == 1'b1) begin
                    color_led = 24'h00_FF_00; 
                end
                // Si es un movimiento posible -> Verde (G=FF, R=00, B=00)
                else if (pos_movi[(i * 8) + j] == 1'b1) begin
                    color_led = 24'hFF_00_00; 
                end

                // 3. PRIORIDAD: CURSOR O CABALLO (Según señal load)
                if ((i * 8) + j == idx_actual) begin
                    if (load == 2'b01) begin
                        color_led = 24'hA5_FF_00; // Naranja (G=A5, R=FF, B=00)
                    end 
                    else if (load == 2'b10) begin
                        color_led = 24'h00_7F_7F; // Violeta (G=00, R=7F, B=7F)
                    end
                end

                // 4. MAPEO AL VECTOR GIGANTE DE SALIDA
                // Coloca los 24 bits en la rebanada correspondiente de los 1536 bits
                col_cas[((i * 8) + j) * 24 +: 24] = color_led;
            end
        end
    end

endmodule
