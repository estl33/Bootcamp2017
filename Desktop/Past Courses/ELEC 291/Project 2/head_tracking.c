//  square.c: Uses timer 2 interrupt to generate a square wave in pin
//  P2.0 and a 75% duty cycle wave in pin P2.1
//  Copyright (c) 2010-2015 Jesus Calvino-Fraga
//  ~C51~

#include <C8051F38x.h>
#include <stdlib.h>
#include <stdio.h>



#define SYSCLK    48000000L // SYSCLK frequency in Hz
#define BAUDRATE  115200L   // Baud rate of UART in bps

#define out_x P2_1
#define out_z P2_0
#define sig_x  P2_2
#define sig_z  P2_3

volatile unsigned char pwm_count=0;


char _c51_external_startup (void)
{
	PCA0MD&=(~0x40) ;    // DISABLE WDT: clear Watchdog Enable bit
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
	

	// Init ADC multiplexer to read the voltage between P2.1 and ground.
	// IMPORTANT: check section 6.5 in datasheet.  The constants for
	// each pin are available in "c8051f38x.h" both for the 32 and 48
	// pin packages.
	AMX0N = LQFP32_MUX_GND;  // GND is negative input (Single-ended Mode)
	
	// Init ADC
	ADC0CF = 0xF8; // SAR clock = 31, Right-justified result
	ADC0CN = 0b_1000_0000; // AD0EN=1, AD0TM=0
  	REF0CN=0b_0000_1000; //Select VDD as the voltage reference
  
	VDM0CN=0x80;       // enable VDD monitor
	RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	P0MDOUT|=0x11;     // Enable Uart TX as push-pull output, P0.0 as output
	XBR0=0x01;         // Enable UART on P0.4(TX) and P0.5(RX)
	XBR1=0x40;         // Enable crossbar and weak pull-ups
	
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
	
	TL1 = TH1;     // Init timer 1
	TMOD &= 0x0f;  // TMOD: timer 1 in 8-bit autoreload
	TMOD |= 0x20;                       
	TR1 = 1;       // Start timer1
	SCON = 0x52;
	
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


#define nop()\
	_asm\
	nop\
	nop\
	nop\
	nop\
	nop\
	nop\
	_endasm\

void Timer2_ISR (void) interrupt 5
{
//	TF2H = 0; // Clear Timer2 interrupt flag
	
//	pwm_count++;
//	if(pwm_count>100) pwm_count=0;
	
//	OUT0=pwm_count>50?0:1;
	//OUT1=pwm_count>75?0:1;
}
void Delay_servo(int us)
{
  while(us--)
  {
   nop();
  }
}

//1 CPU cycle  = 0.0008278*10^-6 s
//1 nop(); = 0.004967*10^-6 s

void waitms (unsigned int ms)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
}

void waitus (unsigned int us)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<us; j++)
		for (k=0; k<4; k++) Timer3us(250);
}
unsigned int map(unsigned x, unsigned int in_min, unsigned int in_max, unsigned int out_min, unsigned int out_max)
{
  return (((x - in_min)*(out_max - out_min) / (in_max - in_min)) + out_min);
}
#define VDD 3.325

void main (void)
{
	volatile unsigned int val=300;
	volatile int count;
//	static int temp, sval;
	volatile float sval_x,sval_z;
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("Square wave generator for the F38x.\r\n"
	       "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");
	out_x=0;
	out_y=0;
	
	InitPinADC(2, 0); // Configure P2.0 as analog input
	InitPinADC(2, 1); // Configure P2.1 as analog input
	InitADC();
	while(1)
	{	
	
	count=35;//change this to change responsiveness of motor to accelerom
	val_x = ADC_at_Pin(LQFP32_MUX_P2_1);
	val_z = ADC_at_Pin(LQFP32_MUX_P2_0);
	
//	temp=(val-375.0)*(260.0)/(202.0)+74.0;//map(val, 280, 465, 900, 1800);
	temp_x=(val_x-260)*15+300;// need to adjust this, might want to create a calibrate function somehow....
	temp_z=(val_x-260)*15+300;
	sval_x=temp_x;
	sval_z=temp_z;
	printf ("V @ P2.1 = %u, P2.0(sval)= %u \r", (val_x), sval_x);
	printf ("V @ P2.1 = %u, P2.0(sval)= %u \r", (val_z), sval_z);

	if(sval_y > 5){
	printf("turning in y-axis");
	}
	if(sval_x > 5){
	printf("turning in x-axis");
	}
	printf ("@ P2.1 = %d us, @P2.0 = %d us \r", sval_x, sval_y);
	
	while(count--){
		if(flag){
			out0=1;
			//Delay_servo(sval_x);
			waitus(sval_x);
			out0=0;
		}
		else{	
			out0=1;
			//Delay_servo(sval_z);
			waitus(sval_y);
			out0=0;
		}
		flag = !flag;
	}
	}
}
