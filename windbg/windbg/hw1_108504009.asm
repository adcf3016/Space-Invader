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
	MyID DWORD ?
	Digit0 BYTE 4	; Digit0 = 4
	Digit1 BYTE 0	; Digit1 = 0
	Digit2 BYTE 0	; Digit2 = 0
	Digit3 BYTE 9	; Digit3 = 9

.code
main PROC
	mov eax, 0		; eax = 0
	mov al, Digit1	; al = Digit1
	mov ah, Digit0	; ah = Digit0
	shl eax, 16		; eax shift to left 2Bytes
	mov al, Digit3	; al = Digit3
	mov ah, Digit2	; ah = Digit2
	mov MyID, eax	; MyID = eax
	exit
main ENDP
END main