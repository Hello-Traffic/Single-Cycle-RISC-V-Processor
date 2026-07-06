module Control (
    input [6:0] opcode,
    output reg  branch,
    output reg  memRead,
    output reg  memtoReg,
    output reg [1:0] ALUOp,
    output reg memWrite,
    output reg ALUSrc,
    output reg regWrite
    );

    always@(*) begin
        
    if (opcode == 7'b0110011) //rtype
    begin 
        branch = 0;
        memRead = 0;
        memtoReg = 0;
        ALUOp = 2'b10;
        memWrite = 0;
        ALUSrc = 0;
        regWrite = 1;

    end

    else if (opcode == 7'b0010011) //itype
    begin 
        branch = 0;
        memRead = 0;
        memtoReg = 0;
        ALUOp = 2'b11;
        memWrite = 0;
        ALUSrc = 1;
        regWrite = 1;

    end

    else if (opcode == 7'b0000011) //load
    begin
        branch = 0;
        memRead = 1;
        memtoReg = 1;
        ALUOp = 2'b00;
        memWrite = 0;
        ALUSrc = 1;
        regWrite = 1;
            
    end
    
    else if (opcode == 7'b0100011) //store
    begin
        branch=0;
        memRead=0;
        memtoReg=0;
        ALUOp=2'b00;
        memWrite=1;
        ALUSrc=1;
        regWrite=0;
        
    end

    else if (opcode == 7'b1100011) //branch
    begin
        branch=1;
        memRead=0;
        memtoReg=0;
        ALUOp=2'b01;
        memWrite=0;
        ALUSrc=0;
        regWrite=0;

    end

    else if (opcode == 7'b1101111) //jal
    begin
        branch=1;
        memRead=0;
        memtoReg=0;
        ALUOp=2'b01; 
        memWrite=0;
        ALUSrc=0;
        regWrite=0;
    end
    end

endmodule




