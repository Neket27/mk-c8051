$NOMOD51 		
$include (C8051F000.inc)
LED BIT P1.6 ;Assigning the LED name to the address of bit 6 in register P1

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
	CLR LED; 
	
LOOP: 
	MOV R7, #03h;

LOOP1:
	MOV R6, #00h;
	
	
LOOP2: 			
	MOV R5, #00h; 
	djnz R5, $
	djnz R6, LOOP2
	djnz R7, LOOP1; 
	CPL LED; 
	SJMP LOOP;

END 
  
