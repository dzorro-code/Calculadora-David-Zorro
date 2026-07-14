module sqrt(clk, rst, init, A, A2, R, done);
input clk;
input rst;
input init;
input [15:0]A;

output [15:0]A2;
output [7:0]R; //
output done;

wire w_ld_A1;
wire w_ld_A2;
wire w_add_0;
wire w_add_1;
wire w_ld_R1;
wire w_sh;

wire w_c;
wire w_z;
wire w_m;



wire [3:0]w_violeta; //contadorr

wire [15:0]w_A2; //Este es el que le entra al modulo reg A

wire [9:0]w_R1; //Este es el que le sale al modulo r1

regA regA0(.clk(clk),.load(w_ld_A1),.shift(w_sh),.load2(w_ld_A2),.A(A),.A2in(w_A2),.A2(A2));


comp comp0(.A2(A2),.z(w_z));//donee

regR regR0(.clk(clk),.rst(w_ld_A1),.add_0(w_add_0),.add_1(w_add_1),.R(R));//done  

regR1 regR10(.clk(clk),.rst(w_ld_A1),.load(w_ld_R1),.R01({R,2'b01}),.R1(w_R1));

comp1 comp10(.A2(A2),.R1(w_R1),.m(w_m));//donee

restar restar0(.R1(w_R1),.A2(A2),.A2out(w_A2));

count count0(.clk(clk),.reset(w_ld_A1),.dec(w_sh),.count(w_violeta));

comp_count comp_count0(.count(w_violeta),.c(w_c));







state_machinesqrt state_machinesqrt0(.clk(clk),.rst(rst),.init(init),.c(w_c),.z(w_z),.m(w_m),.ld_A1(w_ld_A1),.ld_A2(w_ld_A2),.add_0(w_add_0),.add_1(w_add_1),.ld_R1(w_ld_R1),.sh(w_sh),.done(done));//done

endmodule