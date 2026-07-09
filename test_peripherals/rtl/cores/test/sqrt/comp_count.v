module comp_count(
input [3:0]count, //16 A entonces count es 8 
output reg c);

always @(*)
    if (count == 0)
        c = 1;
    else 
        c = 0;    

endmodule