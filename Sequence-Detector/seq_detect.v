/*
Alexander Yazdani
University of Southern California
22 September 2024

8-bit Sequence Detector, with load, shift, and direction control
*/


module seq_detect (D_IN, CLK, RST, MATCH);
    input CLK, RST, D_IN;
    output MATCH;

    reg match_enable_internal;
    wire [7:0] shift_reg_out;
    parameter PATTERN = 8'b11010101;

    // Instantiate the shift register
    shift_register shift_reg (
        .clk(CLK),
        .rst(RST),
        .shift(1'b1),
        .load(1'b0),
        .dir(1'b0),
        .data(8'b00000000), 
        .ser_in(D_IN),
        .q(shift_reg_out)
    );

    always @(posedge CLK) begin
        // Synchronous reset
        if (RST) begin
            match_enable_internal <= 1'b0;
        end else begin
            match_enable_internal <= 1'b1;        
        end
    end

    // check for match and verify no reset, assign to output
    assign MATCH = match_enable_internal && (shift_reg_out == PATTERN);

endmodule


