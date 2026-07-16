module regf (
    input  clk,
    input  rst,
    input  shift_u,
    input  shift_d,
    output reg [2:0]f_out//para contar de 0 a 7
); 

initial f_out = 3'b0;

always @(negedge clk)
    begin
        if (rst)
            f_out = 3'b000;
        else if (shift_u)
            f_out = f_out + 1;
        else if (shift_d)
            f_out = f_out - 1;
    end

endmodule