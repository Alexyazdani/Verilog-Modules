/*
Alexander Yazdani
University of Southern California

Half Adder Testbed
*/

`timescale 1ns / 1ps

module tb;
    reg a, b;
    wire sum, carry;
    integer ha_out;

    // Instantiate half adder
    ha halfadder (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Open file
        ha_out = $fopen("ha.out", "w");

        // Apply stimuli to exhaustively test
        a = 0; b = 0; #10; $fdisplay(ha_out, "a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
        a = 0; b = 1; #10; $fdisplay(ha_out, "a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
        a = 1; b = 0; #10; $fdisplay(ha_out, "a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
        a = 1; b = 1; #10; $fdisplay(ha_out, "a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);

        // Close file and end simulation
        $fclose(ha_out);
        $finish;
    end

endmodule
