module state_machinediv (
input clk,
input rst,
input init,
input ok,
input f,

output reg start,
output reg shiftA,
output reg shiftR,
output reg load,
output reg inc,
output reg done);//done

parameter START       = 3'b111;
parameter SHIFT       = 3'b100;
parameter R_AGG0      = 3'b011;
parameter R_AGG1      = 3'b010;
parameter DECREMENTAR = 3'b001;
parameter END         = 3'b000;


reg [2:0] state;

initial begin 
    start = 0;
    shiftA = 0;
    shiftR = 0;
    load = 0;
    inc = 0;
    done = 0; 
end
reg [4:0] counter;
reg [3:0] counterok;
always @(posedge clk)
begin

    if(rst)
        state <= START;
    else
    begin
        case(state)
            START:
            begin
                if(init)begin
                    counter <= 0;
                    //counterok <= 0;
                    state = SHIFT;
                    end
                else
                    state = START;
            end

            SHIFT:
            begin
                if(ok)
                    state = R_AGG1;
                else
                    state = R_AGG0;
            end

            R_AGG1: begin
                state = DECREMENTAR;
            end
            R_AGG0: begin
                state = DECREMENTAR;
            end
            DECREMENTAR:
            begin
                if(f)
                    state = END;
                else
                    state = SHIFT;
            end

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
            start = 1;
            shiftA = 0;
            shiftR = 0;
            load = 0;
            inc = 0;
            done = 0;
        end
        SHIFT:begin
            start = 0;
            shiftA = 1;
            shiftR = 0;
            load = 0;
            inc = 0;
            done = 0;
        end
            R_AGG0:begin
            start = 0;
            shiftA = 0;
            shiftR = 1;
            load = 0;
            inc = 0;
            done = 0;
        end
            R_AGG1:begin
            start = 0;
            shiftA = 0;
            shiftR = 0;
            load = 1;
            inc = 0;
            done = 0;
        end
            DECREMENTAR:begin
            start = 0;
            shiftA = 0;
            shiftR = 0;
            load = 0;
            inc = 1;
            done = 0;
        end
            END:begin
            start = 0;
            shiftA = 0;
            shiftR = 0;
            load = 0;
            inc = 0;
            done = 1;
        end
        default:begin
            start = 1;
            shiftA = 0;
            shiftR = 0;
            load = 0;
            inc = 0;
            done = 0;
        end
    endcase
end

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
    case(state)
        START       : state_name = "START";
        R_AGG0      : state_name = "R_AGG0";
        R_AGG1      : state_name = "R_AGG1";
        SHIFT       : state_name = "SHIFT";
        DECREMENTAR : state_name = "DECREMENTAR";
        END         : state_name = "END";
    endcase
end
`endif

endmodule