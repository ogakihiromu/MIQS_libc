#include "serial_lib.h"

void main()
{
//    volatile unsigned char rx_start_flag;
//    Uart_rx_take(rx_start_flag);
//    while(rx_start_flag =! 'S'){        
//    }
    Uart_putChar('H');
    Uart_putChar('e');
    Uart_putChar('l');
    Uart_putChar('l');
    Uart_putChar('o');
    Uart_putChar('W');
    Uart_putChar('o');
    Uart_putChar('r');
    Uart_putChar('l');
    Uart_putChar('d');

}