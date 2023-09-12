#include <avr/io.h>
#define UART_BAUDRATE 31250UL
#define RX_COMPLETE_INTERRUPT (1 << RXCIE0)
void uart_init();
void uart_putc(char);
void uart_puts(char *);
