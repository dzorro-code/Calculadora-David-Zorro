module state_machinemult(
input clk,
input rst,
input init,
input c,
input b0,

output reg acc,
output reg ld,
output reg sh,
output reg done);//done


parameter START= 3'b000;
parameter CHECK0= 3'b001;
parameter ACUMU= 3'b010;
parameter SHIFT = 3'b011;
parameter CHECK1= 3'b100;
parameter END= 3'b101;


reg[2:0]state;

initial begin 
    ld = 0;
    sh = 0;
    acc = 0;
    done = 0; 
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
            ld = 1;
            sh = 0;
            acc = 0;
            done = 0; 
        end
        CHECK0:begin
            ld = 0;
            sh = 0;
            acc = 0;
            done = 0;
        end
        ACUMU:begin
            ld = 0;
            sh = 0;
            acc = 1;
            done = 0;
        end
        SHIFT:begin
            ld = 0;
            sh = 1;
            acc = 0;
            done = 0;
        end
        CHECK1:begin
            ld = 0;
            sh = 0;
            acc = 0;
            done = 0;
        end
        END:begin
            ld = 0;
            sh = 0;
            acc = 0;
            done = 1;
        end
        default:begin
            ld = 1;
            sh = 0;
            acc = 0;
            done = 0; 
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

