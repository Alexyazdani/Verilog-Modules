/*
Alexander Yazdani
University of Southern California

Structural Multiplier Testbed
*/

`timescale 1ns / 1ps

module tb;
    reg signed [3:0] InA, InB;         
    wire signed [7:0] Product;         

    integer i, j;
    integer file_out;
    reg signed [7:0] Expected;
    reg failure;

    // Instantiate multiplier
    mult4x4 multiplier (
        .InA(InA),
        .InB(InB),
        .Product(Product)
    );

    initial begin
        // Open file
        file_out = $fopen("mult4x4.out", "w");

        // Initialize failure flag to 0
        failure = 0;
        // Nested for loop to exhaustuvely test
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                InA = i;
                InB = j;
                // Calculate the expected value
                Expected = $signed(InA) * $signed(InB);
                // Wait for the output to be ready
                #10;

                // Determine if the test passed or failed
                if (Product !== Expected) begin
                    $fdisplay(file_out, "Test Failed: InA=%b, InB=%b, Product=%b, Expected=%b", InA, InB, Product, Expected);
                    // Set the Failure flag
                    failure = 1;  
                end else begin
                    $fdisplay(file_out, "InA=%b, InB=%b, Product=%b, Expected=%b", InA, InB, Product, Expected);
                end
            end
        end

        // Add a blank line and determine failure or success
        $fdisplay(file_out);
        if (!failure) begin
            $fdisplay(file_out, "All tests passed successfully.");
        end else begin
            $fdisplay(file_out, "At least one test failed.  Check above for results.");
        end

        // Close the file and finish simulation
        $fclose(file_out);
        $finish;

    end
endmodule
