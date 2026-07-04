module regA (
    input clk,
    input load,
    input load1,
    input shiftA,
    input [15:0] A,
    input [15:0] inAprima,

    output [15:0] Aout
);

reg [31:0] regA_total;

assign Aout = regA_total[31:16];

always @(negedge clk)
begin
    if (load)
        regA_total <= {16'b0,A};
    else if (load1)
        regA_total[31:16] <= inAprima;
    else if (shiftA)
        regA_total <= regA_total << 1;
end

endmodule