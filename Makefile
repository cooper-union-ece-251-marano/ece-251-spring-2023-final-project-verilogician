run:
	make set
	make compile
	read
	make simulate
	read
	make display
set:
	@read -p "Enter input: " INPUT; \
	if [ -n "$$INPUT" ] && [ "$$INPUT" -eq "$$INPUT" ] 2>/dev/null; then \
		BINARY=$$(python -c "print(bin($$INPUT)[2:].zfill(12))"); \
		sed -i "1s/.*/00000001000000000000$${BINARY}/" fib.exe; \
	else \
		echo "Invalid input. Please enter a valid number."; \
		make set; \
	fi
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