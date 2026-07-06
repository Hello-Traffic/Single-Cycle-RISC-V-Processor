module ALUCtrl (
    input [1:0] ALUOp,
    input funct7,
    input [2:0] funct3,
    output reg [3:0] ALUCtl
    );
    
    always@(*) begin
        ALUCtl = 4'b0000;


    if (ALUOp == 2'b10) //rtype
    begin
        if (funct7 == 0 && funct3 == 3'b000) //add
            ALUCtl = 4'b0010;
        else if (funct7 == 1 && funct3 == 3'b000) //sub
            ALUCtl = 4'b0001;
        else if (funct7 == 0 && funct3 == 3'b111) //and
            ALUCtl = 4'b0000;
        else if (funct7 == 0 && funct3 == 3'b110) //or
            ALUCtl = 4'b0011;
        else if (funct7 == 0 && funct3 == 3'b100) //xor
            ALUCtl = 4'b0100;
        else if (funct7 == 0 && funct3 == 3'b001) //sll
            ALUCtl = 4'b0101;
        else if (funct7 == 0 && funct3 == 3'b101) //srl
            ALUCtl = 4'b0110;
        else if (funct7 == 1 && funct3 == 3'b101) //sra
            ALUCtl = 4'b0111;
        else if (funct7 == 0 && funct3 == 3'b010) //slt
            ALUCtl = 4'b1000;
    end

    else if (ALUOp == 2'b11) //itype
    begin
        if (funct3==3'b000)//addi
            ALUCtl = 4'b0010;
        else if (funct3==3'b100)//xori
            ALUCtl = 4'b0100;
        else if (funct3==3'b110)//ori
            ALUCtl = 4'b0011;
        else if (funct3==3'b111)//andi
            ALUCtl = 4'b0000;
        else if (funct3==3'b010)//slti
            ALUCtl = 4'b1000;

    end
    else if (ALUOp == 2'b00) //load/store
    begin
        ALUCtl = 4'b0010; //add
    end

    else if (ALUOp == 2'b01) //branch
    begin
        if (funct3 == 3'b000) //beq
            ALUCtl = 4'b0001; //sub
        else if (funct3 == 3'b001) //bne
            ALUCtl = 4'b1111; //sub
        else if (funct3 == 3'b101) //bge
            ALUCtl = 4'b1110; //slt
        else 
            ALUCtl = 4'b1101; //jal

    end

    end

endmodule

