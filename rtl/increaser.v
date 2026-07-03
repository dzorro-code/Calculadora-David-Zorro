module increaser (
    input clk,
    input inc,
    input reset,

    output reg [3:0] count
);

always @(negedge clk)
begin

    if(reset)
        count <= 4'd8;

    else if(inc)
        count <= count - 1;

end

endmodule