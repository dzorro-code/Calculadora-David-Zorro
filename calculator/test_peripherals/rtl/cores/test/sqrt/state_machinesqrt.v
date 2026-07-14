module state_machinesqrt (
input clk,
input rst,
input init,
input c,
input z,
input m,

output reg ld_A1,
output reg ld_A2,
output reg add_0,
output reg add_1,
output reg ld_R1,
output reg sh,
output reg done);//done




parameter INIT         = 4'b0000;
parameter SHIFT_COUNT  = 4'b0001;
parameter CHECK0       = 4'b0010;
parameter R_1          = 4'b0011;
parameter UPDATE_A     = 4'b0100;
parameter R_SHIFT      = 4'b0101;
parameter CHECK1       = 4'b0110;
parameter R_1_UPDATE_A = 4'b0111;
parameter R_0          = 4'b1000;
parameter CHECK2       = 4'b1001;
parameter END          = 4'b1010;


reg[3:0]state;

initial begin 
    ld_A1 = 0;
    ld_A2 = 0;
    add_0 = 0;
    add_1 = 0;
    ld_R1 = 0;
    sh = 0;
    done = 0;
end
reg [4:0] counter;

always @(posedge clk)
begin

    if(rst)
        state = INIT;
    else
    begin
        case(state)
            INIT:
            begin
                if(init) 
                    begin
                        counter <= 0;
                        state = SHIFT_COUNT;
                    end
                else
                    state = INIT;
            end

            SHIFT_COUNT:
                state = CHECK0;

            CHECK0:
            begin
                if (z) 
                    state = UPDATE_A;
                else
                    state = R_1;
            end
            R_1:
                state = UPDATE_A;
            
            UPDATE_A:
                state = R_SHIFT;
            
            R_SHIFT:
                state = CHECK1;

            CHECK1:
            begin
                if (m) 
                state = R_0;
                else 
                    state = R_1_UPDATE_A;
            end
            R_0:
                state = CHECK2;    
            
            R_1_UPDATE_A:
                state = CHECK2;         
            
            CHECK2:
            begin
                if (c) 
                state = END;
                else 
                    state = R_SHIFT;
            end


            END: begin
                counter <= counter + 1;
                if (counter == 28)
                    state = INIT;
                else
                    state = END;
            end 
            default:
                state = INIT;

        endcase
    end
end

always @(state) begin
    case(state)
        INIT:begin
            ld_A1 = 1;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        SHIFT_COUNT:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 1;
            done = 0;
        end
        CHECK0:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        R_1:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 1;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        UPDATE_A:begin
            ld_A1 = 0;
            ld_A2 = 1;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        R_SHIFT:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 1;
            sh = 1;
            done = 0;
        end
        CHECK1:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        R_0:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 1;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        R_1_UPDATE_A:begin
            ld_A1 = 0;
            ld_A2 = 1;
            add_0 = 0;
            add_1 = 1;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end                
        CHECK2:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
        END:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 1;
        end
        default:begin
            ld_A1 = 0;
            ld_A2 = 0;
            add_0 = 0;
            add_1 = 0;
            ld_R1 = 0;
            sh = 0;
            done = 0;
        end
    endcase
end



`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
    case(state)
        INIT        : state_name = "INIT";
        SHIFT_COUNT : state_name = "SHIFT_COUNT";
        CHECK0      : state_name = "CHECK0";
        R_1         : state_name = "R_1";
        UPDATE_A    : state_name = "UPDATE_A";
        R_SHIFT     : state_name = "R_SHIFT";
        CHECK1      : state_name = "CHECK1";
        R_1_UPDATE_A: state_name = "R_1_UPDATE_A";
        R_0         : state_name = "R_0";
        CHECK2      : state_name = "CHECK2";
        END         : state_name = "END";
    endcase
end
`endif


endmodule