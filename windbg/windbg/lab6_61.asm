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
	ninenine BYTE 81 DUP(?)
	
.code

nineTime PROC 
	push ecx						; save the time need to do
	mov ecx, 9						; do nine times for this row
	L2:
		inc bh						; the col
		mov al, bh					; al = the col
		mov dl, bl					; dl = the row
		mul dl						; al * dl
		mov ninenine[esi], al		; the product of al and dl must in the al
		inc esi						; move to next place
		loop L2		
	pop ecx							; take ecx back
	ret
		
nineTime ENDP

main PROC
	xor esi, esi
	mov ecx, 9						; nine col
	xor bx, bx	
L1:
	mov bh, 0						; set col to zero
	inc bl							; inc the row
	call nineTime
	loop L1
	

	exit
main ENDP
END main