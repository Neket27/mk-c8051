#include <C8051F120.h>

sbit LED = P1^6; 
cnt = 10; //interrupt counter

void Reset_Sources_Init()//disabling the watchdog timer
{
    WDTCN     = 0xDE;
    WDTCN     = 0xAD;
}


void Timer_Init() //configuring I/O ports
{
    SFRPAGE   = TIMER01_PAGE;
    TMOD      = 0x01; //Sets the timer to 16-bit mode
}



void Port_IO_Init() 
{
		SFRPAGE |= CONFIG_PAGE;
    P1MDOUT |= 0x40;  
    XBR2    |= 0x40;  
}

void Interrupts_Init() // initializing interrupts
{
	IE= 0x82;// Enabling general interrupts and interrupts from TF0 installation
}  

void Init_Device(void) //device initialization
{
    Reset_Sources_Init();
    Port_IO_Init();
    Interrupts_Init();
		Timer_Init();
}

Timer_ISR(void) interrupt 1 //interrupt handler
{
    TF0 = 0; //clearing the interrupt flag
	  cnt --; //delay
	  if (cnt == 0)
	  {
				cnt = 10;
				LED =~ LED; //swith led
	  }
}




void main(void)
{
    Init_Device();
		TR0 = 1; // On timer

    while(1){ }
}
