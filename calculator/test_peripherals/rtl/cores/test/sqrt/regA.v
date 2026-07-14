module regA (
    input clk,
    input load,
    input load2,
    input shift,
    input [15:0] A,
    input [15:0] A2in,

    output [15:0] A2
);


reg [31:0] regA_total;

assign A2 = regA_total[31:16];

always @(negedge clk)
begin
    if (load)
        regA_total <= {16'b0,A};
    else if (load2)
        regA_total[31:16] <= A2in;
    else if (shift)
        regA_total <= regA_total << 2;
end

endmodule