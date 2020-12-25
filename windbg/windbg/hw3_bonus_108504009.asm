TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc

; Redefine external symbols for convenience
; Redifinition is necessary for using stdcall in .model directive 
; using "start" is because for linking to WinDbg.  added by Huang
 
CountMatches PROTO,
	firstArray: PTR SDWORD,
	secondArray: PTR SDWORD,
	arrayLength: DWORD

main          EQU start@0

.data
	Array1 SDWORD 2,  4, -3, -9, 7, 1, 8
	Array2 SDWORD 2, -3,  6,  0, 7, 8, 5
	string1 BYTE "+",0
	string2 BYTE " matches",0
	
.code
main PROC
	INVOKE CountMatches,
		OFFSET Array1,
		OFFSET Array2,
		LENGTHOF Array1
	
	call Crlf
	call WaitMsg
	
	exit
main ENDP

CountMatches PROC USES ebx ecx esi edx,
	firstArray:PTR SDWORD,
	secondArray:PTR SDWORD,
	arrayLength:DWORD
	
	xor eax, eax			; reset eax
	mov ecx, arrayLength	; set loop time
	mov esi, firstArray
L0:
	push ecx				; push ecx for the use of nested loop
	mov ecx, arrayLength	; for every number in firstArray need ($arrayLength) times check
	mov edi, secondArray
L1:
	mov ebx, [esi]
	mov edx, [edi]
	cmp ebx, edx
	jne L2
	inc eax
L2:
	add edi,TYPE secondArray
	loop L1
	add esi, TYPE firstArray
	pop ecx					; retake the ecx to know what times need to loop
	loop L0
	mov edx, OFFSET string1
	call WriteString
	call WriteDec
	mov edx, OFFSET string2
	call WriteString
	ret
CountMatches ENDP
	
END main