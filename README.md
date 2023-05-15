# CPU Design by Verilogician

Class: ECE 251 Computer Architecture  
Professor: Rob Marano  
Team Name: Verilogician  
Team Members: Annie He, Taeyoo Kim  
[Open in GitHub](https://github.com/cooper-union-ece-251-marano/ece-251-spring-2023-final-project-verilogician)  
[Watch demonstration on YouTube](https://youtu.be/j9Fcllo_UHU)

## Table of Contents

- [CPU Design by Verilogician](#cpu-design-by-verilogician)
  - [Table of Contents](#table-of-contents)
  - [Makefile Instructions](#makefile-instructions)
    - [General Instruction](#general-instruction)
    - [Individual Instructions](#individual-instructions)
  - [Architecture](#architecture)
    - [Instruction Format](#instruction-format)
    - [Instruction Set](#instruction-set)
    - [Register File](#register-file)
    - [Memory Layout](#memory-layout)
  - [Implementation](#implementation)
    - [Fibonacci Assembly](#fibonacci-assembly)
    - [Fibonacci Binary](#fibonacci-binary)

## Makefile Instructions

To run the program, make sure [GNU Make](https://www.gnu.org/software/make), [Icarus Verilog](https://bleyer.org/icarus), [GTKWave](https://gtkwave.sourceforge.net), and [Python](https://www.python.org) are installed.

### General Instruction

To set input, compile, simulate, then display with GTKWave:
```bash
make
#press enter after each command, but make sure to wait for the previous to complete (last line will say "read")
```
Below is an example output. The program prints out the result during simulation. In this case it prints "The Fibonacci is: 21" for an input of 8.

```bash
PS C:\ece-251-spring-2023-final-project-verilogician> make
make set
make[1]: Entering directory '/ece-251-spring-2023-final-project-verilogician'
Enter input: 8
make[1]: Leaving directory '/ece-251-spring-2023-final-project-verilogician'
make compile
make[1]: Entering directory '/ece-251-spring-2023-final-project-verilogician'
iverilog -g2012 -o test.out testbench.sv
make[1]: Leaving directory '/ece-251-spring-2023-final-project-verilogician'
read

make simulate
make[1]: Entering directory '/ece-251-spring-2023-final-project-verilogician'
vvp test.out
WARNING: ./design.sv:467: $readmemb(fib.exe): Not enough words in the file for the requested range [0:4095].
VCD info: dumpfile dump.vcd opened for output.
The Fibonacci is:         21
./design.sv:659: $finish called at 55680000 (1ps)
make[1]: Leaving directory '/ece-251-spring-2023-final-project-verilogician'
read

make display
make[1]: Entering directory '/ece-251-spring-2023-final-project-verilogician'
gtkwave dump.vcd

GTKWave Analyzer v3.3.100 (w)1999-2019 BSI

[0] start time.
[55680000] end time.
WM Destroy
make[1]: Leaving directory '/ece-251-spring-2023-final-project-verilogician'
```

### Individual Instructions

To set input:
```bash
make set
#enter a valid decimal number
```

To compile:
```bash
make compile
```

To simulate:
```bash
make simulate
```

To display with GTKWave:
```bash
make display
```

To clean up:
```bash
make clean
```

To push to GitHub:
```bash
make git
#press "i" to start commenting, then press "esc", type ":wq" and enter
```
## Architecture

This architecture references MIPS. It uses only one instruction type, demonstrating the principle "Simplicity Favors Regularity". Each word is 32 bits, with the opcode, rd, rs, rt all being 5 bits, leaving 12 bits for the immediate value. The 5-bit opcode allows for a total of 32 instructions. The 5-bit register addresses allow for the addressing of all 32 rows in the register file. The 12-bit immediate, when used as memory address, can address up to 4096 words, due to the memory's word addressability. The memory only has the text segment going up from address 0, and the stack going down from address 4095.

### Instruction Format

| opcode(5) | rd(5) | rs(5) | rt(5) | imm(12) |
|:--------------:|:------------:|:------------:|:------------:|  :------------:|
| 31 - 27 | 26 - 22 | 21 - 17 | 16 - 12 | 11 - 0 |

### Instruction Set

| name | format | operation | opcode |
|:--------------:|:------------:|:------------:|:------------:|
| add | add rd, rs, rt, Imm| R[rd] = R[rs] + R[rt] + signextImm | 00000 |
| sub | sub rd, rs, rt, Imm| R[rd] = R[rs] - R[rt] + signextImm | 00001 |
| beq | beq rs, rt, Imm| if(R[rs]==R[rt]): PC=Imm | 00010 |
| bne | bne rs, rt, Imm| if(R[rs]!=R[rt]): PC=Imm | 00011 |
| j | j rs/Imm | PC=R[rs]/Imm | 00100 |
| jal | jal Imm | R[3l]=PC+4; PC=Imm | 00101 |
| lw | lw rd, rt, Imm | R[rd] = M[R[rt] + signextImm] | 00110 |
| sw | sw rs, rt, Imm | M[R[rt]+SignExtImm] = R[rs] | 00111 |
| prt | prt rs/Imm| print R[rs] | 01000 |

### Register File

| name | number | use |
|:--------------:|:------------:|:------------:|
| $zero | 0 | The Constant Value 0 |
| \$v0 - $v2 | 1 - 3 | Values for Function Results |
| $a0 - $a5 | 4 - 9 | Arguments |
| $t0 - $t9 | 10 - 19 | Temporaries |
| $s0 - $s9 | 20 - 29 | Saved Temporaries |
| $sp | 30 | Stack Pointer |
| $ra | 31 | Return Address |

### Memory Layout

| pointer | address | use |
|:--------------:|:------------:|:------------:|
| $sp | 111111111111 - | Stack |
| pc | 000000000000 + | Text |

## Implementation

The maximum number that can be stored in a 32-bit signed number is 2147483647. The maximum Fibonacci number that can be stored is the 46th(1836311903), where the 47th(2971215073) will result in overflow. Each recursion of this Fibonacci program requires 3 words in the memory. The Fibonacci of 47 will require 138 words, well below the capacity of the memory in this design, which is 4096. 

### Fibonacci Assembly

```makefile
main:
    add $a0, $zero, $zero, input    #stores the input
    jal fib                         #fib
    prt $v0                         #prints the output
fib:
    add $sp, $sp, $zero, -2         #offsets the stack pointer to create a stack frame
    sw $ra, $sp, 2                  #stores the return address on the stack
    sw $s0, $sp, 1                  #stores s0 on the stack
    sw $s1, $sp, 0                  #stores s1 on the stack

    add $s0, $a0, $zero, 0          #copies the argument n onto s0

    bne $s0, $zero, elif            #jumps to elif if n is not zero
    add $v0, $zero, $zero, 0        #sets the return value to 0
    j end                           #jumps to the end of function
elif:
    add $t0, $zero, $zero, 1
    bne $s0, $t0, else              #jumps to else if n is not 1
    add $v0, $zero, $zero, 1        #sets the return value to 1
    j end                           #jumps to the end of function
else:
    add $a0, $s0, $zero, -1         #sets the argument to n-1
    jal fib                         #calls self recursively
    add $s1, $v0, $zero, 0          #copies the return value onto s1

    add $a0, $s0, $zero, -2         #sets the argument to n-2
    jal fib                         #calls self recursively
    add $v0, $s1, $v0, 0            #sets the return value to sum of two
end:
    lw $s1, $sp, 0                  #restores s1
    lw $s0, $sp, 1                  #restores s0
    lw $ra, $sp, 2                  #restores the return address
    add $sp, $sp, $zero, 2          #restores the stack pointer
    j $ra                           #returns the function
```

### Fibonacci Binary

```q
    opcode  rd      rs      rt      imm
    --------------------------------------------
    00000   00100   00000   00000   000000000000
    add	    $a0     $zero   $zero   input	
    00101   11111   00000   00000   000000000011
    jal                             fib
    01000   00000   00001   00000   000000000000
    prt             $v0
fib 000000000011:
    00000   11110   11110   00000   111111111101
    add     $sp     $sp     $zero   -3
    00111   00000   11111   11110   000000000010
    sw              $ra     $sp     2
    00111   00000   10100   11110   000000000001
    sw              $s0     $sp     1
    00111   00000   10101   11110   000000000000
    sw              $s1     $sp     0
    00000   10100   00100   00000   000000000000
    add     $s0     $a0     $zero   0
    00011   00000   00100   00000   000000001011
    bne             $s0     $zero   elif
    00000   00001   00000   00000   000000000000
    add     $v0     $zero   $zero   0
    00100   00000   00000   00000   000000010101
    j                               end
elif 000000001011:
    00000   01010   00000   00000   000000000001
    add     $t0     $zero   $zero   1
    00011   00000   00100   01010   000000001111
    bne             $s0     $t0     else
    00000   00001   00000   00000   000000000001
    add     $v0     $zero   $zero   1
    00100   00000   00000   00000   000000010101
    j                               end
else 000000001111:
    00000   00100   10100   00000   111111111111
    add     $a0     $s0     $zero   -1
    00101   11111   00000   00000   000000000011
    jal                             fib
    00000   10101   00001   00000   000000000000
    add     $s1     $v0     $zero   0
    00000   00100   10100   00000   111111111110
    add     $a0     $s0     $zero   -2
    00101   11111   00000   00000   000000000011
    jal                             fib
    00000   00001   10101   00001   000000000000
    add     $v0     $s1     $v0     0
end 000000010101:
    00110   10101   00000   11110   000000000000
    lw      $s1             $sp     0
    00110   10100   00000   11110   000000000001
    lw      $s0             $sp     1
    00110   11111   00000   11110   000000000010
    lw      $ra             $sp     2
    00000   11110   11110   00000   000000000011
    add     $sp     $sp     $zero   3
    00100   00000   11111   00000   000000000000
    j               $ra
```

