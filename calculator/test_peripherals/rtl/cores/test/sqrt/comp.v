module comp (
input [15:0] A2,
output z);

assign z = (A2 == 16'b0);

endmodule
