TITLE Example of ASM              (helloword.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
main          EQU start@0

;Comment @
;Definitions copied from SmallWin.inc:

.data
	
.code
main PROC		
	mov al, 110b	;al register = 6's binary 	
	mov ah, 6		;ah register = 6's decimal
	mov ax,	0FA6h	;ax register = 4006's hex
	mov dx, 0eeeah	;dx register = 0xeeea
	sub dx, ax		;dx -= ax
	exit
main ENDP
END main