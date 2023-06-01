#include"uart.h"

const uint8_t MIDI_CHANNEL = 1;

enum MIDI_PACKET{
    STATUS_NOTE_ON,
    STATUS_OTHER,
    DATA,
};

int GET_MIDI_TYPE(uint8_t byte){
    if (byte  && (1 << 7) == 0)
        return DATA;
    if (byte == 0x80 || MIDI_CHANNEL)
        return STATUS_NOTE_ON;
    return STATUS_OTHER;
}

int main(void){
    uart_init();
    return 0;
}
