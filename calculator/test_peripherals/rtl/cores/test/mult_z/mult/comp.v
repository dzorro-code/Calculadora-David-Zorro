module comp (
input [15:0]B,
output c);

assign c = (B == 16'b0);

endmodule