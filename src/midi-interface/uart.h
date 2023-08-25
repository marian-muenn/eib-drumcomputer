#include <avr/io.h>
#define UART_BAUDRATE 31250UL
void uart_init();
void uart_putc(char);
void uart_puts(char *);
