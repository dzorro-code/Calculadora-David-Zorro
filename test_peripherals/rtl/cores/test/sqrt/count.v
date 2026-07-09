module count (
input clk,
input reset,
input dec,
output reg [3:0]count);

always @(negedge clk)
begin
    if(reset)
        count <= 4'd8;
    else if(dec)
        count <= count - 1;
end

endmodule
