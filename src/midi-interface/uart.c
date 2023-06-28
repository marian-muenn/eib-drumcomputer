#include "uart.h"
void uart_init(){
    unsigned int prescale = ((F_CPU / (9600 * 16UL))-1);
    // SET BAUD RATE
    // write to lower byte
    UBRR0L = (uint8_t)(prescale & 0xFF);
    // write to higher byte
    UBRR0H = (uint8_t)(prescale >> 8);
    // enable the transmitter and receiver
    UCSR0B |= (1 << RXEN0) | (1 << TXEN0);
    // Use 8-bit character sizes
    UCSR0C |= (1 << UCSZ00) | (1 << UCSZ01);      
}

void uart_putc(char c){
    // wait for transmit buffer to be empty
    while(!(UCSR0A & (1 << UDRE0)));
    // load data into transmit register
    UDR0 = c;
}

void uart_puts(char* s){
    while(*s){
        uart_putc(*s);
        s++;
    }
}
