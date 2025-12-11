`timescale 1ns / 1ps
module seq_multiplier_tb;
    reg clk = 0;
    reg reset = 1;
    reg start = 0;
    reg [3:0] A, B;
    wire [7:0] P;
    wire done;
    seq_multiplier uut (.clk(clk), .reset(reset), .start(start),
    .multiplicand(A), .multiplier(B),
    .product(P), .done(done));

    always #5 clk = ~clk;
	 
    initial begin
        #15 reset = 0; 
        A = 4'd3;
        B = 4'd5;
        start = 1;
        #10 start = 0;
        wait(done);
        $display("Test 1: 3 * 5 = %d (Expected: 15)", P);#10;
        A = 4'd15;
        B = 4'd15;
        start = 1;
        #10 start = 0;
        wait(done);
        $display("Test 2: 15 * 15 = %d (Expected: 225)", P);#10;
        A = 4'd10;
        B = 4'd0;
        start = 1;
        #10 start = 0;
        wait(done);
        $display("Test 3: 10 * 0 = %d (Expected: 0)", P);
        #10;
        $finish;
    end
endmodule 
