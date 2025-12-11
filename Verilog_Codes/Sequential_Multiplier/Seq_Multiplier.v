`timescale 1ns / 1ps
module seq_multiplier(
    input clk, 
    input reset, 
    input start,
    input [3:0] multiplicand,
    input [3:0] multiplier,
    output reg [7:0] product,
    output reg done
);

    reg [2:0] count;
    reg state;
    reg [4:0] acc; 
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0; 
            done <= 0; 
            product <= 0; 
            count <= 0;
        end else begin
            case (state)
                0: if (start) begin
                    product <= {4'b0, multiplier}; 
                    state <= 1; 
                    count <= 0; 
                    done <= 0;
                end
                
                1: begin 
                    acc = product[0] ? (product[7:4] + multiplicand) : product[7:4];
                    product <= {acc, product[3:1]}; 
                    count <= count + 1;
                    
                    if (count == 3) begin 
                        done <= 1;
                        state <= 0;
                    end
                end
            endcase
        end
    end

endmodule 
