module top(
    input clk,
    output led_out
);
    reg rst = 1;
    reg [19:0] delay = 0;
    reg init_trigger = 0;

    always @(posedge clk) begin
        if (rst) begin
            // Retardo inicial para estabilizar el hardware al energizar
            if (delay < 20'hFFFF) begin
                delay <= delay + 1;
            end else begin
                rst <= 0;
                delay <= 0;
            end
        end else begin
            // Contador principal de la tasa de refresco (50 FPS)
            // 500,000 ciclos de reloj a 25MHz equivalen a 20 milisegundos
            if (delay < 20'd500_000) begin 
                delay <= delay + 1;
                init_trigger <= 0; // Mantenemos la señal en reposo
            end else begin
                delay <= 0;
                init_trigger <= 1; // Mandamos un pulso exacto de 1 ciclo de reloj
            end
        end
    end

    // Instancia del módulo de tu compañero
    ws2812_array array_compa (
        .clk(clk),
        .RST_CMD(rst),
        .INIT_M(init_trigger), // Reemplazamos el 1 por nuestro pulso rítmico
        .DONE_M(), 
        .DOUT(led_out)
    );

endmodule
