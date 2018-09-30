/*
 * file: main.c
 * main C program that uses assembly routine in prog.asm
 * to create executable:
 * gcc:   gcc -m32 -o main main.c asm_main.o asm_io.o
 */

#include "cdecl.h"
#include "stdlib.h"
#include "stdio.h"
int PRE_CDECL asm_main( char *) POST_CDECL;

int main(int argc, char *argv[])
{
	// ERROR CATCHING

    if (argc<1 || atoi(argv[1]) <= 0 || atoi(argv[1])>3999) {
	printf("Please enter at least one argument of an integer greater than zero and less than 4000");
	return 0;
}

	// Pass arg to asm
    asm_main(argv[1]);
    return 0; // Exit C
}
