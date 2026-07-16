module mc (
    input clk,
    input btnup,
    input btndown,
    input btn_left,
    input btn_right,
    input btn_enter,
    input rst,
    output m_up,
    output m_down,
    output m_left,
    output m_right,
    output ju_valida,
    output q_m,
    output done_q,
    output cas_llenas,
    output [1:0]load_fc,
    output anadir_jugada,
    output [1:0]load_t,
    output cal_mov_val,
    output [1:0]p
);




parameter START               = 5'b00000;
parameter CHECK_ENTER         = 5'b00001;
parameter MOVE_C_F            = 5'b00010;
parameter LOAD_M_TABLERO      = 5'b00011;
parameter PEINTF_M_TABLERO    = 5'b00100;
parameter CHECK_JU_VALIDA     = 5'b00101;
parameter ADD_JU_VALIDA       = 5'b00110;
parameter LOAD_TABLERO        = 5'b00111;
parameter PRINT_TABLERO       = 5'b01000;
parameter CALCU_POS_MOV       = 5'b01001;
parameter Q_M                 = 5'b01010;
parameter LOAD_TEMP           = 5'b01011;
parameter PRINTF_TABLERO_TEMP = 5'b01100;
parameter CAS_LLENAS          = 5'b01101;
parameter LOAD_T_WINNER       = 5'b01110;
parameter LOAD_T_LOS          = 5'b01111;
parameter CHECK_RST_W         = 5'b10000;
parameter CHECK_RST_L         = 5'100001;



reg[4:0]state;

initial begin 
    m_up = 0;
    m_down = 0;
    m_left = 0;
    m_right = 0;
    load_fc = 0;
    anadir_jugada = 0;
    load_t = 2'b00;
    p = 2'b00;
end
reg [4:0] counter;

always @(posedge clk)
begin

    if(rst)
        state <= START;
    else
    begin
        case(state)
            START:
            begin
                if(init) begin
                    counter <= 0;
                    state = CHECK0;
                end else
                    state = START;
            end

            CHECK0:
            begin
                if(b0)
                    state = ACUMU;
                else
                    state = SHIFT;
            end

            ACUMU:
                state = SHIFT;

            SHIFT:
                state = CHECK1;
            
            CHECK1:
                if(c)
                    state = END;
                else
                    state = CHECK0;

            END: begin
                counter <= counter + 1;
                if (counter == 28)
                    state = START;
                else
                    state = END;
            end 
            default:
                state = START;

        endcase
    end
end

always @(state) begin
    case(state)
        START:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
        CHECK0:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
        ACUMU:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
        SHIFT:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
        CHECK1:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
        END:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
        default:begin
            m_up = 0;
            m_down = 0;
            m_left = 0;
            m_right = 0;
            load_fc = 0;
            anadir_jugada = 0;
            load_t = 2'b00;
            p = 2'b00;
        end
    endcase
end



`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
    case(state)
        START                :state_name = "START";
        CHECK_ENTER          :state_name = "CHECK_ENTER";
        MOVE_C_F             :state_name = "MOVE_C_F";
        LOAD_M_TABLERO       :state_name = "LOAD_M_TABLERO";
        PEINTF_M_TABLERO     :state_name = "PEINTF_M_TABLERO";
        CHECK_JU_VALIDA      :state_name = "CHECK_JU_VALIDA";
        ADD_JU_VALIDA        :state_name = "ADD_JU_VALIDA";
        LOAD_TABLERO         :state_name = "LOAD_TABLERO";
        PRINT_TABLERO        :state_name = "PRINT_TABLERO";
        CALCU_POS_MOV        :state_name = "CALCU_POS_MOV";
        Q_M                  :state_name = "Q_M";
        LOAD_TEMP            :state_name = "LOAD_TEMP";
        PRINTF_TABLERO_TEMP  :state_name = "PRINTF_TABLERO_TEMP";
        CAS_LLENAS           :state_name = "CAS_LLENAS";
        LOAD_T_WINNER        :state_name = "LOAD_T_WINNER";
        LOAD_T_LOS           :state_name = "LOAD_T_LOS";
        CHECK_RST_W          :state_name = "CHECK_RST_W";
        CHECK_RST_L          :state_name = "CHECK_RST_L";

    endcase
end
`endif







endmodule