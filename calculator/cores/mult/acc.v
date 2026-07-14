module acc (
input clk,
input acc,
input reset,
input [15:0]A,
output reg[31:0]R
);  

initial R = 0;

always @(negedge clk)
    begin
        if (reset) R <= 32'b0;
        else if (acc) R <= R + {16'b0,A};
    end 

endmodule