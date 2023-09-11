#include "uart.h"
#include <avr/common.h>
#include <stdint.h>
#include <util/atomic.h>
#include <util/delay.h>

// enums
// enum for the state machine
typedef enum e_sm_state {
  RECV_STATUS_CODE,
  RECV_NOTE_DATA,
  RECV_VELOCITY_DATA
} sm_state;

// enum for possible types of midi packages
typedef enum e_midi_packet_type {
  STATUS_NOTE_ON,
  STATUS_OTHER,
  DATA,
  HEARTBEAT
} midi_packet_type;

// structs
// structure to store a note on message
typedef struct s_midi_note_on_message {
  char note;
  char velocity;
} midi_note_on_message;

// global vars
volatile uint16_t outputs_now;
volatile uint16_t outputs_next;

// functions
// returns the midi packet type of a message
midi_packet_type get_midi_packet_type(uint8_t data) {
  if (data == 0x01)
    return HEARTBEAT;
  if (data <= 0x7f)
    return DATA;
  if (data >= 0x80 && data < 0x90)
    return STATUS_NOTE_ON;
  return STATUS_OTHER;
}
void update_scheduler(midi_note_on_message message) {
  // first output is mapped to c3 at midi note code 60
  uint16_t output = message.note - 60;
  if (output <= 11 && output >= 0) {
    outputs_next |= 0x1 << output;
  }
}

// Fetches new byte from uart
uint8_t get_midi_message() {
  uint8_t buffer = UDR0;
  return buffer;
}

// handles a new midi message
void handle_midi_message() {
  static sm_state state;
  static midi_note_on_message new_note_on_message;
  uint8_t data = get_midi_message();
  midi_packet_type midi_type = get_midi_packet_type(data);
  // midi state machine
  switch (state) {
  case RECV_STATUS_CODE:
    if (midi_type == STATUS_NOTE_ON)
      state = RECV_NOTE_DATA;
    break;

  case RECV_NOTE_DATA:
    if (midi_type == DATA) {
      new_note_on_message.note = data;
      state = RECV_VELOCITY_DATA;
    }
    if (midi_type == STATUS_OTHER)
      state = RECV_STATUS_CODE;
    break;

  case RECV_VELOCITY_DATA:
    if (midi_type == DATA) {
      new_note_on_message.velocity = data;
      update_scheduler(new_note_on_message);
      state = RECV_NOTE_DATA;
    }
    if (midi_type == STATUS_NOTE_ON)
      state = RECV_NOTE_DATA;
    if (midi_type == STATUS_OTHER)
      state = RECV_STATUS_CODE;
    break;
  }
}
void init_gpio() {
  // DDRB |= 0x00111111; // DOUT 8 to 13 are mapped to PORTB 0 to 6 => set them
  // as
  DDRB |= 0x00111111; // DOUT 8 to 13 are mapped to PORTB 0 to 6 => set them as
                      // output pins
  // DDRD |= 0x11111100; // DOUT 2 to 7 are mapped to PORTD 2 to 7  => set them
  // as
  DDRD |= 0x11111100; // DOUT 2 to 7 are mapped to PORTD 2 to 7  => set them as
  _delay_ms(10);
  PORTB = 0x00000000;
  // set all outputs to 0, set PD0 to tri state
  PORTD = 0x00000001;
  _delay_ms(10);
}
void set_outputs() {
  // Clear all output Pins
  PORTB &= 0b11000000;
  PORTD &= 0b00000011;

  // set ouput pins as needed
  if (outputs_now & (0x1 << 0)) {
    // OUPUT 1 mapped to Port D Pin 5
    PORTD |= (0x1 << 5);
  }
  if (outputs_now & (0x1 << 1)) {
    // OUPUT 2 mapped to Port D Pin 4
    PORTD |= (0x1 << 4);
  }
  if (outputs_now & (0x1 << 2)) {
    // OUPUT 3 mapped to Port D Pin 3
    PORTD |= (0x1 << 3);
  }
  if (outputs_now & (0x1 << 3)) {
    // OUPUT 4 mapped to Port D Pin 2
    PORTD |= (0x1 << 2);
  }
  if (outputs_now & (0x1 << 4)) {
    // OUPUT 5 mapped to Port B Pin 1
    PORTB |= (0x1 << 1);
  }
  if (outputs_now & (0x1 << 5)) {
    // OUPUT 6 mapped to Port B Pin 0
    PORTB |= (0x1 << 0);
  }
  if (outputs_now & (0x1 << 6)) {
    // OUPUT 7 mapped to Port D Pin 7
    PORTD |= (0x1 << 7);
  }
  if (outputs_now & (0x1 << 7)) {
    // OUPUT 8 mapped to Port D Pin 6
    PORTD |= (0x1 << 6);
  }
  if (outputs_now & (0x1 << 8)) {
    // OUPUT 9 mapped to Port B Pin 5
    PORTB |= (0x1 << 5);
  }
  if (outputs_now & (0x1 << 9)) {
    // OUPUT 10 mapped to Port B Pin 4
    PORTB |= (0x1 << 4);
  }
  if (outputs_now & (0x1 << 10)) {
    // OUPUT 12 mapped to Port B Pin 3
    PORTB |= (0x1 << 3);
  }
  if (outputs_now & (0x1 << 11)) {
    // OUPUT 12 mapped to Port B Pin 2
    PORTB |= (0x1 << 2);
  }
}

// Interrupt for received Package -> call handle_midi_message
// ISR(USART_RX_vect) { handle_midi_message(); }
ISR(USART_RX_vect) {
  static volatile char led = 0x0;
  if (led) {
    led = 0;
    PORTB |= 0b00100000;
  } else {
    led = 1;
    PORTB &= ~0b00100000;
  }
}
int main(void) {
  init_gpio();
  uart_init();
  // enable global interrupts
  SREG |= (1 << 7);
  while (1) {
    // wait for one ms, then update all outputs
    //
    _delay_ms(500);
    // use atomic block so that we dont have an interrupt messing up our output
    // configuration
    // ATOMIC_BLOCK(ATOMIC_FORCEON) {
    //  outputs_now = outputs_next;
    //  outputs_next = 0x0;
    // // set_outputs();
    //}
  }
  return 0;
}
