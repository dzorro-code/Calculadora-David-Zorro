module ctrl (.
input init_t,
input [1:0]sel,
input z,
input rst_in,

output reg dout,
output reg done_t,
output reg rst,
output reg inc,
output reg [1:0] sel_tim
);



parameter START     = 4'b0000;
parameter CHK_SEL   = 4'b0001;
parameter SEND_RES  = 4'b0010;
parameter SEND_0    = 4'b0011;
parameter SEND_1    = 4'b0100;
parameter WAIT_TRST = 4'b0101;
parameter WAIT_TH   = 4'b0110;
parameter SEND_PER  = 4'b0111;
parameter WAIT_T    = 4'b1000;
parameter END_SEND  = 4'b0001;


reg[3:0]state;

initial begin 
    dout    = 0;
    done    = 0;
    rst     = 0;
    inc     = 0;
    sel_tim = 0;
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
                if(init_t) begin
                    counter <= 0;
                    state = CHK_SEL;
                end else
                    state = START;
            end

            CHK_SEL:
            begin
                if(sel == 2'b00)
                    state = SEND_0;
                else if (sel == 2'b01)
                    state = SEND_1;
                else if (sel == 2'b10)
                    state = SEND_RES;
            end


            SEND_RES:
                state = WAIT_TRST;

            SEND_0:
                state = WAIT_TH;
            
            SEND_1:
                state = WAIT_TH;

            
            WAIT_TH:
                begin
                    if(z)
                        state = SEND_PER;
                    else 
                        state = 
                        WAIT_TH;
                end 


            WAIT_TRST:
                begin
                    if(z)
                        state = END_SEND;
                    else 
                        state = WAIT_TRST;
                end 


            SEND_PER:
                state = WAIT_T;

            

            WAIT_T:
                begin
                    if(z)
                        state = END_SEND;
                    else 
                        state = WAIT_T;
                end 


            END_SEND: begin
                counter <= counter + 1;
                if (counter == 28)
                    state = START;
                else
                    state = END_SEND;
            end 
            default:
                state = START;

        endcase
    end
end

always @(state) begin
    case(state)
        START:begin
            dout    = 0;
            done    = 0;
            rst     = 1;
            inc     = 0;
            sel_tim = 0;
        end
        CHK_SEL:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
        SEND_0:begin
            dout    = 1;
            done    = 0;
            rst     = 0;
            inc     = 1;
            sel_tim = 2'b00;
        end
        SEND_1:begin
            dout    = 1;
            done    = 0;
            rst     = 0;
            inc     = 1;
            sel_tim = 2'b01;
        end
        SEND_RES:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 1;
            sel_tim = 2'b10;
        end
        WAIT_TH:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
        WAIT_TRST:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
        WAIT_T:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
        SEND_PER:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
        END_SEND:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
        default:begin
            dout    = 0;
            done    = 0;
            rst     = 0;
            inc     = 0;
            sel_tim = 0;
        end
    endcase
end



`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
    case(state)
        START    : state_name = "START";
        CHECK0    : state_name = "CHECK0";
        CHECK1    : state_name = "CHECK1";
        SHIFT    : state_name = "SHIFT";
        ACUMU     : state_name = "ACUMU";
        END      : state_name = "END";
    endcase
end
`endif


endmodule

