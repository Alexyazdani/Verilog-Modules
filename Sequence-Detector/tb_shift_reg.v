/*
Alexander Yazdani
University of Southern California
22 September 2024

8-bit Shift Register, with load, shift, and direction control
*/


`timescale 1ns / 1ps

module tb;
    reg clk;
    reg rst;
    reg shift;
    reg load;
    reg dir;
    reg [7:0] data;
    reg ser_in;
    wire [7:0] q;
    integer outfile;

    // instantiate the shift register
    shift_register shift_reg (
        .clk(clk),
        .rst(rst),
        .shift(shift),
        .load(load),
        .dir(dir),
        .data(data),
        .ser_in(ser_in),
        .q(q)
    );

    initial begin
         // 100 MHz clock (10ns period)
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // resetfor 5 clock cycles, deassert
        rst = 1; load = 0; shift = 0; dir = 0; data = 8'b00000000; ser_in = 0;
        #50 rst = 0;

        // load, 10101010, disable load
        #10 load = 1; data = 8'b10101010; #10 load = 0;

        // shift left, 110
        #10 shift = 1; dir = 0; ser_in = 1;
        #10 shift = 1; dir = 0; ser_in = 1;
        #10 shift = 1; dir = 0; ser_in = 0; 

        // shift right, 110
        #10 shift = 1; dir = 1; ser_in = 0;
        #10 shift = 1; dir = 1; ser_in = 1;
        #10 shift = 1; dir = 1; ser_in = 1;

        // shift disabled
        #10 shift = 0; dir = 1; ser_in = 0;
        #10 shift = 0; dir = 1; ser_in = 1;
        #10 shift = 0; dir = 1; ser_in = 1;

        #10;
        $fclose(outfile);
        $finish;
    end

    initial begin
        outfile = $fopen("shift_reg.out", "w");
        $fmonitor(outfile, "At time %0t ns, rst=%b, load=%b, shift=%b, dir=%b, data=%b, ser_in=%b, q=%b",
                 $time / 1000.0, rst, load, shift, dir, data, ser_in, q);
    end
endmodule
