`timescale 1ns / 1ps

module tb_single_cycle_datapath;

    reg clk;
    reg Branch;
    reg MemRead;
    reg MemWrite;
    reg MemtoReg;
    reg [31:0] PC;
    reg [31:0] reg1;
    reg [31:0] reg2;
    reg [15:0] imm;
    reg [31:0] alu_result;
    reg [31:0] write_data;

    wire [31:0] nextPC;
    wire [31:0] memtoreg_out;

    single_cycle_datapath DUT (
        .clk(clk),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .PC(PC),
        .reg1(reg1),
        .reg2(reg2),
        .imm(imm),
        .alu_result(alu_result),
        .write_data(write_data),
        .nextPC(nextPC),
        .memtoreg_out(memtoreg_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        PC = 32'd100;
        reg1 = 32'd10;
        reg2 = 32'd10;
        imm = 16'd4;
        Branch = 1;

        MemRead = 1;
        MemWrite = 0;
        MemtoReg = 1;
        alu_result = 32'd5;
        write_data = 32'd0;
        #10;

        MemRead = 0;
        MemtoReg = 0;
        alu_result = 32'd99;
        #10;

        reg2 = 32'd20;
        Branch = 1;
        #10;

        Branch = 0;
        #10;

        $finish;
    end

endmodule
