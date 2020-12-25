

INCLUDE Irvine32.inc
main	EQU start@0
BoxWidth = 5
BoxHeight = 5
 
.data
boxTop    BYTE 0DAh, (BoxWidth - 2) DUP(0C4h), 0BFh
boxBody   BYTE 0B3h, (BoxWidth - 2) DUP(' '), 0B3h
boxBottom BYTE 0C0h, (BoxWidth - 2) DUP(0C4h), 0D9h
 
outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD ($ - boxTop)
xyPosition COORD <10,5>
 
cellsWritten DWORD ?

attributes0 WORD BoxWidth DUP(0Ch)
attributes1 WORD (BoxWidth-1) DUP(0Eh),0Ah
attributes2 WORD BoxWidth DUP(0Bh)
          
 
.code
main PROC
 
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE ; Get the console ouput handle
    mov outputHandle, eax ; save console handle
    call Clrscr
    ; 畫出box的第一行
 
    INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes0,
      LENGTHOF boxTop,
      xyPosition,
      ADDR cellsWritten

   INVOKE WriteConsoleOutputCharacter,
       outputHandle,   ; console output handle
       ADDR boxTop,   ; pointer to the top box line
       LENGTHOF boxTop,   ; size of box line
       xyPosition,   ; coordinates of first char
       ADDR cellsWritten    ; output count
 
    inc xyPosition.y   ; 座標換到下一行位置
 
    mov ecx, (BoxHeight-2)    ; number of lines in body
 
   
 
L1: push ecx  ; save counter 避免invoke 有使用到這個暫存器
    INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes1,
      LENGTHOF boxBody,
      xyPosition,
      ADDR cellsWritten

	INVOKE WriteConsoleOutputCharacter,
       outputHandle,  
       ADDR boxBody,   
       LENGTHOF boxBody,   
       xyPosition,   
       ADDR cellsWritten    
 
    inc xyPosition.y   ; next line
    pop ecx   ; restore counter
    loop L1
 
    INVOKE WriteConsoleOutputAttribute,
      outputHandle,
      ADDR attributes2,
      LENGTHOF boxBottom,   ; pointer to the box body
      xyPosition,
      ADDR cellsWritten
 
    ; draw bottom of the box
   INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR boxBottom,   ; pointer to the bottom of the box
       LENGTHOF boxBottom,
       xyPosition,
	   ADDR cellsWritten
 
    call WaitMsg
    call Clrscr
    exit
main ENDP
END main
