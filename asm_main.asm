;
; file: asm_main.asm
; Author
; Description: 
;
;

%include "asm_io.inc"



;--------------------------------------------------------
; initialized data is put in the .data segment
;
segment .data


;--------------------------------------------------------
; uninitialized data is put in the .bss segment
;
segment .bss


;--------------------------------------------------------
; code is put in the .text segment
;
segment .text
        global  asm_main



;--------------------------------------------------------
; MAIN FUNCTION						;
;--------------------------------------------------------

asm_main:

;--------------------------------------------------------
; PROLOGUE						;
;--------------------------------------------------------
        enter   0,0               ; setup routine
        pusha

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
