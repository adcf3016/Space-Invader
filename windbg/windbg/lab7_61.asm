TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

divide MACRO dividend, divisor, quotient, remainder
	mov dx, 0				; clear quotient
	mov cx, divisor			; get divisor
	div cx					; divided by cx
	mov quotient, ax		; get the quotient and remainder from register
	mov remainder, dx
ENDM


; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
main          EQU start@0

.data
	;some data
	dividend WORD 4006		
	divisor WORD 100
	quotient WORD 1 DUP(?)
	remainder WORD 1 DUP(?)

.code
main PROC
	movsx eax, dividend		; print leader student number
	call WriteDec
	call Crlf
	
	divide dividend, divisor, quotient, remainder	; call macro
	
	movsx eax, quotient		; print quotient
	call WriteDec
	call Crlf				; '\n'
	movsx eax, remainder	; print remainder
	call WriteDec
	call Crlf
	
	call WaitMsg

	;code detail

	exit
main ENDP
END main