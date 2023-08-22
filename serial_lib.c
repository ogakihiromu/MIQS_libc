#include "serial_lib.h"

#define UART_LITE_RXD_ADDR 0xFFFF0000  // Transmit reg address
#define UART_LITE_TXD_ADDR 0xFFFF0004  // Receive reg address
#define UART_LITE_STAT 0xFFFF0008 // serial module's tx and rx reg status reg address
#define UART_LITE_CTRL 0xFFFF000C // serial module's control address (don't care now)


#define UART_LITE_RXV (1<<0)    //b 1
#define UART_LITE_TXV (1<<1)    //b 10

//---tx-------------------- 
/////////////////////////
//*Uart_tx_enable
// This function informs whether the transmit register of the UART is full or not.
// If the register is full, return 1. Otherwise, return 0.
//
int Uart_tx_enable()
{
    volatile int *txd_stat = (int*)UART_LITE_STAT;
    return (*txd_stat & UART_LITE_TXV);
}
//////////////////////////
//*Uart_putChar
// This function sends an argument of type unsigned char via serial communication through UART.
//
void Uart_putChar(unsigned char val)
{
    volatile unsigned char *e_txd = (unsigned char*)UART_LITE_TXD_ADDR;
    while(Uart_tx_enable())
    ;
    *e_txd = val;
}

//void Uart_putStr(unsigned char *str)
//{
//    while(*str)
//        Uart_putChar(*(str++));
//}

//---rx----------------------
//////////////////////////
//*Uart_rx_enable
// This function informs whether the receive register of the UART is full or not.
// If the register is full, return 1. Otherwise, return 0.
//
int Uart_rx_enable()
{
    volatile int *rxd_stat = (int*)UART_LITE_STAT;
    return (*rxd_stat & UART_LITE_RXV);
}

//////////////////////////
//*Uart_rx_take
// This function assigns 2-byte character data received through the UART to the argument val of type unsigned char.
//
void Uart_rx_take(unsigned char val)
{
    volatile unsigned char *e_rxd = (unsigned char*) UART_LITE_RXD_ADDR;
    while(!Uart_rx_enable())
    ;
    val = *e_rxd;
}