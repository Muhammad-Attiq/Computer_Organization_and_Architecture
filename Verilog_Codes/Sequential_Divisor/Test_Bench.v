`timescale 1ns / 1ps
module tb_divider4bit;

    reg clk;
    reg rst;
    reg start;
    reg [3:0] dividend;
    reg [3:0] divisor;
    wire [3:0] quotient;
    wire [3:0] remainder;
    wire done;

    divider4bit_simple uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1; start = 0; dividend = 0; divisor = 0;
        #12;
        rst = 0;

        dividend = 4'd13;
        divisor  = 4'd3;
        start = 1;
        #10;
        start = 0;

        wait(done == 1);
        #10;

        $display("Dividend = %d, Divisor = %d", dividend, divisor);
        $display("Quotient = %d, Remainder = %d", quotient, remainder);

        $stop;
    end

endmodule
