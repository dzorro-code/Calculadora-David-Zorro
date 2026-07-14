module regB (
input clk,
input load,
input [15:0]B,
output reg[15:0]Bout
); 

always @(negedge clk)
begin
    if(load) Bout <= B ;
end
endmodule