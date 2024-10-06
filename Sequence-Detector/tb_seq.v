/*
Alexander Yazdani
University of Southern California
22 September 2024

8-bit Sequence Detector Testbed
*/

`timescale 1ns / 1ps

module tb;
    reg CLK;
    reg RST;
    reg D_IN;
    wire MATCH;

    integer input_file, output_file, c;
    
    // Instantiate the sequence detector
    seq_detect seq_det (
        .CLK(CLK),
        .RST(RST),
        .D_IN(D_IN),
        .MATCH(MATCH)
    );

    initial begin
        // 500 MHz clock (2ns period)
        CLK = 0;
        forever #1 CLK = ~CLK; 
    end

    initial begin
        // Open the input and output files
        input_file = $fopen("pattern.in", "r");
        output_file = $fopen("seq.out", "w");

        // Reset for 4 clock cycles, then deassert
        RST = 1;
        #8 RST = 0; 

        // Read input file and apply to D_IN
        while (!$feof(input_file)) begin
            //While the file is not empty, read the next character
            c = $fgetc(input_file);
            // Check if character is 0 or 1
            if (c == "0" || c == "1") begin
                // Convert to integer and assign to D_IN
                D_IN = c - "0";
                // Wait for 2 clock cycles
                #2; 
                // Send data to output file
                $fmonitor(output_file, "At time %0t ns, CLK=%b, RST=%b, D_IN=%b, MATCH=%b", $time / 1000.0, CLK, RST, D_IN, MATCH);
            end
        end
        #4;
        $fclose(input_file);
        $fclose(output_file);
        $finish;
    end
endmodule
