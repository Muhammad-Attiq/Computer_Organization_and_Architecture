module Data_Memory(
input wire clk, MemRead, MemWrite,
input wire [31:0] address, write_data,
output reg [31:0] read_data
    );
reg [31:0] mem [0:19]; 
integer i;

initial begin
for(i=0;i<20;i=i+1)
	mem[i] = i+456; 
end

always @(*) begin 
if(MemRead)
	read_data = mem[address];
else
	read_data = 32'b0;
end

always @(posedge clk) begin 
if (MemWrite)
	mem[address]<=write_data;
end

endmodule 
