# RISC-V ALU Design
By Rohan Gupta & Adideb Das

## Overview

- This project involves the design of a RISC-V processor ALU. The processor has various components, and this README provides information about the Arithmetic Logic Unit (ALU) and its inputs and outputs.
- Note -> The decode unit decodes the instructions and prepares the immediate values and shift values in the immediate register

## issues
- The implemnentation for pc=pc+4 is not added yet.(will pc be increemented in the alu?) (ALU_ctrl, MUX32_4_1.v)
- SRA implementation in ALU_core (same o/p as SRL)

## Required files :
1. alu_core.v
2. MUX32_2_1_ALU_out.v
3. MUX32_4_1_SrcB.v
4. MUX32_2_1_SrcA.v
5. ALU_tb.v

## Processor Architecture

![image](https://github.com/Rohan7Gupta/smitrv/assets/107053094/6acc542f-2c5a-48dc-99da-47f815d5eb7d)


## ALU Details

### alu.v
#### Inputs
1. **opcode[6:0]:** Specifies the ALU operation based on the opcode of the instruction: (from Control unit module) (R,I,B,J,S,L) Types
2. **AluControl_reg[3:0]** From decode
    - 0000 add/addi
    - 0001 sll/slli
    - 0010 slt/slti
    - 0011 sltu/sltui
    - 0100 xor/xori/blt
    - 0101 srl/srli/bge
    - 0110 sra/srai/bltu
    - 0111 and/andi/bgeu
    - 1000 sub / beq
    - 1001 bne
    - 1010 
    - 1011
    - 1100 blt
    - 1101 sra/srai/ bge
    - 1110 bltu
    - 1111 bgeu
4. **SrcA[31:0], SrcB[31:0]**:data signals from mux

#### Outputs
1.. **ALUResult[31:0]:** Result of the ALU operation (to multiplexer).
2. **branch**: ?( Branch taken : branch not taken)

## Instruction format
![image](https://github.com/Rohan7Gupta/smitrv/assets/107053094/15405f0f-cb8d-42f9-9c77-184ecde39977)


## testing
### ALU_core_tb.v
##### How to execute
- iverilog -o ALU_tb.vvp ALU_tb.v
- vvp ALU_tb.vvp
- gtkwave alu_test.vcd

## ALU_tb waveform
![image](https://github.com/Rohan7Gupta/smitrv/assets/107053094/3c6144b0-0370-479c-a4a0-f6bceb099427)




## Reference

- [Medium article](https://medium.com/programmatic/how-to-design-a-risc-v-processor-12388e1163c).
- https://github.com/johnwinans/rvalp/releases
- https://github.com/Moo-osama/RISCV-verilog/tree/main

