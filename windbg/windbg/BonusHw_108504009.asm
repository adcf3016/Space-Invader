TITLE Example of ASM 
INCLUDE Irvine32.inc

Str_nextWord PROTO,
	pString:PTR BYTE,
	delimiter:BYTE

main          EQU start@0
	
.data
testStr BYTE "ABC\DE\FGHIJK\LM",0

.code
main PROC
	call Clrscr
	mov edx, OFFSET testStr
	call WriteString
	call Crlf
	
	mov esi, OFFSET testStr
	
L1:
	INVOKE Str_nextWord, esi, "\"
	jnz Exit_prog
	mov esi, eax
	mov edx, eax
	call WriteString
	call Crlf
	jmp L1

Exit_prog:
	call WaitMsg
	exit
main ENDP

Str_nextWord PROC USES esi ebx ecx,
	pString: PTR BYTE,
	delimiter:BYTE
	
	mov eax, pString	; let eax point to pString
	mov bl, delimiter 	; let bl store delimiter
	mov bh, 0			; let bh store null
L2:
	cmp [eax], bh		; if current character is null, then exit and clear zero flag
	je L4				
	cmp [eax], bl		; if current character is delimiter, then exit and set zero flag
	je L3
	add eax, 1			; else move eax to next character and loop again
	loop L2				
	
L3:
	add eax, 1
	xor ecx, ecx		; set zero flag and exit
	jmp L5
	
L4:
	add ebx, 1			; clear zero flag
L5:
	ret
Str_nextWord ENDP
	
END main