module regR1(
input clk,
input rst,
input load,
input [9:0]R01,//({R,2'b01})
output reg [9:0]R1);



always @(negedge clk)
begin
    if (rst)
        R1 <= 10'b0;
    else if (load)
        R1 <= R01;
end
endmodule    