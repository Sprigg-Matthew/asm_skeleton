; Decimal to roman numeral converter.
; file: asm_main.asm
; Author: Matthew Sprigg
; Description: Takes cli arg of int beteen 0 and 4000 exclusive.
;
;

%include "asm_io.inc"

%define intstr ebp+8 ; Param from C
%define count  ebx   ; register int  count;
%define sptr   edx   ; register char *sptr;
;--------------------------------------------------------
; initialized data is put in the .data segment
;
segment .data

; 3D array of character strings  5 x 10 x 4.
; x = 5 b/c longest string is the digit eight which
; 	will always take 4 characters plus a null byte.
; y = 9 b/c there are 10 possible digits (0-9).
; z = 4 b/c there are 4  possible digits (thousands)
;
rom: 	db  0,   0, 0, 0, 0, \
	   'I',  0, 0, 0, 0, \
	   'II',    0, 0, 0, \
	   'III',      0, 0, \
	   'IV',    0, 0, 0, \
	   'V',  0, 0, 0, 0, \
	   'VI',    0, 0, 0, \
	   'VII',      0, 0, \
	   'VIII',        0, \
	   'IX',    0, 0, 0, \
	    0,   0, 0, 0, 0, \
	   'X',  0, 0, 0, 0, \
	   'XX',    0, 0, 0, \
	   'XXX',      0, 0, \
	   'XL',    0, 0, 0, \
	   'L',  0, 0, 0, 0, \
           'LX',    0, 0, 0, \
	   'LXX',      0, 0, \
	   'LXXX',        0, \
	   'XC',    0, 0, 0, \
	    0,   0, 0, 0, 0, \
	   'C',  0, 0, 0, 0, \
	   'CC',    0, 0, 0, \
	   'CCC',      0, 0, \
	   'CD',    0, 0, 0, \
           'D',  0, 0, 0, 0, \
	   'DC',    0, 0, 0, \
	   'DCC',      0, 0, \
	   'DCCC',        0, \
	   'CM',    0, 0, 0, \
            0,   0, 0, 0, 0, \
	   'M',  0, 0, 0, 0, \
	   'MM',    0, 0, 0, \
	   'MMM',      0, 0
;--------------------------------------------------------
; uninitialized data is put in the .bss segment
;
;segment .bss


;--------------------------------------------------------
; code is put in the .text segment
;
segment .text
        global  asm_main
	extern  ctoi


;--------------------------------------------------------
; MAIN FUNCTION						;
;--------------------------------------------------------

asm_main:

;--------------------------------------------------------
; PROLOGUE						;
;--------------------------------------------------------
        enter   0,0               ; setup routine
        pusha

;    	VAR TABLE
; ==========================
; ebp+8 = char &intstr[0] || instr ; string from C driver
; ebx   = register int count       ;
; sptr   = register char *sptr 

;--------------------------------------------------------
; CODE							;
;--------------------------------------------------------
	; Get intstr length.
	mov	count, 0 	    ; intiailize count
getlen:
	mov     sptr, [intstr]	    ; *(&intstr[0]+count)	
	add	sptr, count
	inc	count		    ; count++
	cmp	byte [sptr], 0	    ; break if null byte.
	jnz	getlen

	; count = strlen(intstr) including null byte.
	; sptr pointed at null byte

	dec	count	    ; = strlen not including null byte.
	sub	sptr, count ; pointed at first char.
	dec	count	    ; Decremented to function as 0 index.
	imul	count, 50   ; 3rd Dimension index.

getrom: 
	movzx	eax, byte [sptr]  ; load char int
	push	eax		  ; pass to ctoi
	call 	ctoi		  ; eax=ctoi(*sptr);
	add	esp, 4		  ; clean stack

	imul	eax, 5		; 2nd dimension (str   dimension)
	add	eax, count 	; 3rd dimension (digit dimension)
	add	eax, rom	; *ebx = &intstr+50j+5i

	call	print_string	; pass ptr to print_str

	inc	sptr		; Next digit
	sub	count, 50	; decrement digit dimension.
	cmp byte [sptr], 0	; break at null byte.
	jnz	getrom

	call	print_nl	
;--------------------------------------------------------
; EPILOGUE						;
;--------------------------------------------------------
        popa
        mov     eax, 0            ; return back to C
        leave
        ret


;--------------------------------------------------------
; FUNCTIONS / SUBPROGRAMS			 	;
;--------------------------------------------------------
