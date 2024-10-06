/*
Alexander Yazdani
University of Southern California

Floating-Point Multiplier

754-2019 - IEEE Standard for Floating-Point Arithmetic
https://ieeexplore.ieee.org/document/8766229
*/

module fpmul (InA, InB, Result);

    input [31:0] InA, InB;
    output reg [31:0] Result;

    reg SA, SB, SR;                     // Sign bits
    reg [7:0] ExpA, ExpB, ExpR;         // Exponents
    reg [22:0] FracA, FracB, FracR;     // Input / Output Fractions
    reg [47:0] FracZ;                   // Intermediate Fraction

    always @(*) begin

        // Parse the inputs for sign, exponent, and fraction
        SA = InA[31];
        SB = InB[31];
        ExpA = InA[30:23];
        ExpB = InB[30:23];
        FracA = InA[22:0];
        FracB = InB[22:0]; 

        // XOR the sign bits to find the final sign bit
        SR = SA ^ SB;

        // Multiply the fractions
        FracZ = {1'b1, FracA} * {1'b1, FracB};

        // Add the exponents and subtract 127
        ExpR = ExpA + ExpB;
        ExpR = ExpR - 127;

        // Normalize
        ExpR = FracZ[47] ? ExpR + 1 : ExpR;
        FracR = FracZ[47] ? FracZ[46:24] : FracZ[45:23];

        // Format and assign the result
        Result = {SR, ExpR[7:0], FracR};

    end
endmodule
