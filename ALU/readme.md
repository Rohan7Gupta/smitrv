# RISC-V ALU Design
By Rohan Gupta & Adideb Das

## Overview

- This project involves the design of a RISC-V processor ALU. The processor has various components, and this README provides information about the Arithmetic Logic Unit (ALU) and its inputs and outputs.
- Note -> The decode unit decodes the instructions and prepares the immediate values and shift values in the immediate register

## issues
- The implemnentation for pc=pc+4 is not added yet.(will pc be increemented in the alu?) (ALU_ctrl, MUX32_4_1.v)
- SRA implementation in ALU_core (same o/p as SRL)

## Ignore files other than:
1. ALU_core.v
2. alu_ctrl.v
3. MUX32_4_1.v
4. MUX32_2_1.v
5. defines.v
6. branch_control.v
## Processor Architecture

![Processor Architecture](https://github.com/Rohan7Gupta/smitrv/assets/107053094/ef118744-9367-43c2-9b14-e6c7b1c1c094)

## ALU Details
### alu_ctrl.v
#### Inputs
1. **opcode[6:0]:** Specifies the ALU operation based on the opcode of the instruction: (from Control unit module) (R,I,B,J,S,L) Types
2. **funct3_reg[2:0]:** Control signals for the ALU operation, represented as [a b c]: from Control_unit
3. **funct7_reg[6:0]:** add or sub (from control unit)

#### Outputs
1. **ALUOp[3:0]:** Type of operation
-  ADD         4'b00_00
-  SUB         4'b00_01
-  PASS        4'b00_11
-  OR          4'b01_00
-  AND         4'b01_01
-  XOR         4'b01_11
-  SRL         4'b10_00
-  SRA         4'b10_10
-  SLL         4'b10_01
- SLT         4'b11_01
- SLTU        4'b11_11
- NOP         4'b11_10

### ALU_core.v
#### Inputs
1. **SrcA[31:0]:** First source operand for the ALU from MUX32_2_!.
2. **SrcB[31:0]:** Second source operand for the ALU, selected from MUX32_4_1.
3. **ALUOp:** Type of operatin.

#### Outputs
1. **ALUResult[31:0]:** Result of the ALU operation (to multiplexer).
2. **zerof , signf, overFlowf, carryf**  Flags

### branch_control.v
#### Inputs
1. **opcode[6:0]:** Specifies the ALU operation based on the opcode of the instruction: (from Control unit module) (R,I,B,J,S,L) Types
2. **funct3_reg[2:0]:** Control signals for the ALU operation, represented as [a b c]: from Control_unit
3. **zf , sf, of, cf**  Flags

#### Outputs
1. **branch** 1 if branch or 0

## testing
### ALU_core_tb.v
##### How to execute
- iverilog -o ALU_core_tb.vvp ALU_core_tb.v
- vvp ALU_core_tb.vvp
- gtkwave alu_core_test.vcd

## Instruction format
![image](https://github.com/Rohan7Gupta/smitrv/assets/107053094/15405f0f-cb8d-42f9-9c77-184ecde39977)

## ALU_core_tb waveform


## Reference

- [Medium article](https://medium.com/programmatic/how-to-design-a-risc-v-processor-12388e1163c).
- (https://github.com/Moo-osama/RISCV-verilog/tree/main)

