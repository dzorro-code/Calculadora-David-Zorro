module mult(clk, rst, init, A, B, R, done);
input clk;
input rst;
input init;
input [15:0]A;
input [15:0]B;

output [31:0]R;
output done;


wire w_c;
wire w_ld;
wire w_sh;
wire w_acc;


wire [15:0]w_a; //Este es el que le entra al modulo reg A
wire [15:0]w_b; //Este es el que le sale al modulo reg A


regA regA0(.clk(clk),.load(w_ld),.shift(w_sh),.A(A),.Aout(w_a));//done  

regB regB0(.clk(clk),.load(w_ld),.shift(w_sh),.B(B),.Bout(w_b)); //doneee

comp comp0(.B(w_b),.c(w_c));//donee


acc acc0(.clk(clk),.acc(w_acc),.reset(w_ld),.A(w_a),.R(R));//done  


state_machinemult state_machinemult0(.clk(clk),.rst(rst),.init(init),.c(w_c),.b0(w_b[0]),.acc(w_acc),.ld(w_ld),.sh(w_sh),.done(done));//done

endmodule
