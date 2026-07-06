module Register (
    input clk,
    input rst,
    input regWrite,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    output [31:0] readData1,
    output [31:0] readData2
);
    reg [31:0] regs [0:31];


    assign readData1 = (readReg1!=0)?regs[readReg1]:0;
    assign readData2 = (readReg2!=0)?regs[readReg2]:0;
     
    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;

            regs[2] <= 32'd128;    // Initialize stack pointer (sp = x2)
        end
        else if (regWrite) begin
            if (writeReg != 0)
                regs[writeReg] <= writeData;
        end

        // Ensure x0 always remains zero
        regs[0] <= 32'b0;
    end

endmodule

