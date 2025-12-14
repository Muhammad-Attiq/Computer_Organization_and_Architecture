module branch_datapath (
    input  wire [31:0] PC,
    input  wire [31:0] reg1,
    input  wire [31:0] reg2,
    input  wire [15:0] imm,
    input  wire        Branch,
    output wire [31:0] nextPC,
    output wire        Zero,
    output wire        BranchTaken
);

    wire [31:0] PC_plus4;
    wire [31:0] imm_ext;
    wire [31:0] imm_shift;
    wire [31:0] branch_addr;
    wire [31:0] alu_result;

    assign PC_plus4   = PC + 32'd4;
    assign imm_ext    = {{16{imm[15]}}, imm};
    assign imm_shift  = imm_ext << 2;
    assign branch_addr = PC_plus4 + imm_shift;
    assign alu_result = reg1 - reg2;
    assign Zero       = (alu_result == 32'd0);
    assign BranchTaken = Branch & Zero;
    assign nextPC     = BranchTaken ? branch_addr : PC_plus4;

endmodule
