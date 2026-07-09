module regB (
input clk,
input load,
input shift,
input [15:0]B,
output reg[15:0]Bout);

always @(negedge clk)
begin
    if (load) Bout <= B;
    else if (shift) Bout <= Bout>>1; 

end

endmodule