module regA (
    input clk,
    input load,
    input shift,
    input [15:0] A,
    output reg [31:0] Aout
);

initial Aout = 32'b0;


always @(negedge clk)
begin
    if (load)
        Aout <= {16'b0, A};
    else if (shift)
        Aout <= Aout << 1;
end

endmodule