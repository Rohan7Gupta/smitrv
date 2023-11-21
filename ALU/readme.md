# RISC-V ALU Design
By Rohan Gupta & Adideb Das

## Overview

- This project involves the design of a RISC-V processor ALU. The processor has various components, and this README provides information about the Arithmetic Logic Unit (ALU) and its inputs and outputs.
- Note -> The decode unit decodes the instructions and prepares the immediate values and shift values in the immediate register

## issues
- The implemnentation for pc=pc+4 is not added yet.(will pc be increemented in the alu?) (ALU_ctrl, MUX32_4_1.v)
- SRA implementation in ALU_core (same o/p as SRL)

## Ignore files other than:
1. alu_core.v
2. MUX32_2_1_ALU_out.v
3. MUX32_4_1_SrcB.v
4. MUX32_2_1_SrcA.v

## Processor Architecture

![Processor Architecture](https://github.com/Rohan7Gupta/smitrv/assets/107053094/ef118744-9367-43c2-9b14-e6c7b1c1c094)

## ALU Details

### alu.v
#### Inputs
1. **opcode[6:0]:** Specifies the ALU operation based on the opcode of the instruction: (from Control unit module) (R,I,B,J,S,L) Types
2. **funct3_reg[2:0]:** Control signals for the ALU operation, represented as [a b c]: from Control_unit
3. **funct7_reg[6:0]:** add or sub (from control unit)
4. **SrcA[31:0], SrcB[31:0]**:data signals from mux

#### Outputs
1.. **ALUResult[31:0]:** Result of the ALU operation (to multiplexer).
2. **branch**: ?( Branch taken : branch not taken)

## Instruction format
![image](https://github.com/Rohan7Gupta/smitrv/assets/107053094/15405f0f-cb8d-42f9-9c77-184ecde39977)


## testing
### ALU_core_tb.v
##### How to execute
- iverilog -o ALU_core_tb.vvp ALU_core_tb.v
- vvp ALU_core_tb.vvp
- gtkwave alu_core_test.vcd

## ALU_tb waveform
![image](https://github.com/Rohan7Gupta/smitrv/assets/107053094/cc2522a4-84ac-4ead-87cd-0fc07cda0a9b)



## Reference

- [Medium article](https://medium.com/programmatic/how-to-design-a-risc-v-processor-12388e1163c).
- https://github.com/johnwinans/rvalp/releases
- https://github.com/Moo-osama/RISCV-verilog/tree/main

