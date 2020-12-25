TITLE Example of ASM                (asmExample.ASM)

; This program locates the cursor and displays the
; system time. It uses two Win32 API structures.
; Last update: 6/30/2005

INCLUDE Irvine32.inc
main EQU start@0
.stack 4096
ExitProcess proto,dwExitCode:dword							; define the prototype of the functions
FindLargest proto aPtr:PTR SDWORD, arraySize: DWORD
.data
Ex1Array sdword 105522063 , 108504006, 108504009
Ex2Array sdword -105522063 , -108504006 , -108504009
 
.code
main proc
    invoke FindLargest, OFFSET Ex1Array, LENGTHOF Ex1Array	; invoke the function with parameter
    invoke FindLargest, OFFSET Ex2Array, LENGTHOF Ex2Array	
   
    call WaitMsg
    invoke ExitProcess,0
main endp
 
FindLargest proc,
    aPtr:PTR SDWORD, arraySize:DWORD						; the parameter of the function
    push esi												; save esi and ecx
    push ecx
    mov  eax, 80000000h  									; smallest possible 32bit signed integer
    mov  esi,aPtr     										; point to the first element
    mov  ecx,arraySize    										; set iteration times
L1: cmp [esi], eax     										; compare the current value and current maximum
    jl  L2          										; if smaller than max,jump to L2
    mov  eax,[esi]   										; update max value
 
L2: add  esi,4       
    loop L1
   
    call WriteInt											; print the max number of the array and go to next line
    call Crlf
   
    pop ecx													; retake them
    pop esi				
    ret                										; Return from subroutine
FindLargest endp
 
end main
