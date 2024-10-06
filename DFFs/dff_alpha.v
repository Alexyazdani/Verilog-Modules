/*
Alexander Yazdani
University of Southern California
22 September 2024

DFF ALPHA - synchronous active-high reset, active-high enable
*/


module dff_alpha (clk, rst, en, d, q);
    input clk, rst, en, d;
    output reg q;

    always @(negedge clk) begin
        // synchronous active-high reset, active-high enable
        if (rst)
            q <= 1'b0;
        else if (en)
            q <= d;
    end
endmodule
