module ShiftLeftOne (
    input signed [31:0] i,
    output signed [31:0] o
);

   assign o = i << 1; // Shift left by 1 bit (equivalent to multiplying by 2)

endmodule

