/*
Alexander Yazdani
University of Southern California

Full Adder
*/

module fa (
    input a, b, ci,
    output sum, carry
);
    // Internal signals
    wire a_xor_b, a_nand_b, xor_nand_ci;

    // Xor gates
    xor (a_xor_b, a, b);   
    xor (sum, a_xor_b, ci); 

    // Nand gates
    nand (a_nand_b, a, b);          
    nand (xor_nand_ci, a_xor_b, ci);
    nand (carry, a_nand_b, xor_nand_ci);

endmodule

