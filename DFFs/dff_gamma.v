/*
Alexander Yazdani
University of Southern California
22 September 2024

DFF GAMMA - synchronous active-low reset, active-high enable
*/


module dff_gamma (clk, rst, en, d, q);
    input clk, rst, en, d;
    output reg q;

    always @(negedge clk) begin
        // synchronous active-low reset, active-high enable
        if (~rst)
            q <= 1'b0;
        else if (en)
            q <= d;
    end
endmodule
