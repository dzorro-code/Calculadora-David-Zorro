module increaser (
    input clk,
    input inc,
    input reset,

    output reg [4:0] count
);

always @(negedge clk)
begin

    if(reset)
        count <= 5'd16;

    else if(inc)
        count <= count - 1;

end

endmodule