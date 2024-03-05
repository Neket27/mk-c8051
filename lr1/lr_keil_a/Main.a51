$NOMOD51 		
$include (C8051F000.inc)
LED EQU P1.6 ;Assigning the LED name to the address of bit 6 in register P1
SW EQU P3.7 ; Assigning the SW name to the address of bit 7 in register P3
CSEG AT 0 
ljmp MAIN 

Reset_Sources_Init: ;disabling the watchdog timer
mov WDTCN, #0DEh; 
mov  WDTCN, #0ADh
ret	;return from a subroutine	

Port_IO_Init: 	;initialization of the I/O port
mov  PRT1CF, #040h 
mov  XBR2, #040h 
ret ;return from a subroutine

Init_Device:  ;calling the Init_Device subroutine
lcall Reset_Sources_Init
lcall Port_IO_Init
ret	;return from a subroutine

MAIN: 
	lcall Init_Device ; Initialization of the controller
LOOP: 			
	mov C, SW ;connecting the button to the LED
	cpl c     ;inversion of the SW bit when the button is pressed
	mov LED, C 	;switching the LED with the button
	ljmp LOOP  ;unconditional transition to the LOOP label
END 
  
