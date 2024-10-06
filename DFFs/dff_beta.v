/*
Alexander Yazdani
University of Southern California
22 September 2024

DFF BETA - asynchronous active-high reset, active-low enable
*/


module dff_beta (clk, rst, en, d, q);
    input clk, rst, en, d;
    output reg q;

    always @(negedge clk or posedge rst) begin
        // asynchronous active-high reset, active-low enable
        if (rst)
            q <= 1'b0;
        else if (~en)
            q <= d;
    end
endmodule
