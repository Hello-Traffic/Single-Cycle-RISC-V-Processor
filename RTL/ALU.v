module ALU (
    input [3:0] ALUCtl,
    input [31:0] A,B,
    output reg [31:0] ALUOut,
    output reg zero
);
always @(*) begin
    case (ALUCtl)
        4'b0010: ALUOut = A + B; //add
        4'b0001: ALUOut = A - B; //sub
        4'b0000: ALUOut = A & B; //and
        4'b0011: ALUOut = A | B; //or
        4'b0100: ALUOut = A ^ B; //xor
        4'b0101: ALUOut = A << B[4:0]; //sll
        4'b0110: ALUOut = A >> B[4:0]; //srl
        4'b0111: ALUOut = $signed(A) >>> B[4:0]; //sra
        4'b1000: ALUOut = ($signed(A) < $signed(B)) ? 1 : 0; //slt
        4'b1101: ALUOut = 0;
        4'b1110: ALUOut = ($signed(A) >= $signed(B)) ? 1 : 0;
        4'b1111: ALUOut = (A != B) ? 1 : 0;// FOR BNE
        default: ALUOut = 32'b0;
    endcase

    if (ALUCtl==4'b0001 && ALUOut == 0) //sub and zero
        zero = 1;
    else if (ALUCtl==4'b1111 && ALUOut != 0) //BNE and zero
        zero = 1;
    else if (ALUCtl==4'b1110 && ALUOut == 1)
        zero = 1;
    else if (ALUCtl==4'b1101) //for jal
        zero = 1;
    else
        zero = 0;

    
end
    
endmodule

