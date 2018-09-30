# http://pirate.shu.edu/~minimair/assembler/Makefile
#
all: main

asm_io.o : asm_io.asm
	nasm -dELF_TYPE -f elf -g asm_io.asm -o asm_io.o


ctoi.o : ctoi.asm
	nasm -dELF_TYPE -f elf -g ctoi.asm -o ctoi.o

asm_main.o : asm_main.asm
	nasm -l asm_main.list -f elf -g -F stabs asm_main.asm -o asm_main.o

main : asm_io.o asm_main.o ctoi.o
	gcc -m32 -g -o main asm_main.o asm_io.o ctoi.o main.c

run : 
	./main

edit:
	vim asm_main.asm

debug:
	gdb ./main

clean :
	@rm *.o *.list main
