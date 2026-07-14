module regr (
    input clk,
    input shiftR,
    input add,

    output reg [15:0] R
);

initial R = 16'b0;

always @(negedge clk)
begin
    if(add)
        R <= (R << 1) + 1;

    else if(shiftR)
        R <= R << 1;
end

endmodule


//do