# RISC-V ALU Design

## Overview

This project involves the design of a RISC-V processor ALU. The processor has various components, and this README provides information about the Arithmetic Logic Unit (ALU) and its inputs and outputs.

## Processor Architecture

![Processor Architecture](https://github.com/Rohan7Gupta/smitrv/assets/107053094/ef118744-9367-43c2-9b14-e6c7b1c1c094)

## ALU Details

### Inputs

1. **SrcA[31:0]:** First source operand for the ALU.
2. **SrcB[31:0]:** Second source operand for the ALU, selected from the ALU multiplexer.
3. **ALUControl[2:0]:** Control signals for the ALU operation, represented as [a b c]: from Control_unit
4. **ALUop[2:0]:** Specifies the ALU operation based on the opcode of the instruction: (from ALU_OP module)
   - `0:` R-type operation (ADD, AND, OR, SLL, STL, STLU, SRL, XOR).
   - `1:` R-type operation (SUB, SRA).
   - `2:` I-type operation with specific opcode values.
   - `3:` B-type operation with opcode "1100011".
   - `4:` J-type operation with opcode "1101111".
   - `5:` S-type operation with opcode "0100011".
   - `6:` U-type operation with specific opcode values.

### Outputs

1. **ALUResult[31:0]:** Result of the ALU operation (to multiplexer).
2. **branchTaken:** Indicates whether a branch is taken.

## Example Instructions

### R-Type Instruction

![R-Type Instruction](https://github.com/Rohan7Gupta/smitrv/assets/107053094/aa4e96d8-b3d9-4223-8078-18cca0e9445c)

### I-Type Instruction

![I-Type Instruction](https://github.com/Rohan7Gupta/smitrv/assets/107053094/b7374167-2251-4479-a7c9-46cf2f3f85b2)

## Reference

For more details on the RISC-V processor design, you can refer to the [Medium article](https://medium.com/programmatic/how-to-design-a-risc-v-processor-12388e1163c).

