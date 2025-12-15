`timescale 1ns / 1ps
module divider4bit_simple(
    input clk,
    input rst,
    input start,
    input [3:0] dividend,
    input [3:0] divisor,
    output reg [3:0] quotient,
    output reg [3:0] remainder,
    output reg done
);

    reg [2:0] count;
    reg [4:0] temp_rem;
    reg state; // 0 = IDLE, 1 = RUN

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            quotient <= 0;
            remainder <= 0;
            temp_rem <= 0;
            count <= 0;
            state <= 0; // IDLE
            done <= 0;
        end else begin
            case(state)
                0: begin // IDLE
                    done <= 0;
                    if (start) begin
                        quotient <= 0;
                        remainder <= 0;
                        temp_rem <= 0;
                        count <= 4; // 4-bit division
                        state <= 1; // switch to RUN
                    end
                end

                1: begin // RUN
                    temp_rem = {remainder[3:0], dividend[count-1]}; // shift left

                    if (temp_rem >= divisor) begin
                        temp_rem = temp_rem - divisor;
                        quotient[count-1] <= 1;
                    end else begin
                        quotient[count-1] <= 0;
                    end

                    remainder <= temp_rem;
                    count <= count - 1;

                    if (count == 1) begin
                        done <= 1;
                        state <= 0; // back to IDLE
                    end
                end
            endcase
        end
    end
endmodule
