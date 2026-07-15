module ();
reg [7:0] tablero [0:7][0:7];

localparam AZUL   = 8'h01;
localparam BLANCO = 8'h02;

initial begin
    tablero[0][0] = AZUL;   tablero[0][1] = BLANCO;
    tablero[0][2] = AZUL;   tablero[0][3] = BLANCO;
    tablero[0][4] = AZUL;   tablero[0][5] = BLANCO;
    tablero[0][6] = AZUL;   tablero[0][7] = BLANCO;

    tablero[1][0] = BLANCO; tablero[1][1] = AZUL;
    tablero[1][2] = BLANCO; tablero[1][3] = AZUL;
    // ...
end
endmodule
