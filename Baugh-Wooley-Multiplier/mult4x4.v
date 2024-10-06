/*
Alexander Yazdani
University of Southern California

Structural Multiplier Design

Design Reference: https://www.ece.uvic.ca/~fayez/courses/ceng465/lab_465/project2/multiplier.pdf
Baugh-Wooley Multiplier
University of Victoria, Electrical and Computer Engineering Department
*/

module mult4x4 (InA, InB, Product);
    // Inputs and outputs
    input [3:0] InA;
    input [3:0] InB;
    output [7:0] Product;

    // Partial products
    wire pp30, pp20, pp10, pp00;
    wire pp31, pp21, pp11, pp01;
    wire pp32, pp22, pp12, pp02;
    wire pp33, pp23, pp13, pp03;

    // Intermediate carry & sum signals
    wire [4:0] carry0, carry1, carry2, carry3; 
    wire [3:0] sum1, sum2, sum3;

    // Row 1 Partial Products
    and (pp00, InA[0], InB[0]);
    and (pp10, InA[1], InB[0]);
    and (pp20, InA[2], InB[0]);
    nand (pp30, InA[3], InB[0]);

    // Row 2 Partial Products
    and (pp01, InA[0], InB[1]);
    and (pp11, InA[1], InB[1]);
    and (pp21, InA[2], InB[1]);
    nand (pp31, InA[3], InB[1]);
    
    // Row 3 Partial Products
    and (pp02, InA[0], InB[2]);
    and (pp12, InA[1], InB[2]);
    and (pp22, InA[2], InB[2]);
    nand (pp32, InA[3], InB[2]);

    // Row 4 Partial Products
    nand (pp03, InA[0], InB[3]);
    nand (pp13, InA[1], InB[3]);
    nand (pp23, InA[2], InB[3]);
    and (pp33, InA[3], InB[3]);

    // Row 1 Full Adders
    fa fa00 (.a(pp00), .b(1'b0), .ci(1'b0), .sum(Product[0]), .carry(carry0[0]));
    fa fa10 (.a(pp10), .b(1'b0), .ci(1'b0), .sum(sum1[0]), .carry(carry1[0]));
    fa fa20 (.a(pp20), .b(1'b0), .ci(1'b0), .sum(sum2[0]), .carry(carry2[0]));
    fa fa30 (.a(pp30), .b(1'b0), .ci(1'b0), .sum(sum3[0]), .carry(carry3[0]));

    // Row 2 Full Adders
    fa fa01 (.a(pp01), .b(carry0[0]), .ci(sum1[0]), .sum(Product[1]), .carry(carry0[1]));
    fa fa11 (.a(pp11), .b(carry1[0]), .ci(sum2[0]), .sum(sum1[1]), .carry(carry1[1]));
    fa fa21 (.a(pp21), .b(carry2[0]), .ci(sum3[0]), .sum(sum2[1]), .carry(carry2[1]));
    fa fa31 (.a(pp31), .b(carry3[0]), .ci(1'b0), .sum(sum3[1]), .carry(carry3[1]));

    // Row 3 Full Adders
    fa fa02 (.a(pp02), .b(carry0[1]), .ci(sum1[1]), .sum(Product[2]), .carry(carry0[2]));
    fa fa12 (.a(pp12), .b(carry1[1]), .ci(sum2[1]), .sum(sum1[2]), .carry(carry1[2]));
    fa fa22 (.a(pp22), .b(carry2[1]), .ci(sum3[1]), .sum(sum2[2]), .carry(carry2[2]));
    fa fa32 (.a(pp32), .b(carry3[1]), .ci(1'b0), .sum(sum3[2]), .carry(carry3[2]));

    // Row 4 Full Adders
    fa fa03 (.a(pp03), .b(carry0[2]), .ci(sum1[2]), .sum(Product[3]), .carry(carry0[3]));
    fa fa13 (.a(pp13), .b(carry1[2]), .ci(sum2[2]), .sum(sum1[3]), .carry(carry1[3]));
    fa fa23 (.a(pp23), .b(carry2[2]), .ci(sum3[2]), .sum(sum2[3]), .carry(carry2[3]));
    fa fa33 (.a(pp33), .b(carry3[2]), .ci(1'b0), .sum(sum3[3]), .carry(carry3[3]));

    // Final Full Adders
    fa fa04 (.a(carry0[3]), .b(sum1[3]), .ci(1'b1), .sum(Product[4]), .carry(carry0[4]));
    fa fa14 (.a(carry1[3]), .b(sum2[3]), .ci(carry0[4]), .sum(Product[5]), .carry(carry1[4]));
    fa fa24 (.a(carry2[3]), .b(sum3[3]), .ci(carry1[4]), .sum(Product[6]), .carry(carry2[4]));
    fa fa34 (.a(carry3[3]), .b(1'b1), .ci(carry2[4]), .sum(Product[7]), .carry(carry3[4]));

endmodule
