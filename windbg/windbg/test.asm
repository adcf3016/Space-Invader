TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc
main EQU start@0
.data
Ex1Array sdword 105522063 , 108504006, 108504009
Ex2Array sdword -105522063 , -108504006 , -108504009
 
.code
main proc
	mov esi, OFFSET Ex1Array
	mov edi, OFFSET Ex1Array
	call DumpRegs
	call WaitMsg
    
main endp
 

end main
