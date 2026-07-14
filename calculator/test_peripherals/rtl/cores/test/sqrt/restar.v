module restar (
input  [9:0]R1,
input  [15:0]A2,
output [15:0]A2out);

assign A2out = (A2 - R1);

endmodule