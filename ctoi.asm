;
; file: ctoi.asm
; Author: Matthew Sprigg
; Description: Takes single character
; 	and returns integer counterpart.
;	Returns 0 if not a character.

%include "asm_io.inc"

 
%define char ebp+8

;--------------------------------------------------------
; initialized data is put in the .data segment
;
segment .data

warning	db "This character is not an ascii integer.", 10, 0 ;

;--------------------------------------------------------
; code is put in the .text segment
;
segment .text
        global ctoi

;--------------------------------------------------------
; MAIN FUNCTION						;
;--------------------------------------------------------

ctoi:

;--------------------------------------------------------
; PROLOGUE						;
;--------------------------------------------------------
        enter   0,0               ; setup routine
        pusha

;--------------------------------------------------------
; CODE							;
;--------------------------------------------------------

; if (char < 48 || char > 57)
;	return 0;
; 

	cmp	byte [char], 48
	jnl	continue
	cmp	byte [char], 57
	jng	continue

	; Return 0.
	mov	byte [char], 0
	jmp	return

	; Otherwise, continue.
continue:
	sub	byte [char], 48
	
;--------------------------------------------------------
; EPILOGUE						;
;--------------------------------------------------------
return:
        popa
        movzx	eax, byte [char] ;return int val.
        leave
        ret


;--------------------------------------------------------
; FUNCTIONS / SUBPROGRAMS			 	;
;--------------------------------------------------------
