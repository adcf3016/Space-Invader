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
	Array1 SDWORD 10,5,4,-6,2,11,12
	Array2 SDWORD 10,5,3,1,4,2,-6
	Array3 SDWORD 4,1,4,8,9,13,15
	string1 BYTE "+",0
	string2 BYTE " matches",0
	
.code
main PROC
	INVOKE CountMatches,
		OFFSET Array1,
		OFFSET Array2,
		LENGTHOF Array1
		
	call Crlf
	
	INVOKE CountMatches,
		OFFSET Array1,
		OFFSET Array3,
		LENGTHOF Array1
	
	call Crlf
	call WaitMsg
	
	exit
main ENDP

CountMatches PROC USES ebx ecx esi edx,	;when we end the function those register will not change
	firstArray:PTR SDWORD,
	secondArray:PTR SDWORD,
	arrayLength:DWORD
	
	xor eax, eax			; reset eax
	mov ecx, arrayLength	; set loop time
	mov esi, firstArray		; esi point to the firstArray
	mov edi, secondArray	; edi point to the secondArray
L1:
	mov ebx, [esi]			; get the value from esi and edi
	mov edx, [edi]
	cmp ebx, edx			; compare two value
	jne L2					; if they are not the same, then don't increase the count time
	inc eax					; the count time
L2:
	add esi,TYPE firstArray	; esi and edi point to next point
	add edi,TYPE secondArray
	loop L1					; loop until the string end
	mov edx, OFFSET string1	; print the string and number in the window
	call WriteString
	call WriteDec
	mov edx, OFFSET string2
	call WriteString
	ret						; when return eax will be change unlike other register in the procedure
CountMatches ENDP
	
END main