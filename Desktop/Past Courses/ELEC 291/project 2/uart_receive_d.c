// Project 2 - Controlling C8051F38x
//  ~C51~

#include <C8051F38x.h>
#include <stdlib.h>
#include <stdio.h>

#define SYSCLK    48000000L // SYSCLK frequency in Hz
#define BAUDRATE  115200L   // Baud rate of UART in bps
#define UARTBAUDRATE 110L	// Baud rate of UART1

#define OUT0 P2_0
#define OUT1 P2_1

#define LCD_RS 			P1_7
#define LCD_RW 			P1_5 // Not used in this code
#define LCD_E  			P1_6
#define LCD_D4 			P1_4
#define LCD_D5 			P1_3
#define LCD_D6 			P1_2
#define LCD_D7 			P1_1
#define CHARS_PER_LINE 	16
#define TIMER_0_FREQ 1000L
#define TIMER_1_FREQ 2000L
#define TIMER_2_FREQ 3000L
#define TIMER_3_FREQ 4000L
#define TIMER_4_FREQ 5000L
#define TIMER_5_FREQ 6000L
#define PCA_0_FREQ 7000L
#define PCA_1_FREQ 8000L
#define PCA_2_FREQ 9000L
#define PCA_3_FREQ 10000L
#define PCA_4_FREQ 11000L

volatile unsigned char pwm_count=0;
volatile unsigned char sick1=0;
volatile unsigned char sick2=0;
volatile unsigned char sickest = 0;
unsigned char overflow_count;
unsigned char receiveData;



/**************************** UART *****************************/


void PORT_Init (void)
{
	P0MDOUT |= 0x10; // Enable UART TX as push-pull output
	XBR0=0b_0000_0001; // Enable UART0 on P0.4(TX) and P0.5(RX)                    
	XBR1=0b_0101_0000; // Enable crossbar.  Enable T0 input.
	XBR2=0b_0000_0000; // Disable UART1
}

/*
//Initialize UART0
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
*/

// Initialize UART1
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


// Transmit data through UART 1
void putchar1 (char c) {
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
	
// Transmit data through UART 0
void putchar0 (char d) {
	if (d == '\n' )
	{
		while (!(SCON0 & 0x02));
		SCON0 &= ~0x02;
		SBUF0 = '\r' ;
	}
	while (!(SCON0 & 0x02));
	SCON0 &= ~0x02;
	SBUF0 = d;
	}

//	Get data from UART 1
char getchar1 (void)
{
	char c;
	while (!(SCON1 & 0x01));
	SCON1 &= ~0x01;
	c = SBUF1;
	return (c);
}

// Get data from UART 0
char getchar0 (void)
{
	char d;
	while (!(SCON0 & 0x01));
	SCON0 &= ~0x01;
	d = SBUF0;
	return (d);
}


/*************************** SYSTEM CONFIGURATION *********************************/

char _c51_external_startup (void)
{
	PORT_Init();
	UART1_Init(UARTBAUDRATE);
	PCA0MD&=(~WDTE) ;    // DISABLE WDT: clear Watchdog Enable bit
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
	RSTSRC  = 0x04;   // Enable missing clock detector
	
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
	P1MDOUT|=0b_0001_1111;
	P2MDOUT|=0b_0111_1111;
	XBR0 	 = 0x01; // Enable UART0
	XBR1     = 0x40; // Enable crossbar and weak pull-ups
	XBR2     = 0x01; // Enable UART 1

	// Initialize timer 0 for periodic interrupts
	TR0=0;
	TF0=0;
	CKCON|=0b_0000_0100; // Timer 0 uses the system clock
	TMOD&=0xf0;
	TMOD|=0x01; // Timer 0 in mode 1: 16-bit timer
	// Initialize reload value
	TH0=(65536L-(SYSCLK/(2*TIMER_0_FREQ)))/0x100;
	TL0=(65536L-(SYSCLK/(2*TIMER_0_FREQ)))%0x100;
	ET0=1;     // Enable Timer0 interrupts
	TR0=1;     // Start Timer0

	// Initialize timer 1 for periodic interrupts
	TR1=0;
	TF1=0;
	CKCON|=0b_0000_1000; // Timer 1 uses the system clock
	TMOD&=0x0f;
	TMOD|=0x10; // Timer 1 in mode 1: 16-bit timer
	// Initialize reload value
	TH1=(65536L-(SYSCLK/(2*TIMER_1_FREQ)))/0x100;
	TL1=(65536L-(SYSCLK/(2*TIMER_1_FREQ)))%0x100;
	ET1=1;     // Enable Timer1 interrupts
	TR1=1;     // Start Timer1

	// Initialize timer 2 for periodic interrupts
	TMR2CN=0x00;   // Stop Timer2; Clear TF2;
	CKCON|=0b_0001_0000; // Timer 2 uses the system clock
	TMR2RL=(0x10000L-(SYSCLK/(2*TIMER_2_FREQ))); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // Enable Timer2 interrupts
	TR2=1;         // Start Timer2 (TMR2CN is bit addressable)

	// Initialize timer 3 for periodic interrupts
	TMR3CN=0x00;   // Stop Timer3; Clear TF3;
	CKCON|=0b_0100_0000; // Timer 3 uses the system clock
	TMR3RL=(0x10000L-(SYSCLK/(2*TIMER_3_FREQ))); // Initialize reload value
	TMR3=0xffff;   // Set to reload immediately
	EIE1|=ET3;     // Enable Timer3 interrupts
	TMR3CN|=TR3;   // Start Timer3 (TMR3CN is not bit addressable)

	// Initialize timer 4 for periodic interrupts
	SFRPAGE=0xf;   // WARNING: Select SFR page 0xf!
	TMR4CN=0x00;   // Stop Timer4; Clear TF4;
	CKCON1|=0b_0000_0001; // Timer 4 uses the system clock
	TMR4RL=(0x10000L-(SYSCLK/(2*TIMER_4_FREQ))); // Initialize reload value
	TMR4=0xffff;   // Set to reload immediately
	EIE2|=ET4;     // Enable Timer3 interrupts
	TMR4CN|=TR4;   // Start Timer4 (TMR4CN is not bit addressable)

	// Initialize timer 5 for periodic interrupts
	SFRPAGE=0xf;   // WARNING: Select SFR page 0xf!
	TMR5CN=0x00;   // Stop Timer5; Clear TF5;
	CKCON1|=0b_0000_0100; // Timer 5 uses the system clock
	TMR5RL=(0x10000L-(SYSCLK/(2*TIMER_5_FREQ))); // Initialize reload value
	TMR5=0xffff;   // Set to reload immediately
	EIE2|=ET5;     // Enable Timer5 interrupts
	TR5=1;         // Start Timer5 (TMR5CN is bit addressable)

/*	// Initialize the Prgramable Counter Array to generate four servo 
	// signals at pins P1.0 to P1.2
	SFRPAGE=0x0;
	PCA0MD=0x00; // Disable and clear everything in the PCA
	PCA0L=0; // Initialize the PCA counter to zero
	PCA0H=0;
	PCA0MD=CPS2; // Configure PCA.  CLK is the frequency input for the PCA
	// Enable all PCS modules comparators and to generate interrupts
	PCA0CPM0=PCA0CPM1=PCA0CPM2=PCA0CPM3=PCA0CPM4=ECOM|MAT|ECCF;
	// The frequency for PCA channel 0
	PCA0CPL0=(SYSCLK/(2*PCA_0_FREQ))%0x100; //Always write low byte first!
	PCA0CPH0=(SYSCLK/(2*PCA_0_FREQ))/0x100;
	// The frequency for PCA channel 1
	PCA0CPL1=(SYSCLK/(2*PCA_1_FREQ))%0x100; //Always write low byte first!
	PCA0CPH1=(SYSCLK/(2*PCA_1_FREQ))/0x100;
	// The frequency for PCA channel 2
	PCA0CPL2=(SYSCLK/(2*PCA_2_FREQ))%0x100; //Always write low byte first!
	PCA0CPH2=(SYSCLK/(2*PCA_2_FREQ))/0x100;
	// The frequency for PCA channel 3
	PCA0CPL3=(SYSCLK/(2*PCA_3_FREQ))%0x100; //Always write low byte first!
	PCA0CPH3=(SYSCLK/(2*PCA_3_FREQ))/0x100;
	// The frequency for PCA channel 4
	PCA0CPL4=(SYSCLK/(2*PCA_4_FREQ))%0x100; //Always write low byte first!
	PCA0CPH4=(SYSCLK/(2*PCA_4_FREQ))/0x100;
	CR=1; // Enable PCA counter
	EIE1|=EPCA0; // Enable PCA interrupts
	*/
	
	EA=1; // Enable interrupts
	
	return 0;
}

/**************************** TIMERS *****************************/

/*

void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit counter
	TR0=0; // Stop Timer/Counter 0
}

*/

// Timer 2 used to control the H - Bridge/Motor //
/*void Timer2_ISR (void) interrupt 5
{
	TF2H = 0; // Clear Timer2 interrupt flag
	
	pwm_count++;
	if(pwm_count>100) pwm_count=0;
	
	if(sickest<3.000000){
		OUT0=pwm_count>5?0:1;
		OUT1=pwm_count>5?0:1;
	}
	else{
	
	
		OUT0=pwm_count>sick1?0:1;
		OUT1=pwm_count>sick2?0:1;
	}
}
*/

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


/**************************** LCD *****************************/
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


/**************************** ADC ****************************/
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



////////////////////////////////////// MAIN PROGRAM ///////////////////////////////////////
////////////////////////////////////// MAIN PROGRAM ///////////////////////////////////////
////////////////////////////////////// MAIN PROGRAM ///////////////////////////////////////
////////////////////////////////////// MAIN PROGRAM ///////////////////////////////////////
////////////////////////////////////// MAIN PROGRAM ///////////////////////////////////////


void main (void)
{
	//float volt2;
	//float volt3;
	//float peak;
	char str_1[8] = {'       '};
	
/*	InitPinADC(2, 2); // Configure P2.2 as analog input
	InitPinADC(2, 3); // Configure P2.3 as analog input
	InitPinADC(2, 4); // Configure P2.4 as analog input
	InitPinADC(2, 5); // Configure P2.5 as analog input
	*/
	
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("Square wave generator for the F38x.\r\n"
	       "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");
	
	// Initialize the ADC
	InitADC();
	LCD_4BIT();
	
	// Display something in the LCD
	LCDprint("Speed:", 1, 1);
	
	P2_2 = 0;
	
	while(1)
	{
	
		/*
		////// Amplify and read signal //////
		volt2=Volts_at_Pin(LQFP32_MUX_P2_2);
		volt3=Volts_at_Pin(LQFP32_MUX_P2_3);
		sickest=Volts_at_Pin(LQFP32_MUX_P2_4);
		peak = Volts_at_Pin(LQFP32_MUX_P2_5);
		sprintf(str_1,"V1=%.2fV", peak);
		sick1 = volt2*24;
		sick2 = volt3*24;
		printf("V[2]=%5.3f\n", volt2);
		printf("V[3]=%5.3f\n", volt3);
		*/
		
		// Received data = 0b11110000
		
		receiveData = getchar0();
		//putchar0 (0b11110000);
		//P2_1 = 0;
		
		/*if (receiveData == 0b11110000)
		{
			P2_2 = 0;
			waitms(220);
			waitms(220);
			P2_2 = 1;
			waitms(220);
			waitms(220);
		}
		*/
		printf("Data received = %c\n", receiveData);
		
	}
}

