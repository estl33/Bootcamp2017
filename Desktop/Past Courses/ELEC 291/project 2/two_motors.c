//  square.c: Uses timer 2 interrupt to generate a square wave in pin
//  P2.3 and a 75% duty cycle wave in pin P2.4
//  Copyright (c) 2010-2015 Jesus Calvino-Fraga
//  ~C51~

#include <C8051F38x.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#define SYSCLK    48000000L // SYSCLK frequency in Hz
#define BAUDRATE  115200L   // Baud rate of UART in bps
//#define BAUDRATE  19200L //110

#define OUT0 P2_3
#define OUT1 P2_4
#define OUT2 P2_5
#define OUT3 P2_6
#define dataPin P0_3
//#define fieldPinLeft P1_5
//#define fieldPinRight P1_6
//#define turnLPin P1_0
//#define turnSPin P2_6
//#define turnRPin P1_1


volatile unsigned char pwm_count=0;
volatile int percentage0;
volatile int percentage1;
volatile int percentage2;
volatile int percentage3;
volatile int swap;
volatile int data_received;
volatile unsigned int fieldLeft;
volatile unsigned int fieldRight;
volatile unsigned int fieldMiddle;

	int x=15;
	int y=15;
	char Key;
	char str_0 [8] = {'  '};
	char str_1 [8] = {'  '};
/////////////////////////////////////////////
char _c51_external_startup (void)
{
	PCA0MD&=(~0x40) ;    // DISABLE WDT: clear Watchdog Enable bit
	VDM0CN=0x80; // enable VDD monitor
	RSTSRC=0x02|0x04; // Enable reset on missing clock detector and VDD

	// CLKSEL&=0b_1111_1000; // Not needed because CLKSEL==0 after reset
	#if (SYSCLK == 12000000L)
		//CLKSEL|=0b_0000_0000;  // SYSCLK derived from the Internal High-Frequency Oscillator / 4 
	#elif (SYSCLK == 24000000L)
		CLKSEL|=0b_0000_0010; // SYSCLK derived from the Internal High-Frequency Oscillator / 2.
	#elif (SYSCLK == 48000000L)
		CLKSEL|=0b_0000_0011; // SYSCLK derived from the Internal High-Frequency Oscillator / 1.
	#else
		#error SYSCLK must be either 12000000L, 24000000L, or 48000000L
	#endif
	OSCICN |= 0x03; // Configure internal oscillator for its maximum frequency

	// Configure UART0
	SCON0 = 0x10; 
#if (SYSCLK/BAUDRATE/2L/256L < 1)
	TH1 = 0x10000-((SYSCLK/BAUDRATE)/2L);
	CKCON &= ~0x0B;                  // T1M = 1; SCA1:0 = xx
	CKCON |=  0x08;
#elif (SYSCLK/BAUDRATE/2L/256L < 4)
	TH1 = 0x10000-(SYSCLK/BAUDRATE/2L/4L);
	CKCON &= ~0x0B; // T1M = 0; SCA1:0 = 01                  
	CKCON |=  0x01;
#elif (SYSCLK/BAUDRATE/2L/256L < 12)
	TH1 = 0x10000-(SYSCLK/BAUDRATE/2L/12L);
	CKCON &= ~0x0B; // T1M = 0; SCA1:0 = 00
#else
	TH1 = 0x10000-(SYSCLK/BAUDRATE/2/48);
	CKCON &= ~0x0B; // T1M = 0; SCA1:0 = 10
	CKCON |=  0x02;
#endif
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit autoreload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready
	
	// Configure the pins used for square output
	P2MDOUT|=0b_0000_0011;
	P0MDOUT |= 0x10; // Enable UTX as push-pull output
	XBR0     = 0x01; // Enable UART on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0x40; // Enable crossbar and weak pull-ups

	// Initialize timer 2 for periodic interrupts
	TMR2CN=0x00;   // Stop Timer2; Clear TF2;
	CKCON|=0b_0001_0000;
	TMR2RL=(-(SYSCLK/(2*48))/(100L)); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // Enable Timer2 interrupts
	TR2=1;         // Start Timer2

	EA=1; // Enable interrupts
	
	return 0;
}
/////-----UART-----/////
//F38x UART (comment out when compiling)
void UART1_Init (unsigned long baudrate)
{
SMOD1 = 0x0C; // no parity, 8 data bits, 1 stop bit
SCON1 = 0x10;
if (((SYSCLK/baudrate)/2L)/0xFFFFL < 1){
SBRL1 = 0x10000L-((SYSCLK/baudrate)/2L);
SBCON1 |= 0x03; // set prescaler to 1
}
else if (((SYSCLK/baudrate)/2L)/0xFFFFL < 4){
SBRL1 = 0x10000L-(((SYSCLK/baudrate)/2L)/4L);
SBCON1 &= ~0x03;
SBCON1 |= 0x01; // set prescaler to 4
}
else if (((SYSCLK/baudrate)/2L)/0xFFFFL < 12){
SBRL1 = 0x10000L-(((SYSCLK/baudrate)/2L)/12L);
SBCON1 &= ~0x03; // set prescaler to 12
}
else{
SBRL1 = 0x10000L-(((SYSCLK/baudrate)/2L)/48L);
SBCON1 &= ~0x03;
SBCON1 |= 0x02; // set prescaler to ?
}
SCON1 |= 0x02; // indicate ready for TX
SBCON1 |= 0x40; // enable baud rate generator
}
void putchar1 (char c)
{
if (c == '\n' )
{
while (!(SCON1 & 0x02));
SCON1 &= ~0x02;
SBUF1 = '\r' ;
}
while (!(SCON1 & 0x02));
SCON1 &= ~0x02;
SBUF1 = c;
}
char getchar1 (void)
{
char c;
while (!(SCON1 & 0x01));
SCON1 &= ~0x01;
c = SBUF1;
return (c);
}
/////////////
/////--------ADC---------/////
void InitADC (void)
{
	// Init ADC
	ADC0CF = 0xF8; // SAR clock = 31, Right-justified result
	ADC0CN = 0b_1000_0000; // AD0EN=1, AD0TM=0
  	REF0CN = 0b_0000_1000; //Select VDD as the voltage reference for the converter
}

void InitPinADC (unsigned char portno, unsigned char pinno)
{
	unsigned char mask;
	
	mask=1<<pinno;
	
	switch (portno)
	{
		case 0:
			P0MDIN &= (~mask); // Set pin as analog input
			P0SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 1:
			P1MDIN &= (~mask); // Set pin as analog input
			P1SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 2:
			P2MDIN &= (~mask); // Set pin as analog input
			P2SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 3:
			P3MDIN &= (~mask); // Set pin as analog input
			P3SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		default:
		break;
	}
}

unsigned int ADC_at_Pin(unsigned char pin)
{
	AMX0P = pin;             // Select positive input from pin
	AMX0N = LQFP32_MUX_GND;  // GND is negative input (Single-ended Mode)
	// Dummy conversion first to select new pin
	AD0BUSY=1;
	while (AD0BUSY); // Wait for dummy conversion to finish
	// Convert voltage at the pin
	AD0BUSY = 1;
	while (AD0BUSY); // Wait for conversion to complete
	return (ADC0L+(ADC0H*0x100));
}

float Volts_at_Pin(unsigned char pin)
{
	 return ((ADC_at_Pin(pin)*3.30)/1024.0);
}

unsigned int Get_ADC (void)
{
AD0BUSY = 1;
while (AD0BUSY); // Wait for conversion to complete
return ( ADC0L + ( ADC0H * 0x100 ) );
}
void Timer2_ISR (void) interrupt 5 using 1
{
	TF2H = 0; // Clear Timer2 interrupt flag
	 
	pwm_count++;
	if(pwm_count>100) pwm_count=0;
	
	OUT0=pwm_count>percentage0?0:1;
	OUT1=pwm_count>percentage1?0:1;
	OUT2=pwm_count>percentage2?0:1;
	OUT3=pwm_count>percentage3?0:1;
	
}

char getchar(void)
{
	//if (!RI) return 0;
	if(SBUF=='\n')
	{
		while (!RI);
		RI=0;
		return SBUF;
	}
	while (!RI);
	RI=0;
	return SBUF;
}


int pow_10(int index){
	if(index==0) return 1;
	if(index==1) return 10;
	if(index==2) return 100;
	else return 0;
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON:
	CKCON|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN & 0x80));  // Wait for overflow
		TMR3CN &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	for(j=ms; j!=0; j--)
	{
		Timer3us(249);
		Timer3us(249);
		Timer3us(249);
		Timer3us(250);
	}
}

void speed(int percent, int motor, int backward)
{
	//change left motor speed
	if(motor == 0)
	{
		percentage0 = 0;
		percentage1 = percent;
	}
	//change right motor speed
	else if(motor == 1)
	{
		percentage2 = 0;
		percentage3 = percent;
	}
	//change both motor speed
	else
	{
		if(!backward)
		{
			percentage0 = 0;
			percentage1 = percent;
			percentage2 = 0;
			percentage3 = percent;
		}
		else
		{
			percentage0 = percent;
			percentage1 = 0;
			percentage2 = percent;
			percentage3 = 0;
	}
}
}

void stop(void)
{
	//make both motors stop
	speed(0,2,0);
}

void turnRight(void)
{
	//make left motor turn faster
	speed(90,1,0);
	//stop right motor 
	speed(0,0,0);
}

void turnLeft(void)
{
	//make right motor turn faster
	speed(90,0,0);
	//stop left motor 
	speed(0,1,0);
}

void forward(void)
{
	//set both motors to eqaul default speed
	speed(90,2,0);
}

void backward(void)
{
	//set both motors to eqaul default speed and reverse direction
	speed(90,2,1);
}

void rotate180(void)
{
	//equivalent to turn left or turn right
	turnRight();
	waitms(250);
	waitms(250);
	stop();
}

void switchDirection(void)
{
	int	swap;
	swap = percentage0;
	percentage0 = percentage1;
	percentage1 = swap;
	
	swap = percentage2;
	percentage2 = percentage3;
	percentage3 = swap; 
}
/////--------LCD---------/////

#define LCD_RS P2_2
#define LCD_RW P2_1 // Not used in this code
#define LCD_E  P2_0	
#define LCD_D4 P1_3
#define LCD_D5 P1_2
#define LCD_D6 P1_1
#define LCD_D7 P1_0
#define CHARS_PER_LINE 16
void LCD_pulse (void)
{
	LCD_E=1;
	Timer3us(40);
	LCD_E=0;
}

void LCD_byte (unsigned char x)
{
	// The accumulator in the C8051Fxxx is bit addressable!
	ACC=x; //Send high nible
	LCD_D7=ACC_7;
	LCD_D6=ACC_6;
	LCD_D5=ACC_5;
	LCD_D4=ACC_4;
	LCD_pulse();
	Timer3us(40);
	ACC=x; //Send low nible
	LCD_D7=ACC_3;
	LCD_D6=ACC_2;
	LCD_D5=ACC_1;
	LCD_D4=ACC_0;
	LCD_pulse();
}

void WriteData (unsigned char x)
{
	LCD_RS=1;
	LCD_byte(x);
	waitms(2);
}

void WriteCommand (unsigned char x)
{
	LCD_RS=0;
	LCD_byte(x);
	waitms(5);
}

void LCD_4BIT (void)
{
	LCD_E=0; // Resting state of LCD's enable is zero
	LCD_RW=0; // We are only writing to the LCD in this program
	waitms(20);
	// First make sure the LCD is in 8-bit mode and then change to 4-bit mode
	WriteCommand(0x33);
	WriteCommand(0x33);
	WriteCommand(0x32); // Change to 4-bit mode

	// Configure the LCD
	WriteCommand(0x28);
	WriteCommand(0x0c);
	WriteCommand(0x01); // Clear screen command (takes some time)
	waitms(20); // Wait for clear screen command to finsih.
}

void LCDprint(char * string, unsigned char line, bit clear)
{
	int j;

	WriteCommand(line==2?0xc0:0x80);
	waitms(5);
	for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}


/////////////////
#define KEY_UP 		1
#define KEY_RIGHT 	2
#define KEY_DOWN 	3
#define KEY_LEFT 	4
#define KEY_ADC 	5
#define TEXT_POS (15*2+2)
#define GOTO_YX "\x1B[%d;%dH"	

char getKey(void)
{
	if(!RI) return 0;
	
	RI=0;
	switch(toupper(SBUF))
	{
		case 'E': return KEY_UP;
		case 'F': return KEY_RIGHT;
		case ' ': return KEY_ADC;
		case 'D': return KEY_DOWN;
		case 'S': return KEY_LEFT;
		case 'P':
			while(!RI);
			RI=0;
		default:
		break;
	}
	return 0;
}


void main (void)
{
	int backwardsFlag = 0;
	int taketurn = 1;
	unsigned int dataloopcount = 300;
	unsigned int numPulse = 0;
	int logic;
	char mode;
	
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("Square wave generator for the F38x.\r\n"
	       "Check pins P2.3 and P2.4 with the oscilloscope.\r\n");

	percentage0 = 0;
	percentage1 = 0;
	percentage2 = 0;
	percentage3 = 0;

	// Configure the pins we want to use as analog inputs
	InitPinADC(2, 1); // left
	InitPinADC(2, 0); // right
	InitPinADC(1, 7); //middle
	InitPinADC(1, 5); // data
	// Initialize the ADC
	UART1_Init(BAUDRATE);
	InitADC();	
	LCD_4BIT();
	LCDprint("PWM F38x", 1, 1);
	
	//check mode using pushbuttons on avr 
	/*if(ADC_at_Pin(LQFP32_MUX_P1_5)>500){
	mode = 'm';
	}
	else if(ADC_at_Pin(LQFP32_MUX_P1_5)<50){
	mode = 't';
	}
	*/
	mode = 't';
	
	while(1)
	{
//	mode = 't';

///////////manual mode///////////////	
if(mode == 'm'){
//	dataloopcount = 50;
	
		//wait until field detected
	printf("Manual Mode\n\r");
	printf("adc : %d\r", ADC_at_Pin(LQFP32_MUX_P1_5));
//	while(ADC_at_Pin(LQFP32_MUX_P1_5)>100);	//wait until field is zero
	//wait until all fields are zero
	while(fieldLeft > 0 || fieldRight > 0 || fieldMiddle > 0){
	fieldLeft=ADC_at_Pin(LQFP32_MUX_P2_1); //Save ref peak voltage
	fieldRight=ADC_at_Pin(LQFP32_MUX_P2_0); //Save ref peak voltage
	fieldMiddle=ADC_at_Pin(LQFP32_MUX_P1_7); //Save ref peak voltage
	printf("ADC @ Left  %u    ADC @ Right  %u ADC @ Middle  %u \n\r", fieldLeft, fieldRight,fieldMiddle);
	}
	while(dataloopcount > 0){				//execute after stop bit
	if(ADC_at_Pin(LQFP32_MUX_P1_5)>200){
	logic = 1;
	}
	else{
	logic = 0;
	}
	numPulse += logic;
	printf("Number of pulses : %d\r", numPulse);
	waitms(30);
//	waitms(250);
//	waitms(250);
//	printf("Data received : %d\r", logic);
	dataloopcount --;
	}
	 if(numPulse < 5){ 
	 printf("                         Stop\r");
	 stop();
	 }
else if(numPulse < 50){ 
	 printf("               Go forward straight\r");
	 forward();
	 }
else if(numPulse < 150){
	 printf("                          Turn 180\r");
	 rotate180();
	 }
else if(numPulse < 250){
	 printf("                        Turn right\r");
	 turnRight();
	 }
else if(numPulse < 350){ 
	 printf("                         Turn Left\r");
	 turnLeft();
	 }
else if(numPulse < 400){ 
	 printf("              Go backward straight\r");
	 backward(); 
	 }
else if(numPulse < 500){ 
	 printf("           Entering backwards mode\r");
	 backwardsFlag == 1;
	 mode = 't'; 
	 }
	 
else { printf("                        Over 100\r"); }
	 waitms(250);
	 waitms(250);
	 waitms(250);
	 waitms(250);
	 waitms(250);
	 waitms(250);
	 waitms(250);
	 waitms(250);
	 mode = 't';
//	printf("Data received : %d \r", ADC_at_Pin(LQFP32_MUX_P1_5));
///	printf("Number of pulses : %d\r", numPulse);
}

///////////tracking mode////////////////	
if(mode == 't'){	
	
	fieldLeft=ADC_at_Pin(LQFP32_MUX_P2_1); //Save ref peak voltage
	fieldRight=ADC_at_Pin(LQFP32_MUX_P2_0); //Save ref peak voltage
	fieldMiddle=ADC_at_Pin(LQFP32_MUX_P1_7); //Save ref peak voltage
	printf("ADC @ Left  %u    ADC @ Right  %u ADC @ Middle  %u \n\r", fieldLeft, fieldRight,fieldMiddle);

//when no field
if((fieldRight < 5 && fieldLeft < 5 && fieldMiddle < 5)){
//	printf("stop\r");
	stop();
	mode = 'm'; //sets manual mode

}
else{
	//printf("forward\r");
	forward();
}

//d1 > d2
//field present on right inductor, turn right
if(taketurn){
	if((fieldLeft - fieldRight) > 50){
//		printf("turning left\r");
		turnLeft();
	}
	else if((fieldRight - fieldLeft) > 50){
		turnRight();
	}
}

else if(!taketurn){	
	if((fieldRight - fieldLeft) > 50){
//		printf("turning right\r");
		turnRight();
	}
	else if((fieldLeft - fieldRight) > 50){
//		printf("turning left\r");
		turnLeft();
	}
}

taketurn = !taketurn;
//fieldLeft > 600 && fieldRight > 600 &&
if(fieldLeft > 600 && fieldRight > 600 && fieldMiddle > 600){
	stop();
	mode = 'm'; //sets manual mode
}
/////check backwards flag///////
if(backwardsFlag){
	switchDirection();
}
}

//waitms(250);


}
}
