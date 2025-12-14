module single_cycle_datapath (
    input  wire        clk,
    input  wire        Branch,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire        MemtoReg,
    input  wire [31:0] PC,
    input  wire [31:0] reg1,
    input  wire [31:0] reg2,
    input  wire [15:0] imm,
    input  wire [31:0] alu_result,
    input  wire [31:0] write_data,

    output wire [31:0] nextPC,
    output wire [31:0] memtoreg_out
);

    wire Zero;
    wire BranchTaken;
    wire [31:0] mem_read_data;

    branch_datapath BD (
        .PC(PC),
        .reg1(reg1),
        .reg2(reg2),
        .imm(imm),
        .Branch(Branch),
        .nextPC(nextPC),
        .Zero(Zero),
        .BranchTaken(BranchTaken)
    );

    Data_Memory DM (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(alu_result),
        .write_data(write_data),
        .read_data(mem_read_data)
    );

    assign memtoreg_out = MemtoReg ? mem_read_data : alu_result;

endmodule
