module comp (
input [15:0]Aprima,
input [15:0]B,
output ok);


assign ok = (Aprima >= B);

endmodule
// si A' es mayot que B entonces ok = 1
/* 
module comp(
input [15:0]Aprima,
input [15:0]B,
output ok);
reg tmp;
initial tmp = 0;
assign ok = tmp;
always@(*)
tmp = (Aprima>B) ? 1'b1 : 1'b0;
endmodule
*/

