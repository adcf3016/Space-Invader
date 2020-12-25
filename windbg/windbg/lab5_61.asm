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
	myID byte "108504006"
    myID2 byte "108504009"
    size_ID = LENGTHOF myID
    result byte 9 DUP(?)

.code
main PROC
    mov ecx, size_ID			; set loop time
    xor esi, esi				; set esi = 0
	
	L1:
		mov al, myID[esi]		; get myID's number
		mov bl, myID2[esi]		; get myID2's number
		cmp al, bl				; compare al and bl
		je L2					; jump L2 if equal
		ja L3					; jump L3 if above
		jb L4					; jump L4 if blow
	
	L2:
		mov result[esi], "A"	; set result of now number
		jmp L5					; jump to the end of loop
	
	L3:
		mov result[esi], "B"
		jmp L5
		
	L4:
		mov result[esi], "C"
		
	L5:
		inc esi					; move to next place
		loop L1					; loop L1 for 9 times
		

	;code detail

	exit
main ENDP
END main