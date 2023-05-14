#
# Makefile for Verilog building
# 
# USE THE FOLLOWING COMMANDS WITH THIS MAKEFILE
#	"make" - compiles verilog design, runs the file, opens in gtkwave (press enter between each, wait for the previous to complete)
#	"make clean" - cleans up the generated files
# 
###############################################################################
#MAKE DIRECTIVES
run:
	iverilog -g2012 -o test.out testbench.sv
	read
	vvp test.out
	read
	gtkwave dump.vcd
set:
	sed -i -e "s/tmp/$y/" testbench.sv
compile:
	iverilog -g2012 -o test.out testbench.sv
simulate:
	vvp test.out
clean:
	rm -f *.out *.vcd
display:
	gtkwave dump.vcd
git:
	git add .
	git commit && git push -u origin submission