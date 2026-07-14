module sumac2(
input [15:0]Aprima,
input [15:0]B,
output [15:0]Aprimain); 

assign Aprimain = Aprima - B;
endmodule