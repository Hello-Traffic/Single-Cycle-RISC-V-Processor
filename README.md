# Single-Cycle RISC-V Processor

A 32-bit **Single-Cycle RISC-V (RV32I)** processor designed and implemented in **Verilog HDL**. This project demonstrates the complete datapath and control logic of a single-cycle processor capable of executing a subset of the RV32I instruction set.

The processor was designed from scratch as part of a Computer Architecture learning project and verified through simulation using multiple instruction sequences.

---

## Features

- 32-bit RV32I Single-Cycle Processor
- Modular Verilog implementation
- Separate Control Unit and ALU Control
- Register File with 32 General Purpose Registers
- Immediate Generator
- Arithmetic Logic Unit (ALU)
- Instruction Memory
- Data Memory
- Branch Decision Logic
- Simulation-based verification using Icarus Verilog

---

## Supported RV32I Instructions

The processor currently supports the following subset of the RV32I instruction set:

- **Arithmetic:** ADD, SUB, ADDI
- **Logical:** AND, OR, XOR, ANDI, ORI, XORI
- **Shift:** SLL, SRL, SRA
- **Comparison:** SLT, SLTI
- **Memory:** LW, SW
- **Branch:** BEQ, BNE, BGE

# Project Structure

```
Single-Cycle-RISC-V-Processor
│
├── RTL
│   ├── ALU.v
│   ├── ALUCtrl.v
│   ├── Adder.v
│   ├── Control.v
│   ├── DataMemory.v
│   ├── ImmGen.v
│   ├── InstructionMemory.v
│   ├── Mux2to1.v
│   ├── PC_SingleCycle.v
│   ├── Register.v
│   ├── ShiftLeftOne.v
│   └── SingleCycleCPU.v
│
├── TestPrograms
│   └── mixed.mem
│
├── Images
│
└── README.md
```

---

# Processor Components

- Program Counter (PC)
- Instruction Memory
- Register File
- Control Unit
- Immediate Generator
- ALU Control
- Arithmetic Logic Unit
- Data Memory
- Branch Logic
- Multiplexers and Adders

---

# Verification

The processor was verified using several hand-written RISC-V assembly programs covering:

- Arithmetic operations
- Logical operations
- Shift operations
- Immediate instructions
- Memory access instructions
- Branch instructions
- Mixed instruction sequences


# Future Improvements

- Complete RV32I ISA implementation
- Jump instructions (JAL/JALR)
- Byte and Half-word load/store support
- Exception and interrupt handling
- Five-stage pipelined implementation
- Forwarding and Hazard Detection
- Branch Prediction

---

# Author

**Shyam Suresh**

Electronics and Communication Engineering  
Ramaiah Institute of Technology
