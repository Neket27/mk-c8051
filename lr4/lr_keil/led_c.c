#include <C8051F120.h>
sbit LED = P1^6; // Declaration of LED bit variable
cnt = 10; // Interrupt counter
void Reset_Sources_Init() // Watchdog timer disable
{
    WDTCN     = 0xDE;
    WDTCN     = 0xAD;
}
void Timer_Init() // Timer initialization
{
    SFRPAGE   = TIMER01_PAGE;
    TMOD      = 0x01; // Sets timer to 16-bit mode
}
void Port_IO_Init() // Input/output port initialization
{
    SFRPAGE   = CONFIG_PAGE;
    P1MDOUT   = 0x40; // Configures P1.6 port as push-pull output
    XBR2      = 0x40;
}
void Interrupts_Init() // Interrupts initialization
{
    IE        = 0x82; // Enable global interrupts and interrupts from TF0
}
void Init_Device(void) // Device initialization
{
    Reset_Sources_Init();
    Port_IO_Init();
    Interrupts_Init();
    Timer_Init();
}
Timer_ISR(void) interrupt 1 // Interrupt handler
{
    TF0 = 0; // Clear interrupt flag
}
void main(void)
{
    Init_Device();
    LED = 0;
    TR0 = 1; // Turn on timer
    while (1)
    {
        PCON |= 0x1; // Idle mode switching
        cnt--; // Delay
        if (cnt == 0)
        {
            LED=~LED; // Toggle LED
            cnt = 10;
        }
    }
}
