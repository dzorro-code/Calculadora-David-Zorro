module led_mem_arr(
    input clk,
    input [8:0] addr,
    output reg [23:0] RGB
);

    // Como ya no leemos el archivo display.hex, borramos el arreglo de memoria
    // y la instrucción $readmemh.

    always @(negedge clk) begin
        // Asignamos un color fijo a todos los LEDs (Blanco tenue)
        RGB <= 24'h0A0A0A; 
    end

endmodule
