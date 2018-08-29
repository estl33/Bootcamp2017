//  C8051F381_ADC_any_pins.c: Shows how to use ADC with arbitrary pins.
//  Not as efficient as 'C851F381_ADC_multiple_inputs.c', but easier to
//  use and modify.  If you are testing this program using a potentiometer
//  to achieve a variable voltage, remember to use one with low resistance,
//  otherwise the track & hold will charge to an incorrect voltage.  A 1k
//  potentiometer seems to work fine, while a 10k potentiometer doesn't
//  work as well. 
//
//  2010-2016 Jesus Calvino-Fraga
//  ~C51~

#include <C8051F38x.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>

#define SYSCLK    48000000L // SYSCLK frequency in Hz
#define BAUDRATE  115200L   // Baud rate of UART in bps

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
	
	// Configure the pins used for motor control and communication
	P0MDOUT |= 0x01;  // set P0.0 and P0.4 as push-pull outputs
	XBR0 = 0x01;      // Enable UART0 on P0.4(TX0) and P0.5(RX0)
	XBR1 = 0x40;      // enable crossbar

	return 0;
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

/////--------TIMER0---------/////
unsigned char overflow_count;

void PORT_Init (void)
{
	P0MDOUT |= 0x10; // Enable UART TX as push-pull output
	XBR0=0b_0000_0001; // Enable UART on P0.4(TX) and P0.5(RX)                    
	XBR1=0b_0101_0000; // Enable crossbar.  Enable T0 input.
	XBR2=0b_0000_0000;
}

void SYSCLK_Init (void)
{
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
	OSCICN |= 0x03;   // Configure internal oscillator for its maximum frequency
	RSTSRC  = 0x04;   // Enable missing clock detector
}
 
void UART0_Init (void)
{
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
}

void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit counter
	TR0=0; // Stop Timer/Counter 0
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
		case 'W': return KEY_UP;
		case 'D': return KEY_RIGHT;
		case ' ': return KEY_ADC;
		case 'S': return KEY_DOWN;
		case 'A': return KEY_LEFT;
		case 'P':
			while(!RI);
			RI=0;
		default:
		break;
	}
	return 0;
}

#define test_sq P2_5
#define ref_sq P1_6
void main (void)
{
	char Key;
	int x = 10;
	int y = 10;
		
	volatile float V[2];		//peak voltage
	volatile float V_rms[2];	//voltage root means square
	double f;					//frequency
	float period;				//period
	double time_diff;			//time difference
	double ph_diff;				//phase difference
	char str_f[8] = {'       '};
	char str_0[8] = {'       '};
	char str_1[8] = {'       '};
	char str_ph[8]= {'       '};

	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("\r\nUsing ADC with arbitrary pins.\r\n");
	printf("\r\nOpen the door.\r\n");
		printf(GOTO_YX "(^_^)",8,8);
		printf(GOTO_YX "(^_^)",12,12);
		printf(GOTO_YX "(^_^)",16,16);
		printf(GOTO_YX "(^_^)",20,20);
		printf(GOTO_YX "(^_^)",24,24);
		printf(GOTO_YX " _____ ",12,50);
		printf(GOTO_YX "|     |",13,50);
		printf(GOTO_YX "|     |",14,50);
		printf(GOTO_YX "|    O|",15,50);
		printf(GOTO_YX "|     |",16,50);
		printf(GOTO_YX "|_____|",17,50);

	// Configure the pins we want to use as analog inputs
	InitPinADC(2, 6); // Configure P2.6 as analog input
	InitPinADC(1, 5); // Configure P1.5 as analog input
	// Initialize the ADC
	InitADC();
	// Initialize Timer0
	PCA0MD &= ~0x40; // WDTE = 0 (clear watchdog timer enable)
	PORT_Init();     // Initialize Port I/O
	SYSCLK_Init ();  // Initialize Oscillator
	UART0_Init();    // Initialize UART0
	TIMER0_Init();
	// Initialize LCD
	LCD_4BIT();
	while(1)
	{
		// Reset the timer
	//	TMOD&=0b_1111_0000;
	//	TMOD|=0b_0000_0001;
	//	TIMER0_Init();

		TL0=0;
		TH0=0;
		overflow_count=0;
		TF0=0;
		// Save the period of signal
		while (ref_sq==1); // Wait for ref signal to be zero
		while (ref_sq==0); // Wait for ref signal to be one
		TR0=1; // Start the timer 0
		while (ref_sq==1); // Wait for ref signal to be zero again
		while(ref_sq!=0) // Wait for the signal to be zero
		{
			if(TF0==1) // Did the 16-bit timer overflow?
			{
				TF0=0;
				overflow_count++;
			}
		}
		while(ref_sq!=1) // Wait for the signal to be one
		{
			if(TF0==1) // Did the 16-bit timer overflow?
			{
				TF0=0;
				overflow_count++;
			}
		}
		TR0=0; // Stop timer 0, the 24-bit number [overflow_count-TH0-TL0] has the period!
		period=(overflow_count*65536.0+TH0*256.0+TL0)*(12.0/SYSCLK);
		
		// Measure time difference between zero cross of both signals
		
		// Reset the timer
		TMOD&=0b_1111_0000;
		TMOD|=0b_0000_0001;

		TL0=0;
		TH0=0;
		overflow_count=0;
		TF0=0;
		
		// Save the period of signal
		while (ref_sq==1); // Wait for ref signal to be zero
		while (ref_sq==0); // Wait for ref signal to be one
		TR0=1; // Start the timer 0
		while (test_sq==0); // Wait for ref signal to be zero again
		//period=2*(TH0*256.0+TL0); // The 16-bit number [TH0-TL0]
		// Time from the beginning of the sine wave to its peak
		//overflow_count=65536-(period/4);
		while(test_sq!=0) // Wait for the signal to be zero
		{
			if(TF0==1) // Did the 16-bit timer overflow?
			{
				TF0=0;
				overflow_count++;
			}
		}
		while(test_sq!=1) // Wait for the signal to be one
		{
			if(TF0==1) // Did the 16-bit timer overflow?
			{
				TF0=0;
				overflow_count++;
			}
		}
		TR0=0; // Stop timer 0, the 24-bit number [overflow_count-TH0-TL0] has the period!
		time_diff=period - (overflow_count*65536.0+TH0*256.0+TL0)*(12.0/SYSCLK);
		ph_diff=time_diff*(360/period);
		f = 1/period; 

		sprintf(str_0,"V0=%.2fV", V_rms[0]);
		sprintf(str_1,"V1=%.2fV", V_rms[1]);
//		sprintf(str_f,"f=%.2fHz", f);
//		sprintf(str_ph,"P=%.2f", ph_diff);
		LCDprint(str_0, 1, 1);
		LCDprint(str_1, 2, 1);
		waitms(200);
		waitms(200);
//		LCDprint(str_f, 1, 1);
//		LCDprint(str_ph, 2, 1);
//		waitms(200);
		
		V[0]=Volts_at_Pin(LQFP32_MUX_P2_6);
		V[1]=Volts_at_Pin(LQFP32_MUX_P1_5);
		V_rms[0] = 0.7071*V[0];
		V_rms[1] = 0.7071*V[1];
		//display game on putty
			
		Key = getKey();
		if(RI) Key=getKey();
		if(Key != 0)
		{	
		    if(Key == KEY_UP){
		    y=y-1;}
			else if(Key == KEY_LEFT){
			x=x-1;}
			else if(Key == KEY_DOWN){
			y=y+1;}
			else if(Key == KEY_RIGHT){
			x=x+1;}
			else if(Key == KEY_ADC){
			printf("\rfreq=%5.3fHz\r\n", f);  
			printf("\rperiod=%5.3fs\r\n", period);
			printf("\rV0=%5.3fV\r\n", V_rms[0]);
			printf("\rV1=%5.3fV\r\n", V_rms[1]);
			printf("\rtime_diff=%5.3fs\r\n",time_diff);
			printf("\rph_diff=%5.6fdegrees\r\n",ph_diff);}
		
			printf(GOTO_YX "*", y, x);
			if((y==8 && x==8) | (y==12 && x==12) | (y==16 && x==16) | (y==20 && x==20)){
			printf(GOTO_YX "(^3^)", y, x);
			x += 5;	}
			if(y==15 && x==54){
			printf(GOTO_YX "\r\n-----------------\r\n", 20,20);
			printf(GOTO_YX "\r\n-----SUCCESS-----\r\n", 21,20);
			printf(GOTO_YX "\r\n-----------------\r\n", 22,20);
			}
		}		
		
	}
}