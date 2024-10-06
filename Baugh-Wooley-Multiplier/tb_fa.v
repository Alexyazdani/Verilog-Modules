/*
Alexander Yazdani
University of Southern California

Full Adder Testbed
*/

`timescale 1ns / 1ps

module tb;
    reg a, b, ci;
    wire sum, carry;
    integer fa_out;

    // Instantiate full adder
    fa fulladder (
        .a(a),
        .b(b),
        .ci(ci),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Open file
        fa_out = $fopen("fa.out", "w");

        // Apply stimuli to exhaustively test
        a = 0; b = 0; ci = 0; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 0; b = 0; ci = 1; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 0; b = 1; ci = 0; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 0; b = 1; ci = 1; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 1; b = 0; ci = 0; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 1; b = 0; ci = 1; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 1; b = 1; ci = 0; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);
        a = 1; b = 1; ci = 1; #10; $fdisplay(fa_out, "a = %b, b = %b, ci = %b, sum = %b, carry = %b", a, b, ci, sum, carry);

        // Close file and end simulation
        $fclose(fa_out);
        $finish;
    end

endmodule
