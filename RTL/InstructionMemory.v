module InstructionMemory(
    input  [31:0] readAddr,
    output reg [31:0] inst
);

reg [31:0] insts [0:31];

initial begin
    $readmemh("TEST_INSTRUCTIONS.mem", insts); // Load instructions from TEST_INSTRUCTIONS.mem
end

always @(*) begin
    if (readAddr[31:2] < 32)
        inst = insts[readAddr[31:2]]; // Each instruction is 4 bytes, so we use readAddr[31:2] to index the instruction memory
    else
        inst = 32'h00000013;  // addi x0, x0, 0 - NOP
end

endmodule