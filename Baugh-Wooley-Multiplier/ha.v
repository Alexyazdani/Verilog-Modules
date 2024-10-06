/*
Alexander Yazdani
University of Southern California

Half Adder
*/

module ha (
    input a, b,
    output sum, carry
);
    // HA logic
    xor (sum, a, b);
    and (carry, a, b);

endmodule

