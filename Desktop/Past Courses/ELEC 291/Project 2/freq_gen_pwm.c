/*int main(void)
{	
	DDRD |= (1 << DDD6);
	// PD6 is now an output
	
	OCR0A = 86;
	// adjust this to get the correct frequency
		
		
	TCCR0A |= (1 << COM0A0);
	// set normal port operation, OC0A disconnected
		
	TCCR0A |= (0 << WGM02) | (1 << WGM01) | (0 << WGM00);
	// set CTC Mode
		
	TCCR0B |= (1 << CS01);
	// set prescaler to 8 and starts PWM
	
	while(1)
	{		
	}
	return 0;
}*/

int main(void)
{
    OCR2A = 128;
    // set PWM for 50% duty cycle

    TCCR2A |= (1 << COM2A1);
    // set none-inverting mode

    TCCR2A |= (1 << WGM21) | (1 << WGM20);
    // set fast PWM Mode

    TCCR2B |= (1 << CS21);
    // set prescaler to 8 and starts PWM

    while (1);
    {
    	count = 30;
        // we have a working Fast PWM
        while(count>15){
        	DDRD = 0 << DDD6
        	count --;
        }
        while(count>0){
        	DDRD |= (1 << DDD6);
    		// PD6 is now an output
    		count --;
    	}
    }
}