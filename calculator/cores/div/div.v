module div(clk, rst, init, A, B, R, done);
input clk;
input rst;
input init;
input [15:0]A;
input [15:0]B;

output [15:0]R;
output done;

wire w_start;
wire w_shiftA;
wire w_shiftR;
wire w_load;
wire w_inc;
wire w_ok;
wire w_f;

wire [15:0]w_Aprimain; //Este es el que le entra al modulo reg A
wire [15:0]w_Aprimaout; //Este es el que le sale al modulo reg A
wire [15:0]w_B;
wire [4:0]w_count;

regA regA0(.clk(clk),.load(w_start),.load1(w_load),.shiftA(w_shiftA),.A(A),.inAprima(w_Aprimain),.Aout(w_Aprimaout));//done  

regB regB0(.clk(clk),.load(w_start),.B(B),.Bout(w_B)); //doneee

comp comp0(.Aprima(w_Aprimaout),.B(w_B),.ok(w_ok));//donee

sumac2 sumac20(.Aprima(w_Aprimaout),.B(w_B),.Aprimain(w_Aprimain)); //done

regr regr0(.clk(clk),.rst(rst),.shiftR(w_shiftR),.add(w_load),.R(R));//done

increaser increaser0(.clk(clk),.inc(w_inc),.reset(w_start),.count(w_count));//done


comp2 comp20(.count(w_count),.f(w_f));//done


state_machinediv state_machinediv0(.clk(clk),.rst(rst),.init(init),.ok(w_ok),.f(w_f),.start(w_start),.shiftA(w_shiftA),.shiftR(w_shiftR),.load(w_load),.inc(w_inc),.done(done));//done

endmodule

