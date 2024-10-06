/*
Alexander Yazdani
University of Southern California
22 September 2024

8-bit Shift Register, with load, shift, and direction control
*/


module shift_register (
    input clk,
    input rst,
    input shift,
    input load,
    input dir,
    input [7:0] data,
    input ser_in,
    output reg [7:0] q
);
    always @(posedge clk) begin
        // synchronous reset
        if (rst) begin
            q <= 8'b00000000;
        // synchronous load
        end else if (load) begin
            q <= data;  
        end else if (shift) begin
        // shift bidirectionally
            if (dir) begin
                q <= {ser_in, q[7:1]};
            end else begin
                q <= {q[6:0], ser_in};
            end
        end
    end
endmodule
