module SingleCycleCPU (
    input clk,
    input start
    
);

// Internal wires
wire [31:0] pc_o, pc_1, p1, p2;
wire [31:0] inst;
wire branch, memRead, memtoReg, memWrite, ALUSrc, regWrite;
wire [1:0] ALUOp;
wire [31:0] readData1, readData2, writeData;
wire [31:0] imm, imm_shifted;
wire [31:0] A, B, ALUOut, readData;
wire [31:0] address = ALUOut;
wire zero;
wire [3:0] ALUCtl;
wire [4:0] readReg1, readReg2, writeReg;

assign readReg1 = inst[19:15];
assign readReg2 = inst[24:20];
assign writeReg = inst[11:7];

// Instantiate modules

PC m_PC(
    .clk(clk),
    .rst(~start),
    .pc_i(pc_1),
    .pc_o(pc_o)
);

Adder m_Adder_1(
    .a(pc_o),
    .b(32'd4),
    .sum(p1)
);

InstructionMemory m_InstMem(
    .readAddr(pc_o),
    .inst(inst)
);

Control m_Control(
    .opcode(inst[6:0]),
    .branch(branch),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .ALUOp(ALUOp),
    .memWrite(memWrite),
    .ALUSrc(ALUSrc),
    .regWrite(regWrite)
);


Register m_Register(
    .clk(clk),
    .rst(~start),
    .regWrite(regWrite),
    .readReg1(readReg1),
    .readReg2(readReg2),
    .writeReg(writeReg),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2)
);


ImmGen #(.Width(32)) m_ImmGen(
    .inst(inst),
    .imm(imm)
);

ShiftLeftOne m_ShiftLeftOne(
    .i(imm),
    .o(imm_shifted)
);

Adder m_Adder_2(
    .a(pc_o),
    .b(imm_shifted),
    .sum(p2)
);

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(branch & zero),
    .s0(p1),
    .s1(p2),
    .out(pc_1)
);

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(ALUSrc),
    .s0(readData2),
    .s1(imm),
    .out(B)
);

ALUCtrl m_ALUCtrl(
    .ALUOp(ALUOp),
    .funct7(inst[30]),
    .funct3(inst[14:12]),
    .ALUCtl(ALUCtl)
);

ALU m_ALU(
    .ALUCtl(ALUCtl),
    .A(readData1),
    .B(B),
    .ALUOut(ALUOut),
    .zero(zero)
);

DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(ALUOut),
    .writeData(readData2),
    .readData(readData)
);

Mux2to1 #(.size(32)) m_Mux_WriteData(
    .sel(memtoReg),
    .s0(ALUOut),
    .s1(readData),
    .out(writeData)
);

endmodule


`timescale 1ns/1ps

module tb_riscv_sc;

reg clk;
reg start;

SingleCycleCPU dut(
    .clk(clk),
    .start(start)
);

// Clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    start = 0;

    $dumpfile("risc.vcd");
    $dumpvars(0, tb_riscv_sc);

    #12;
    start = 1;

    #200;

    $display("\n========================================");
    $display("FINAL REGISTER VALUES");
    $display("========================================");
    $display("x0  = %h", dut.m_Register.regs[0]);
    $display("x1  = %h", dut.m_Register.regs[1]);
    $display("x2  = %h", dut.m_Register.regs[2]);
    $display("x3  = %h", dut.m_Register.regs[3]);
    $display("x4  = %h", dut.m_Register.regs[4]);
    $display("x5  = %h", dut.m_Register.regs[5]);
    $display("x6  = %h", dut.m_Register.regs[6]);
    $display("========================================");

    $display("MEM[0] = %h", dut.m_DataMemory.data_memory[0]);
    $display("MEM[1] = %h", dut.m_DataMemory.data_memory[1]);
    $display("MEM[2] = %h", dut.m_DataMemory.data_memory[2]);
    $display("MEM[3] = %h", dut.m_DataMemory.data_memory[3]);

    $finish;
end

always @(posedge clk) begin
    if(start) begin
        $display("------------------------------------------------");
        $display("PC        = %h", dut.pc_o);
        $display("INST      = %h", dut.inst);

        $display("opcode    = %b", dut.inst[6:0]);

        $display("memRead   = %b", dut.memRead);
        $display("memWrite  = %b", dut.memWrite);
        $display("memtoReg  = %b", dut.memtoReg);
        $display("regWrite  = %b", dut.regWrite);

        $display("ALUOut    = %h", dut.ALUOut);

        $display("readData1 = %h", dut.readData1);
        $display("readData2 = %h", dut.readData2);

        $display("writeData = %h", dut.writeData);
        $display("ReadData  = %h", dut.readData);

        $display("MEM[0..3] = %h %h %h %h",
            dut.m_DataMemory.data_memory[3],
            dut.m_DataMemory.data_memory[2],
            dut.m_DataMemory.data_memory[1],
            dut.m_DataMemory.data_memory[0]);
    end
end

endmodule




