![image -> Processor](https://github.com/Rohan7Gupta/smitrv/assets/107053094/ef118744-9367-43c2-9b14-e6c7b1c1c094)
![image -> R TYPE](https://github.com/Rohan7Gupta/smitrv/assets/107053094/aa4e96d8-b3d9-4223-8078-18cca0e9445c)
![image -> I type](https://github.com/Rohan7Gupta/smitrv/assets/107053094/b7374167-2251-4479-a7c9-46cf2f3f85b2)


INPUTS: SrcA[31:0] -> 
        SrcB[31:0] ->  (from ALU mux)
        ALUControl[2:0] -> 3 bits from control unit
                      Assuming [a b c] 
                      a b c <=> instruction[14:12]
                      a <=> if instruction[31:25]=0, a=0
                            if instruction[31:25]=32, a=1
        ALUOp[2:0] -> 0 -> R (ADD,AND,OR,SLL,STL,STLU,SRL,XOR)
                      1 -> R (SUB, SRA)
                      2 -> I opcode values are different according to their respective purpose. 
                            Like for loading instruction it is “0000011”, for register jump it is “1100111”, for immediate arithmetic, logical operation and shift operation it is “0010011” 
                      3 -> B opcode “1100011”
                      4 -> J opcode value is “1101111”
                      5 -> S opcode is given by “0100011”
                      6 -> U opcode values are “0010111” or “0110111” 
                      _______________
                      from ALU_ctrl
                      
OUTPUT: ALUResult[31:0]
        branchTaken

Reference: https://medium.com/programmatic/how-to-design-a-risc-v-processor-12388e1163c
