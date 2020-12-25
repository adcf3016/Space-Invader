INCLUDE Irvine32.inc
.data
BStr0 db 01111110b
BStr1 db 10000001b
BStr2 db 10100101b
BStr3 db 10000001b
BStr4 db 10100101b
BStr5 db 10111101b
BStr6 db 10000001b
BStr7 db 01111110b
CStr0 db 8 dup(?)
CStr1 db 8 dup(?)
CStr2 db 8 dup(?)
CStr3 db 8 dup(?)
CStr4 db 8 dup(?)
CStr5 db 8 dup(?)
CStr6 db 8 dup(?)
CStr7 db 8 dup(?)
.code
convertPattern PROC
; al = binary integer, esi pointer to buffer
    push ecx
    push esi
   
    mov ecx, 8             ; number of bits in AL
L1: shl al, 1              ; shift high bit into carry flag
    mov BYTE PTR[esi], ' ' ; choose ' ' as default output
    jnc L2                 ; if no Carry, jump L2
    mov BYTE PTR[esi], '' ; else move '' to buffer
L2: inc esi                ; next buffer position
    loop L1                ; shift another bit to left
   
    pop esi
    pop ecx
    ret
convertPattern ENDP

printResult PROC
; esi pointer to buffer, print[8][8]
    push ecx
    push esi
   
    mov ecx, 8            ; number of rows
L1: push ecx
    mov ecx, 8            ; number of column
L2: mov al, BYTE PTR[esi] ; move buffer to AL
    inc esi               ; next buffer position
    call WriteChar        ; print AL(ASCII)
    loop L2               ; next column
   
    call Crlf             ; print '\n'
    pop ecx
    loop L1               ; next row
   
    pop esi
    pop ecx
    ret
printResult ENDP

start PROC
    mov ebx, 0            ; BStr[ebx]
    mov ecx, 8            ; run BStr[0-7]
    mov esi, OFFSET CStr0 ; move buffer position to esi
L1: mov al, BStr0[ebx]    ; move byte BStr[ebx] to AL
    call convertPattern   ; convert bit pattern
    add esi, SIZEOF CStr0 ; next buffer position
    add ebx, SIZEOF BStr0 ; next convert byte
    loop L1
    mov esi, OFFSET CStr0 ; output
    call printResult
    call WaitMsg
    invoke ExitProcess, 0
start ENDP;
end start;