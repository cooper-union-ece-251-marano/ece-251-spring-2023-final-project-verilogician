# CPU Design by Verilogician

Class: ECE 251 Computer Architecture  
Professor: Rob Marano  
Team Name: Verilogician  
Team Members: Annie He, Taeyoo Kim  
[Open in GitHub](https://github.com/cooper-union-ece-251-marano/ece-251-spring-2023-final-project-verilogician)  
[Open in GitHub/Submission](https://github.com/cooper-union-ece-251-marano/ece-251-spring-2023-final-project-verilogician/tree/submission)

## Table of Contents

- [CPU Design by Verilogician](#cpu-design-by-verilogician)
  - [Table of Contents](#table-of-contents)
  - [Makefile Instructions](#makefile-instructions)
  - [Architecture](#architecture)
    - [Instruction Format](#instruction-format)
    - [Instruction Set](#instruction-set)
    - [Register File](#register-file)
  - [Implementation](#implementation)
    - [Fibonacci Assembly](#fibonacci-assembly)
    - [Fibonacci Binary](#fibonacci-binary)

## Makefile Instructions

To compile, simulate, then disply with GTKWAVE:
```bash
make
#press enter after each command, but make sure to wait for the previous to complete
```

To compile:
```bash
make compile
```

To simulate:
```bash
make simulate
```

To display with GTKWAVE:
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
#press "i" to start commenting, press "esc" then type ":wq" and enter
```
## Architecture

### Instruction Format
This simplified ISA uses only one instruction type.  

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
| lw | lw rs, rt, Imm | R[rs] = M[R[rt] + signextImm] | 00110 |
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

## Implementation

### Fibonacci Assembly

```makefile
main:
    add $a0, $zero, $zero, input    #store the input
    jal fib                         #fib
    prt $v0                         #print the output
fib:
    add $sp, $sp, $zero, -8         #offsets the stack pointer to create a stack frame
    sw $ra, $sp, 8                  #stores the return address on the stack
    sw $s0, $sp, 4                  #stores s0 on the stack
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
    lw $s0, $sp, 4                  #restores s0
    lw $ra, $sp, 8                  #restores the return address
    add $sp, $sp, $zero, 8          #restores the stack pointer
    j $ra                           #returns the function
```

### Fibonacci Binary

```q
    opcode  rd      rs      rt      imm
    --------------------------------------------
    00000   00100   00000   00000   000000000000
    add	    $a0     $zero   $zero   input	
    00101   00000   00000   00000   000000000011
    jal                             fib
    01000   00000   00001   00000   000000000000
    prt             $v0
fib 000000000011:
    00000   11110   11110   00000   111111111000
    add     $sp     $sp     $zero   -8
    00111   00000   11111   11110   000000001000
    sw              $ra     $sp     8
    00111   00000   10100   11110   000000000100
    sw              $s0     $sp     4
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
    00101   00000   00000   00000   000000000011
    jal                             fib
    00000   10101   00001   00000   000000000000
    add     $s1     $v0     $zero   0
    00000   00100   10100   00000   111111111110
    add     $a0     $s0     $zero   -2
    00101   00000   00000   00000   000000000011
    jal                             fib
    00000   00001   10101   00001   000000000000
    add     $v0     $s1     $v0     0
end 000000010101:
    00110   00000   10101   11110   000000000000
    lw              $s1     $sp     0
    00110   00000   10100   11110   000000000100
    lw              $s0     $sp     4
    00110   00000   11111   11110   000000001000
    lw              $ra     $sp     8
    00000   11110   11110   00000   000000001000
    add     $sp     $sp     $zero   8
    00100   00000   11111   00000   000000000000
    j               $ra
```

