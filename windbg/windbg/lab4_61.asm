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
	myID BYTE "108504006"		
	size_ID = LENGTHOF myID		; ID's length
	myID2 BYTE "108504009"
	size_ID2 = LENGTHOF myID2
	
.code

Convert PROC USES eax			; Will not change eax after function
	;code detail
	L1:
		mov al, [esi]			; Save the number need to change now into al
		add al, 11h				; '0' + 11h = 'a', etc
		mov [esi], al			; Change the character in string
		inc esi					; Change to next place in string
		loop L1
	ret
	
Convert ENDP

Convert2 PROC 					; Will change everything change in function
	push eax					; Save the eax before function into stack
	L1:						
		mov al, [esi]
		add al, 11h
		mov [esi], al
		inc esi
		loop L1
	pop eax						; Take the eax back after finishing the function
	ret

Convert2 ENDP

main PROC
	mov eax, 9999h
	mov ebx, 9999h
	mov edx, 9999h
	mov esi, OFFSET myID		; esi point to the first place of myID
	mov ecx, size_ID			; Loop time is ID's length
	call Convert				; Call function Convert
	mov esi, OFFSET myID2
	mov ecx, size_ID2
	call Convert2
		
	exit
main ENDP
END main