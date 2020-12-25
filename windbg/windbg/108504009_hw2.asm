TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
main          EQU start@0

.data
	;some data
	ChStrs BYTE "  ****  "
		   BYTE " **  ** "
		   BYTE "**   ** "
		   BYTE "**   ** "
		   BYTE " *****  "
		   BYTE "   **   "
		   BYTE "  **    "
		   BYTE " **     "
	BitStrs BYTE 8 dup(?)
	
.code

change PROC
	push eax
	push ecx			; let loop time outside the function can be save
	mov ecx, 8			; the loop time for each character in line 
L2:					
	cmp ChStrs[esi], 42	; check if it is * or not
	je L4
L3:
	mov al, '0'			; output a 0 if it is not a *
	call WriteChar
	jmp L5
L4:
	mov al, '1'			; otherwise it will print a 1
	call WriteChar
L5: 
	inc esi				; move to next position in the array
	loop L2				; do this process 8 times
	pop eax
	pop ecx				; take ecx back
	ret
change ENDP


main PROC
	xor eax, eax		; eax = 0
	mov esi, 0			; let the position of array to be 0
	mov ecx, 8			; set loop time 8 times
L1:
	call change
	call Crlf			; jump to next line 
	loop L1

	exit
main ENDP
END main