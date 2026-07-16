module top(
    input clk;
    input btn_up;
    input btn_down;
    input btn_left;
    input btn_right;
    input btn_enter;
    input btn_rst;

    output D_OUT;
);

wire [2:0] w_c, w_f;
wire [63:0]w_pos_mov;
wire [63:0]w_jugadas;
wire [1536]w_tablero;
wire [1536]w_tablero_temp;


//le entran a la mc
wire w_ju_valida;
wire w_qm;
wire w_done_q;
wire w_cas_llenas;

//salen de mc
wire w_up;
wire w_down;
wire w_left;
wire w_right;
wire w_load_fc;
wire w_add_jugada;
wire [1:0]w_load_t;
wire w_load_temp;
wire w_cal_mov_val;
wire w_rst;
wire ld;
wire [1:0] p;



//cosas de sebastian
wire [8:0]w_addr;


regc regc0(.clk(clk),.rst(w_rst),.shift_r(w_right),.shift_l(w_left),.c_out(w_c));

regf regf0(.clk(clk),.rst(w_rst),.shift_u(w_up),.shift_d(w_down),.f_out(w_f));

pos_mov pos_mov0(.clk(clk),.rst(w_rst),.cal_mov_val(w_cal_mov_val),.c(w_c),.f(w_f),.jugadas(w_jugadas),.done(w_done_q),.q_m(w_qm),.pos_movi(w_pos_mov));

es_valido es_valido0(.c_actual(w_c),f_actual(w_f),.pos_movi(w_pos_mov),. ju_valida(w_ju_valida));

reg_jugadas reg_jugadas0(.clk(clk),.rst(w_rst),.anadir_jugada(w_add_jugada),.cas_llenas(w_cas_llenas,.jugadas(w_jugadas));


reg_tablero reg_tablero0(.c_actual(w_c),f_actual(w_f),.jugadas(w_jugadas),.pos_movi(w_pos_mov),. load(w_load_t)));

who_screen who_screen0();


led_mem_arr led_mem_arr0(.clk(clk),.ld(ld),.addr(w_addr),.RGB(),(),());

ws2812_array ws28120_array0(.clk(clk),.INIT_M(),.RSY_CMD(),.DOUT(),.DONE_M());

mc mc0(.clk(clk),.btnup(btn_up),.btndown(btn_down),.btn_left(btn_left),.btn_right(btn_right),.btn_enter(btn_enter),.rst(btn_rst),.m_up(w_up),.m_down(w_down),.m_left(w_left),.m_right(w_right),.ju_valida(w_ju_valida),.q_m(w_qm),.done_q(w_done_q),.cas_llenas(w_cas_llenas) ,.load_fc(w_load_fc),.anadir_jugada(w_add_jugada),.load_t(w_load_t),.cal_mov_val(w_cal_mov_val),.p(w_p));



endmodule


