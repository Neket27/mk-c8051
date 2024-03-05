#include <C8051F120.h>

sbit LED = P1^6; 
sbit SW = P3^7;  

unsigned long i=0; //delay counter
void Reset_Sources_Init()//disabling the watchdog timer
{
    WDTCN     = 0xDE;
    WDTCN     = 0xAD;
}
void Port_IO_Init() //configuring I/O ports
{
    SFRPAGE   = CONFIG_PAGE; //go to the configuration page
    P1MDOUT   = 0x40; 
    XBR2      = 0x40;
}
void Init_Device(void) // device initialization
{
    Reset_Sources_Init();
    Port_IO_Init();
}
void main(void) {
	Init_Device();
	LED = 0; //Clearing the state of the diode
	while(1){// This loop creates a delay.
		i++; // Incrementing the delay variable
		if (i == 195075) { // If the variable is 195075, then clear
			i = 0; // Reset it to zero
			LED = ~LED;// Invert the state of the diode
			}
		}
	}

