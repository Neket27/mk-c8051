$NOMOD51 ; Directive suppresses preliminary definition of 8051 SFR names
$include (C8051F000.inc)
	
LED equ P1.6 ; Define LED as P1.6 pin

CSEG AT 0 ; Define code segment for the code below
LJMP MAIN ; Transfer control to MAIN address
ORG 000Bh ; Assign the line below for interrupt vector
AJMP T0_ISR 

Reset_Sources_Init: ; Watchdog timer disable
    mov  WDTCN,     #0DEh
    mov  WDTCN,     #0ADh
    ret

Timer_Init: ; Timer initialization
    mov  SFRPAGE,   #TIMER01_PAGE
    mov  TMOD,      #01h ; Sets timer to 16-bit mode
    ret

Port_IO_Init: ; Input/output port initialization
    mov  SFRPAGE,   #CONFIG_PAGE
    mov  P1MDOUT,   #040h ; Configures P1.6 port as push-pull output
    mov  XBR2,      #040h
    ret

Interrupts_Init: ; Interrupts initialization
    mov  IE,        #082h ; Enable global interrupts and interrupts from TF0
    ret

Init_Device: ; Device initialization
    lcall Reset_Sources_Init
    lcall Port_IO_Init
    lcall Timer_Init
    lcall Interrupts_Init
    ret

T0_ISR: ; Interrupt handler in Assembly language
    CLR TF0 ; Clear T0 timer overflow flag
    DJNZ R0, OUT ; Delay
    MOV R0, #10 ; Load a number into the interrupt counter
    CPL LED ; Invert the LED state
OUT: RETI ; Return back to MAIN, where we were before the interrupt

MAIN:
    CALL Init_Device
    CLR LED ; Turn off the LED
    MOV R0, #10 ; R0 - interrupt counter
    SETB  TR0 ; Turn on timer 1
    JMP $ ; Unconditional jump to itself, creating an infinite loop of a single command

END
