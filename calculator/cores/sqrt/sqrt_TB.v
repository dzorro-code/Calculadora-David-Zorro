`timescale 1ns / 1ns
`define SIMULATION

module sqrt_TB;

    reg clk;
    reg rst;
    reg start;

    reg [15:0] in_A;

    wire [15:0]w_A2;
    wire [7:0] w_R;
    wire done;

    sqrt uut (
        .clk(clk),
        .rst(rst),
        .init(start),
        .A(in_A),
        .A2(w_A2),
        .R(w_R),
        .done(done)
    );
//module sqrt(clk, rst, init, A, A2, R, done);
    parameter PERIOD = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 0;

    reg [20:0] i;

    event reset_trigger;
    event reset_done_trigger;

    // Reset logic
    initial begin
        forever begin

            @(reset_trigger);
            @(negedge clk);

            rst = 1;

            @(negedge clk);

            rst = 0;

            -> reset_done_trigger;

        end
    end

    // Initialize inputs
    initial begin

        clk   = 0;
        rst   = 1;
        start = 0;

        in_A  = 16'd97;

    end

    // Clock generation
    initial begin

        #OFFSET;

        forever begin

            clk = 1'b0;
            #(PERIOD - (PERIOD * DUTY_CYCLE));

            clk = 1'b1;
            #(PERIOD * DUTY_CYCLE);

        end
    end

    // Stimulos
    initial begin

        // Trigger reset
        #10 -> reset_trigger;

        @(reset_done_trigger);
        @(posedge clk);

        start = 0;

        @(posedge clk);

        start = 1;

        for(i = 0; i < 2; i = i + 1) begin
            @(posedge clk);
        end

        start = 0;

        for(i = 0; i < 17; i = i + 1) begin
            @(posedge clk);
        end

    end

    // Dump waves
    initial begin : TEST_CASE

        $dumpfile("sqrt_TB.vcd");
        $dumpvars(-1, uut);

        #((PERIOD * DUTY_CYCLE) * 120) $finish;

    end

endmodule