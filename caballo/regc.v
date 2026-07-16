module regc (
    input  clk,
    input  rst,
    input  shift_r,
    input  shift_l,
    output reg [2:0]c_out//para contar de 0 a 7
); 

initial c_out = 3'b0;

always @(negedge clk)
    begin
        if (rst)
            c_out = 3'b000;
        else if (shift_r)
            c_out = c_out + 1;
        else if (shift_l)
            c_out = c_out - 1;
    end

endmodule