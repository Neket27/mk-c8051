#include <C8051F120.h>

sbit LED = P1^6; 
sbit SW = P3^7;  

void Port_IO_Init() 
{
    P1MDOUT |= 0x40; 
    XBR2 |= 0x40;    
}

void main(void)
{
    PCA0MD &= ~0x40; 

    Port_IO_Init();  

    while(1)
    {
        LED = ~SW;    
    }
}
