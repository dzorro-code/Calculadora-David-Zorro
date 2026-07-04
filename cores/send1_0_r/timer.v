module timer(
    input init_t;
    input [1:0]sel;
    input rst;
    output dout;
    output done_t;
);

wire z;
wire rst ;
wire inc;
reg [1:0] sel_tim;
reg [10:0] mux_out;// Para representar el hasta 1250 requiero 11 bits

ctrl crtl0(.init_t(init_t),.sel(sel),.z(z),.dout(dout),.done_t(done_t),.rst(rst),.inc(),.sel_tim(sel_tim));
count_out count_out0(.rst(rst),.inc(inc));
mux mux0(.sel_tim(sel_tim),.mux_out(mux_out));
comp comp0(mux_out(mux_out));
endmodule