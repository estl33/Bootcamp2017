#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>


unsigned int cnt = 0;
volatile double msec1;
volatile double msec2;
volatile double duty_cycle;

void Wait(double msec)
{
 _delay_loop_2(msec);
 //_delay_ms(msec);

}

ISR(TIMER1_OVF_vect)
{
	cnt++;
	if(cnt>50000)
	{
		cnt=0;
		PORTB ^= 0x01;	// Toggle the LED connected to pin 14
		
		//DDRD |= (1<<5); //Toggle LED pin PD5
	}
}

/*ISR(TIMER1_OVF_vect)
{
		
		PORTB ^= 0x01;	// Toggle the LED connected to pin 14
		Wait();
		PORTB = 0x01;
		//DDRD |= (1<<5); //Toggle LED pin PD5
}*/

void freq(double dutycycle)
{
		//period = 63.70us = 0.0637ms
		//msec1=msec2=155
		//msec1+msec2=310
		//msec1 = 310*0.5
		//msec2 = 310*0.5
		
		duty_cycle = (double)dutycycle/100;
	
		msec1 = (80+(double)(80-duty_cycle))*(double)(1-duty_cycle);
		msec2 = (80+(double)(80-duty_cycle))*(duty_cycle);
		
		PORTB &= ~(0X01);
		Wait(msec1);
		PORTB |= (0x01);
		Wait(msec2);
		//DDRD |= (1<<5); //Toggle LED pin PD5
}



int main(void)
{
	// Set PORTB 0 pin as output, turn it off
	DDRB = 0x01;
	PORTB = 0x01;

	// Turn on timer with no prescaler on the clock for fastest

    // set up timer with prescaler = 1024
	// TCCR0 |= (1 << CS02)|(1 << CS00);
    
	// triggering of the interrupt service routine.
	TCCR1B |= _BV(CS10);
	TIMSK1 |= _BV(TOIE1);

	sei(); // Turn interrupts on.
	PORTB ^= 0x01;	// Toggle the LED connected to pin 14

	while (1)
	{
	freq(80.5);
	}
}

