#define UART_LITE_TXD_ADDR 0xFFFF0000  // Transmit reg address
#define UART_LITE_RXD_ADDR 0xFFFF0001  // Receive reg address
#define UART_LITE_STAT 0xFFFF0002 // serial module's tx and rx reg status reg address
#define UART_LITE_CTRL 0xFFFF0003 // serial module's control address (don't care now)


#define UART_LITE_RXV (1<<0)    //b 1
#define UART_LITE_RXF (1<<1)    //b 10
#define UART_LITE_TXE (1<<2)    //b 100
#define UART_LITE_TXF (1<<3)    //b 1000
#define UART_LITE_IE (1<<4)     //b 10000
#define UART_LITE_OE (1<<5)     //b 100000
#define UART_LITE_FE (1<<6)     //b 1000000
#define UART_LITE_PE (1<<7)     //b 10000000

/////////////////////////
//*serial_tx_reg_check
// This function informs whether the transmit register of the UART is full or not.
// If the register is full, return 1. Otherwise, return 0.
//
int Uart_tx_enable()
{
    volatile int *txd_stat = (int*) UART_LITE_STAT;
    return (*txd_stat & UART_LITE_TXF);
}

void Uart_putChar(unsigned char val)
{
    volatile unsigned char *e_txd = (unsigned char*) UART_LITE_TXD_ADDR;
    while(!Uart_tx_enable())
        ;
    *e_txd = val;
}

void Uart_putStr(unsigned char *str)
{
    while(*str)
        Uart_putChar(*(str++));
}