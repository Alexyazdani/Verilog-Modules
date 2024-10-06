/*
Alexander Yazdani
University of Southern California
22 September 2024

DFF TESTBED
*/


`timescale 1ns / 1ps

module tb;
    reg clk;
    reg rst;
    reg en;
    reg d;
    wire q_alpha, q_beta, q_gamma, q_delta;

    integer file_alpha, file_beta, file_gamma, file_delta;

    // Instantiate the DFFs
    // Active-low signals are fed inverses of the active-high inputs
    dff_alpha alpha (.clk(clk), .rst(rst), .en(en), .d(d), .q(q_alpha));
    dff_beta  beta  (.clk(clk), .rst(rst), .en(~en), .d(d), .q(q_beta));
    dff_gamma gamma (.clk(clk), .rst(~rst), .en(en), .d(d), .q(q_gamma));
    dff_delta delta (.clk(clk), .rst(~rst), .en(~en), .d(d), .q(q_delta));

    initial begin
        // 100 MHz, (10ns Period)
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        // Open output files
        file_alpha = $fopen("dff_alpha.out", "w");
        file_beta  = $fopen("dff_beta.out", "w");
        file_gamma = $fopen("dff_gamma.out", "w");
        file_delta = $fopen("dff_delta.out", "w");
    end

    initial begin
        // Write to output files
        $fmonitor(file_alpha, "At time %0t ns, clk=%b, rst=%b, en=%b, d=%b, q=%b", $time / 1000.0, clk, rst, en, d, q_alpha);
        $fmonitor(file_beta,  "At time %0t ns, clk=%b, rst=%b, en=%b, d=%b, q=%b", $time / 1000.0, clk, rst, ~en, d, q_beta);
        $fmonitor(file_gamma, "At time %0t ns, clk=%b, rst=%b, en=%b, d=%b, q=%b", $time / 1000.0, clk, ~rst, en, d, q_gamma);
        $fmonitor(file_delta, "At time %0t ns, clk=%b, rst=%b, en=%b, d=%b, q=%b", $time / 1000.0, clk, ~rst, ~en, d, q_delta);
    end

    initial begin
        // Reset for 5 clocks then deassert
        rst = 1; en = 0; d = 0;
        #50 rst = 0; 

        #5;
        // Test en = 0
        en = 0; d = 0; #10;
        en = 0; d = 1; #10;
        en = 0; d = 0; #10;

        // Test en = 1
        en = 1; d = 0; #10;
        en = 1; d = 1; #10;
        en = 1; d = 0; #15;

        //close the files and end simulation
        $fclose(file_alpha);
        $fclose(file_beta);
        $fclose(file_gamma);
        $fclose(file_delta);
        $finish;
    end

endmodule
