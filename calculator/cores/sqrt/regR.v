module regR (
input clk,
input rst,
input add_0,
input add_1,
output reg [7:0] R);

initial R = 8'b0;

always @(negedge clk)
begin
    if (rst)
        R <= 16'b0;
    if (add_0)
        R <= (R<<1);
    else if(add_1)
        R <= (R<<1) + 1;
end
endmodule
