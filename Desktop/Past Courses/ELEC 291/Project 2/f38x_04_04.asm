;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Tue Apr 04 13:59:07 2017
;--------------------------------------------------------
$name f38x_04_04
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _speed_PARM_3
	public _speed_PARM_2
	public _InitPinADC_PARM_2
	public _main
	public _getKey
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _rotate180
	public _backward
	public _forward
	public _turnLeft
	public _turnRight
	public _stop
	public _speed
	public _waitsec
	public _waitms
	public _Timer3us
	public _Timer2_ISR
	public _Get_ADC
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public _getchar1
	public _putchar1
	public _UART1_Init
	public __c51_external_startup
	public _LCDprint_PARM_3
	public _LCDprint_PARM_2
	public _str_1
	public _str_0
	public _Key
	public _y
	public _x
	public _logic
	public _numPulse
	public _dataloopcount
	public _count
	public _taketurn
	public _fieldMiddle
	public _fieldRight
	public _fieldLeft
	public _data_received
	public _swap
	public _percentage3
	public _percentage2
	public _percentage1
	public _percentage0
	public _pwm_count
	public _getchar
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_P0             DATA 0x80
_SP             DATA 0x81
_DPL            DATA 0x82
_DPH            DATA 0x83
_EMI0TC         DATA 0x84
_EMI0CF         DATA 0x85
_OSCLCN         DATA 0x86
_PCON           DATA 0x87
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_CKCON          DATA 0x8e
_PSCTL          DATA 0x8f
_P1             DATA 0x90
_TMR3CN         DATA 0x91
_TMR4CN         DATA 0x91
_TMR3RLL        DATA 0x92
_TMR4RLL        DATA 0x92
_TMR3RLH        DATA 0x93
_TMR4RLH        DATA 0x93
_TMR3L          DATA 0x94
_TMR4L          DATA 0x94
_TMR3H          DATA 0x95
_TMR4H          DATA 0x95
_USB0ADR        DATA 0x96
_USB0DAT        DATA 0x97
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_CPT1CN         DATA 0x9a
_CPT0CN         DATA 0x9b
_CPT1MD         DATA 0x9c
_CPT0MD         DATA 0x9d
_CPT1MX         DATA 0x9e
_CPT0MX         DATA 0x9f
_P2             DATA 0xa0
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0DAT        DATA 0xa3
_P0MDOUT        DATA 0xa4
_P1MDOUT        DATA 0xa5
_P2MDOUT        DATA 0xa6
_P3MDOUT        DATA 0xa7
_IE             DATA 0xa8
_CLKSEL         DATA 0xa9
_EMI0CN         DATA 0xaa
__XPAGE         DATA 0xaa
_SBCON1         DATA 0xac
_P4MDOUT        DATA 0xae
_PFE0CN         DATA 0xaf
_P3             DATA 0xb0
_OSCXCN         DATA 0xb1
_OSCICN         DATA 0xb2
_OSCICL         DATA 0xb3
_SBRLL1         DATA 0xb4
_SBRLH1         DATA 0xb5
_FLSCL          DATA 0xb6
_FLKEY          DATA 0xb7
_IP             DATA 0xb8
_CLKMUL         DATA 0xb9
_SMBTC          DATA 0xb9
_AMX0N          DATA 0xba
_AMX0P          DATA 0xbb
_ADC0CF         DATA 0xbc
_ADC0L          DATA 0xbd
_ADC0H          DATA 0xbe
_SFRPAGE        DATA 0xbf
_SMB0CN         DATA 0xc0
_SMB1CN         DATA 0xc0
_SMB0CF         DATA 0xc1
_SMB1CF         DATA 0xc1
_SMB0DAT        DATA 0xc2
_SMB1DAT        DATA 0xc2
_ADC0GTL        DATA 0xc3
_ADC0GTH        DATA 0xc4
_ADC0LTL        DATA 0xc5
_ADC0LTH        DATA 0xc6
_P4             DATA 0xc7
_TMR2CN         DATA 0xc8
_TMR5CN         DATA 0xc8
_REG01CN        DATA 0xc9
_TMR2RLL        DATA 0xca
_TMR5RLL        DATA 0xca
_TMR2RLH        DATA 0xcb
_TMR5RLH        DATA 0xcb
_TMR2L          DATA 0xcc
_TMR5L          DATA 0xcc
_TMR2H          DATA 0xcd
_TMR5H          DATA 0xcd
_SMB0ADM        DATA 0xce
_SMB1ADM        DATA 0xce
_SMB0ADR        DATA 0xcf
_SMB1ADR        DATA 0xcf
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_SCON1          DATA 0xd2
_SBUF1          DATA 0xd3
_P0SKIP         DATA 0xd4
_P1SKIP         DATA 0xd5
_P2SKIP         DATA 0xd6
_USB0XCN        DATA 0xd7
_PCA0CN         DATA 0xd8
_PCA0MD         DATA 0xd9
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xdd
_PCA0CPM4       DATA 0xde
_P3SKIP         DATA 0xdf
_ACC            DATA 0xe0
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_IT01CF         DATA 0xe4
_CKCON1         DATA 0xe4
_SMOD1          DATA 0xe5
_EIE1           DATA 0xe6
_EIE2           DATA 0xe7
_ADC0CN         DATA 0xe8
_PCA0CPL1       DATA 0xe9
_PCA0CPH1       DATA 0xea
_PCA0CPL2       DATA 0xeb
_PCA0CPH2       DATA 0xec
_PCA0CPL3       DATA 0xed
_PCA0CPH3       DATA 0xee
_RSTSRC         DATA 0xef
_B              DATA 0xf0
_P0MDIN         DATA 0xf1
_P1MDIN         DATA 0xf2
_P2MDIN         DATA 0xf3
_P3MDIN         DATA 0xf4
_P4MDIN         DATA 0xf5
_EIP1           DATA 0xf6
_EIP2           DATA 0xf7
_SPI0CN         DATA 0xf8
_PCA0L          DATA 0xf9
_PCA0H          DATA 0xfa
_PCA0CPL0       DATA 0xfb
_PCA0CPH0       DATA 0xfc
_PCA0CPL4       DATA 0xfd
_PCA0CPH4       DATA 0xfe
_VDM0CN         DATA 0xff
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0x9392
_TMR5RL         DATA 0xcbca
_TMR2           DATA 0xcdcc
_TMR3           DATA 0x9594
_TMR4           DATA 0x9594
_TMR5           DATA 0xcdcc
_SBRL1          DATA 0xb5b4
_ADC0           DATA 0xbebd
_ADC0GT         DATA 0xc4c3
_ADC0LT         DATA 0xc6c5
_PCA0           DATA 0xfaf9
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xeeed
_PCA0CP0        DATA 0xfcfb
_PCA0CP4        DATA 0xfefd
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_TF1            BIT 0x8f
_TR1            BIT 0x8e
_TF0            BIT 0x8d
_TR0            BIT 0x8c
_IE1            BIT 0x8b
_IT1            BIT 0x8a
_IE0            BIT 0x89
_IT0            BIT 0x88
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_S0MODE         BIT 0x9f
_SCON0_6        BIT 0x9e
_MCE0           BIT 0x9d
_REN0           BIT 0x9c
_TB80           BIT 0x9b
_RB80           BIT 0x9a
_TI0            BIT 0x99
_RI0            BIT 0x98
_SCON_6         BIT 0x9e
_MCE            BIT 0x9d
_REN            BIT 0x9c
_TB8            BIT 0x9b
_RB8            BIT 0x9a
_TI             BIT 0x99
_RI             BIT 0x98
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_EA             BIT 0xaf
_ESPI0          BIT 0xae
_ET2            BIT 0xad
_ES0            BIT 0xac
_ET1            BIT 0xab
_EX1            BIT 0xaa
_ET0            BIT 0xa9
_EX0            BIT 0xa8
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_IP_7           BIT 0xbf
_PSPI0          BIT 0xbe
_PT2            BIT 0xbd
_PS0            BIT 0xbc
_PT1            BIT 0xbb
_PX1            BIT 0xba
_PT0            BIT 0xb9
_PX0            BIT 0xb8
_MASTER0        BIT 0xc7
_TXMODE0        BIT 0xc6
_STA0           BIT 0xc5
_STO0           BIT 0xc4
_ACKRQ0         BIT 0xc3
_ARBLOST0       BIT 0xc2
_ACK0           BIT 0xc1
_SI0            BIT 0xc0
_MASTER1        BIT 0xc7
_TXMODE1        BIT 0xc6
_STA1           BIT 0xc5
_STO1           BIT 0xc4
_ACKRQ1         BIT 0xc3
_ARBLOST1       BIT 0xc2
_ACK1           BIT 0xc1
_SI1            BIT 0xc0
_TF2            BIT 0xcf
_TF2H           BIT 0xcf
_TF2L           BIT 0xce
_TF2LEN         BIT 0xcd
_TF2CEN         BIT 0xcc
_T2SPLIT        BIT 0xcb
_TR2            BIT 0xca
_T2CSS          BIT 0xc9
_T2XCLK         BIT 0xc8
_TF5H           BIT 0xcf
_TF5L           BIT 0xce
_TF5LEN         BIT 0xcd
_TMR5CN_4       BIT 0xcc
_T5SPLIT        BIT 0xcb
_TR5            BIT 0xca
_TMR5CN_1       BIT 0xc9
_T5XCLK         BIT 0xc8
_CY             BIT 0xd7
_AC             BIT 0xd6
_F0             BIT 0xd5
_RS1            BIT 0xd4
_RS0            BIT 0xd3
_OV             BIT 0xd2
_F1             BIT 0xd1
_PARITY         BIT 0xd0
_CF             BIT 0xdf
_CR             BIT 0xde
_PCA0CN_5       BIT 0xde
_CCF4           BIT 0xdc
_CCF3           BIT 0xdb
_CCF2           BIT 0xda
_CCF1           BIT 0xd9
_CCF0           BIT 0xd8
_ACC_7          BIT 0xe7
_ACC_6          BIT 0xe6
_ACC_5          BIT 0xe5
_ACC_4          BIT 0xe4
_ACC_3          BIT 0xe3
_ACC_2          BIT 0xe2
_ACC_1          BIT 0xe1
_ACC_0          BIT 0xe0
_AD0EN          BIT 0xef
_AD0TM          BIT 0xee
_AD0INT         BIT 0xed
_AD0BUSY        BIT 0xec
_AD0WINT        BIT 0xeb
_AD0CM2         BIT 0xea
_AD0CM1         BIT 0xe9
_AD0CM0         BIT 0xe8
_B_7            BIT 0xf7
_B_6            BIT 0xf6
_B_5            BIT 0xf5
_B_4            BIT 0xf4
_B_3            BIT 0xf3
_B_2            BIT 0xf2
_B_1            BIT 0xf1
_B_0            BIT 0xf0
_SPIF           BIT 0xff
_WCOL           BIT 0xfe
_MODF           BIT 0xfd
_RXOVRN         BIT 0xfc
_NSSMD1         BIT 0xfb
_NSSMD0         BIT 0xfa
_TXBMT          BIT 0xf9
_SPIEN          BIT 0xf8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
	rbank1 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_backwardsFlag:
	ds 2
_pwm_count:
	ds 1
_percentage0:
	ds 2
_percentage1:
	ds 2
_percentage2:
	ds 2
_percentage3:
	ds 2
_swap:
	ds 2
_data_received:
	ds 2
_fieldLeft:
	ds 2
_fieldRight:
	ds 2
_fieldMiddle:
	ds 2
_taketurn:
	ds 2
_count:
	ds 2
_dataloopcount:
	ds 2
_numPulse:
	ds 2
_logic:
	ds 2
_x:
	ds 2
_y:
	ds 2
_Key:
	ds 1
_str_0:
	ds 8
_str_1:
	ds 8
_UART1_Init_sloc0_1_0:
	ds 4
_LCDprint_PARM_2:
	ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_speed_PARM_2:
	ds 2
_speed_PARM_3:
	ds 2
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_Timer2_ISR_sloc0_1_0:
	DBIT	1
_LCDprint_PARM_3:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x002b
	ljmp	_Timer2_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:25: static int backwardsFlag = 0;
	clr	a
	mov	_backwardsFlag,a
	mov	(_backwardsFlag + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:26: volatile unsigned char pwm_count=0;
	mov	_pwm_count,#0x00
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:36: unsigned int taketurn = 1;
	mov	_taketurn,#0x01
	clr	a
	mov	(_taketurn + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:37: unsigned int count = 50;
	mov	_count,#0x32
	clr	a
	mov	(_count + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:38: unsigned int dataloopcount = 100;
	mov	_dataloopcount,#0x64
	clr	a
	mov	(_dataloopcount + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:39: volatile int numPulse = 0;
	clr	a
	mov	_numPulse,a
	mov	(_numPulse + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:42: int x=15;
	mov	_x,#0x0F
	clr	a
	mov	(_x + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:43: int y=15;
	mov	_y,#0x0F
	clr	a
	mov	(_y + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:45: char str_0 [8] = {'  '};
	mov	_str_0,#0x20
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:46: char str_1 [8] = {'  '};
	mov	_str_1,#0x20
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:48: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:50: PCA0MD&=(~0x40) ;    // DISABLE WDT: clear Watchdog Enable bit
	anl	_PCA0MD,#0xBF
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:51: VDM0CN=0x80; // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:52: RSTSRC=0x02|0x04; // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:60: CLKSEL|=0b_0000_0011; // SYSCLK derived from the Internal High-Frequency Oscillator / 1.
	orl	_CLKSEL,#0x03
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:64: OSCICN |= 0x03; // Configure internal oscillator for its maximum frequency
	orl	_OSCICN,#0x03
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:67: SCON0 = 0x10; 
	mov	_SCON0,#0x10
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:69: TH1 = 0x10000-((SYSCLK/BAUDRATE)/2L);
	mov	_TH1,#0x30
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:70: CKCON &= ~0x0B;                  // T1M = 1; SCA1:0 = xx
	anl	_CKCON,#0xF4
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:71: CKCON |=  0x08;
	orl	_CKCON,#0x08
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:84: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:85: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit autoreload
	anl	_TMOD,#0x0F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:86: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:87: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:88: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:91: P2MDOUT|=0b_0000_0011;
	orl	_P2MDOUT,#0x03
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:92: P0MDOUT |= 0x10; // Enable UTX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:93: XBR0     = 0x01; // Enable UART on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:94: XBR1     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR1,#0x40
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:97: TMR2CN=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN,#0x00
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:98: CKCON|=0b_0001_0000;
	orl	_CKCON,#0x10
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:99: TMR2RL=(-(SYSCLK/(2*48))/(100L)); // Initialize reload value
	mov	_TMR2RL,#0x78
	mov	(_TMR2RL >> 8),#0xEC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:100: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:101: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:102: TR2=1;         // Start Timer2
	setb	_TR2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:104: EA=1; // Enable interrupts
	setb	_EA
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:106: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'UART1_Init'
;------------------------------------------------------------
;baudrate                  Allocated to registers r2 r3 r4 r5 
;sloc0                     Allocated with name '_UART1_Init_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:112: void UART1_Init (unsigned long baudrate)
;	-----------------------------------------
;	 function UART1_Init
;	-----------------------------------------
_UART1_Init:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:114: SMOD1 = 0x0C; // no parity, 8 data bits, 1 stop bit
	mov	_SMOD1,#0x0C
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:115: SCON1 = 0x10;
	mov	_SCON1,#0x10
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:116: if (((SYSCLK/baudrate)/2L)/0xFFFFL < 1){
	mov	__divulong_PARM_2,r2
	mov	(__divulong_PARM_2 + 1),r3
	mov	(__divulong_PARM_2 + 2),r4
	mov	(__divulong_PARM_2 + 3),r5
	mov	dptr,#0x6C00
	mov	b,#0xDC
	mov	a,#0x02
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	clr	c
	rrc	a
	mov	(_UART1_Init_sloc0_1_0 + 3),a
	mov	a,r4
	rrc	a
	mov	(_UART1_Init_sloc0_1_0 + 2),a
	mov	a,r3
	rrc	a
	mov	(_UART1_Init_sloc0_1_0 + 1),a
	mov	a,r2
	rrc	a
	mov	_UART1_Init_sloc0_1_0,a
	mov	__divulong_PARM_2,#0xFF
	mov	(__divulong_PARM_2 + 1),#0xFF
	mov	(__divulong_PARM_2 + 2),#0x00
	mov	(__divulong_PARM_2 + 3),#0x00
	mov	dpl,_UART1_Init_sloc0_1_0
	mov	dph,(_UART1_Init_sloc0_1_0 + 1)
	mov	b,(_UART1_Init_sloc0_1_0 + 2)
	mov	a,(_UART1_Init_sloc0_1_0 + 3)
	lcall	__divulong
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	clr	c
	mov	a,r6
	subb	a,#0x01
	mov	a,r7
	subb	a,#0x00
	mov	a,r0
	subb	a,#0x00
	mov	a,r1
	subb	a,#0x00
	jnc	L003008?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:117: SBRL1 = 0x10000L-((SYSCLK/baudrate)/2L);
	clr	a
	clr	c
	subb	a,_UART1_Init_sloc0_1_0
	mov	r2,a
	clr	a
	subb	a,(_UART1_Init_sloc0_1_0 + 1)
	mov	r3,a
	mov	a,#0x01
	subb	a,(_UART1_Init_sloc0_1_0 + 2)
	mov	r4,a
	clr	a
	subb	a,(_UART1_Init_sloc0_1_0 + 3)
	mov	r5,a
	mov	_SBRL1,r2
	mov	(_SBRL1 >> 8),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:118: SBCON1 |= 0x03; // set prescaler to 1
	orl	_SBCON1,#0x03
	ljmp	L003009?
L003008?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:120: else if (((SYSCLK/baudrate)/2L)/0xFFFFL < 4){
	clr	c
	mov	a,r6
	subb	a,#0x04
	mov	a,r7
	subb	a,#0x00
	mov	a,r0
	subb	a,#0x00
	mov	a,r1
	subb	a,#0x00
	jnc	L003005?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:121: SBRL1 = 0x10000L-(((SYSCLK/baudrate)/2L)/4L);
	mov	a,(_UART1_Init_sloc0_1_0 + 3)
	clr	c
	rrc	a
	mov	r5,a
	mov	a,(_UART1_Init_sloc0_1_0 + 2)
	rrc	a
	mov	r4,a
	mov	a,(_UART1_Init_sloc0_1_0 + 1)
	rrc	a
	mov	r3,a
	mov	a,_UART1_Init_sloc0_1_0
	rrc	a
	mov	r2,a
	mov	a,r5
	clr	c
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
	mov	a,r3
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a
	clr	a
	clr	c
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	mov	a,#0x01
	subb	a,r4
	mov	r4,a
	clr	a
	subb	a,r5
	mov	r5,a
	mov	_SBRL1,r2
	mov	(_SBRL1 >> 8),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:122: SBCON1 &= ~0x03;
	anl	_SBCON1,#0xFC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:123: SBCON1 |= 0x01; // set prescaler to 4
	orl	_SBCON1,#0x01
	ljmp	L003009?
L003005?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:125: else if (((SYSCLK/baudrate)/2L)/0xFFFFL < 12){
	clr	c
	mov	a,r6
	subb	a,#0x0C
	mov	a,r7
	subb	a,#0x00
	mov	a,r0
	subb	a,#0x00
	mov	a,r1
	subb	a,#0x00
	jnc	L003002?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:126: SBRL1 = 0x10000L-(((SYSCLK/baudrate)/2L)/12L);
	mov	__divulong_PARM_2,#0x0C
	clr	a
	mov	(__divulong_PARM_2 + 1),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 3),a
	mov	dpl,_UART1_Init_sloc0_1_0
	mov	dph,(_UART1_Init_sloc0_1_0 + 1)
	mov	b,(_UART1_Init_sloc0_1_0 + 2)
	mov	a,(_UART1_Init_sloc0_1_0 + 3)
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	clr	c
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	mov	a,#0x01
	subb	a,r4
	mov	r4,a
	clr	a
	subb	a,r5
	mov	r5,a
	mov	_SBRL1,r2
	mov	(_SBRL1 >> 8),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:127: SBCON1 &= ~0x03; // set prescaler to 12
	anl	_SBCON1,#0xFC
	sjmp	L003009?
L003002?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:130: SBRL1 = 0x10000L-(((SYSCLK/baudrate)/2L)/48L);
	mov	__divulong_PARM_2,#0x30
	clr	a
	mov	(__divulong_PARM_2 + 1),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 3),a
	mov	dpl,_UART1_Init_sloc0_1_0
	mov	dph,(_UART1_Init_sloc0_1_0 + 1)
	mov	b,(_UART1_Init_sloc0_1_0 + 2)
	mov	a,(_UART1_Init_sloc0_1_0 + 3)
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	clr	c
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	mov	a,#0x01
	subb	a,r4
	mov	r4,a
	clr	a
	subb	a,r5
	mov	r5,a
	mov	_SBRL1,r2
	mov	(_SBRL1 >> 8),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:131: SBCON1 &= ~0x03;
	anl	_SBCON1,#0xFC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:132: SBCON1 |= 0x02; // set prescaler to ?
	orl	_SBCON1,#0x02
L003009?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:134: SCON1 |= 0x02; // indicate ready for TX
	orl	_SCON1,#0x02
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:135: SBCON1 |= 0x40; // enable baud rate generator
	orl	_SBCON1,#0x40
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar1'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:137: void putchar1 (char c)
;	-----------------------------------------
;	 function putchar1
;	-----------------------------------------
_putchar1:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:139: if (c == '\n' )
	cjne	r2,#0x0A,L004006?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:141: while (!(SCON1 & 0x02));
L004001?:
	mov	a,_SCON1
	jnb	acc.1,L004001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:142: SCON1 &= ~0x02;
	anl	_SCON1,#0xFD
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:143: SBUF1 = '\r' ;
	mov	_SBUF1,#0x0D
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:145: while (!(SCON1 & 0x02));
L004006?:
	mov	a,_SCON1
	jnb	acc.1,L004006?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:146: SCON1 &= ~0x02;
	anl	_SCON1,#0xFD
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:147: SBUF1 = c;
	mov	_SBUF1,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar1'
;------------------------------------------------------------
;c                         Allocated to registers 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:149: char getchar1 (void)
;	-----------------------------------------
;	 function getchar1
;	-----------------------------------------
_getchar1:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:152: while (!(SCON1 & 0x01));
L005001?:
	mov	a,_SCON1
	jnb	acc.0,L005001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:153: SCON1 &= ~0x01;
	anl	_SCON1,#0xFE
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:154: c = SBUF1;
	mov	dpl,_SBUF1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:155: return (c);
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:159: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:162: ADC0CF = 0xF8; // SAR clock = 31, Right-justified result
	mov	_ADC0CF,#0xF8
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:163: ADC0CN = 0b_1000_0000; // AD0EN=1, AD0TM=0
	mov	_ADC0CN,#0x80
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:164: REF0CN = 0b_0000_1000; //Select VDD as the voltage reference for the converter
	mov	_REF0CN,#0x08
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pinno                     Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:167: void InitPinADC (unsigned char portno, unsigned char pinno)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:171: mask=1<<pinno;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L007012?
L007010?:
	add	a,acc
L007012?:
	djnz	b,L007010?
	mov	r3,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:173: switch (portno)
	mov	a,r2
	add	a,#0xff - 0x03
	jc	L007007?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L007014?
	jmp	@a+dptr
L007014?:
	ljmp	L007001?
	ljmp	L007002?
	ljmp	L007003?
	ljmp	L007004?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:175: case 0:
L007001?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:176: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	anl	_P0MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:177: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:178: break;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:179: case 1:
	ret
L007002?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:180: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	anl	_P1MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:181: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:182: break;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:183: case 2:
	ret
L007003?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:184: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	anl	_P2MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:185: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:186: break;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:187: case 3:
	ret
L007004?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:188: P3MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P3MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:189: P3SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P3SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:193: }
L007007?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:196: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_AMX0P,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:199: AMX0N = LQFP32_MUX_GND;  // GND is negative input (Single-ended Mode)
	mov	_AMX0N,#0x1F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:201: AD0BUSY=1;
	setb	_AD0BUSY
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:202: while (AD0BUSY); // Wait for dummy conversion to finish
L008001?:
	jb	_AD0BUSY,L008001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:204: AD0BUSY = 1;
	setb	_AD0BUSY
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:205: while (AD0BUSY); // Wait for conversion to complete
L008004?:
	jb	_AD0BUSY,L008004?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:206: return (ADC0L+(ADC0H*0x100));
	mov	r2,_ADC0L
	mov	r3,#0x00
	mov	r5,_ADC0H
	mov	r4,#0x00
	mov	a,r4
	add	a,r2
	mov	dpl,a
	mov	a,r5
	addc	a,r3
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:209: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:211: return ((ADC_at_Pin(pin)*3.30)/1024.0);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x3333
	mov	b,#0x53
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#0x44
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Get_ADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:214: unsigned int Get_ADC (void)
;	-----------------------------------------
;	 function Get_ADC
;	-----------------------------------------
_Get_ADC:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:216: AD0BUSY = 1;
	setb	_AD0BUSY
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:217: while (AD0BUSY); // Wait for conversion to complete
L010001?:
	jb	_AD0BUSY,L010001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:218: return ( ADC0L + ( ADC0H * 0x100 ) );
	mov	r2,_ADC0L
	mov	r3,#0x00
	mov	r5,_ADC0H
	mov	r4,#0x00
	mov	a,r4
	add	a,r2
	mov	dpl,a
	mov	a,r5
	addc	a,r3
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:220: void Timer2_ISR (void) interrupt 5 using 1
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
	using	1
	push	acc
	push	b
	push	psw
	mov	psw,#0x08
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:222: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:224: pwm_count++;
	inc	_pwm_count
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:225: if(pwm_count>100) pwm_count=0;
	mov	a,_pwm_count
	add	a,#0xff - 0x64
	jnc	L011002?
	mov	_pwm_count,#0x00
L011002?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:227: OUT0=pwm_count>percentage0?0:1;
	mov	r2,_pwm_count
	mov	r3,#0x00
	clr	c
	mov	a,_percentage0
	subb	a,r2
	mov	a,(_percentage0 + 1)
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P2_3,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:228: OUT1=pwm_count>percentage1?0:1;
	mov	r2,_pwm_count
	mov	r3,#0x00
	clr	c
	mov	a,_percentage1
	subb	a,r2
	mov	a,(_percentage1 + 1)
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P2_4,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:229: OUT2=pwm_count>percentage2?0:1;
	mov	r2,_pwm_count
	mov	r3,#0x00
	clr	c
	mov	a,_percentage2
	subb	a,r2
	mov	a,(_percentage2 + 1)
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P2_5,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:230: OUT3=pwm_count>percentage3?0:1;
	mov	r2,_pwm_count
	mov	r3,#0x00
	clr	c
	mov	a,_percentage3
	subb	a,r2
	mov	a,(_percentage3 + 1)
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P2_6,c
	pop	psw
	pop	b
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:234: char getchar(void)
;	-----------------------------------------
;	 function getchar
;	-----------------------------------------
_getchar:
	using	0
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:237: if(SBUF=='\n')
	mov	a,#0x0A
	cjne	a,_SBUF,L012006?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:239: while (!RI);
L012001?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:240: RI=0;
	jbc	_RI,L012017?
	sjmp	L012001?
L012017?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:241: return SBUF;
	mov	dpl,_SBUF
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:243: while (!RI);
	ret
L012006?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:244: RI=0;
	jbc	_RI,L012018?
	sjmp	L012006?
L012018?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:245: return SBUF;
	mov	dpl,_SBUF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:249: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:254: CKCON|=0b_0100_0000;
	orl	_CKCON,#0x40
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:256: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xD0
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:257: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:259: TMR3CN = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN,#0x04
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:260: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L013004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L013007?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:262: while (!(TMR3CN & 0x80));  // Wait for overflow
L013001?:
	mov	a,_TMR3CN
	jnb	acc.7,L013001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:263: TMR3CN &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN,#0x7F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:260: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L013004?
L013007?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:265: TMR3CN = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:268: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:271: for(j=ms; j!=0; j--)
L014001?:
	cjne	r2,#0x00,L014010?
	cjne	r3,#0x00,L014010?
	ret
L014010?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:273: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:274: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:275: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:276: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:271: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L014011?
	dec	r3
L014011?:
	sjmp	L014001?
;------------------------------------------------------------
;Allocation info for local variables in function 'waitsec'
;------------------------------------------------------------
;sec                       Allocated to registers r2 r3 
;i                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:280: void waitsec (unsigned int sec)
;	-----------------------------------------
;	 function waitsec
;	-----------------------------------------
_waitsec:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:283: for (i = sec; i!=0; i--)
L015001?:
	cjne	r2,#0x00,L015010?
	cjne	r3,#0x00,L015010?
	ret
L015010?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:285: waitms(250);
	mov	dptr,#0x00FA
	push	ar2
	push	ar3
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:286: waitms(250);
	mov	dptr,#0x00FA
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:287: waitms(250);
	mov	dptr,#0x00FA
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:288: waitms(250);
	mov	dptr,#0x00FA
	lcall	_waitms
	pop	ar3
	pop	ar2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:283: for (i = sec; i!=0; i--)
	dec	r2
	cjne	r2,#0xff,L015011?
	dec	r3
L015011?:
	sjmp	L015001?
;------------------------------------------------------------
;Allocation info for local variables in function 'speed'
;------------------------------------------------------------
;motor                     Allocated with name '_speed_PARM_2'
;backward                  Allocated with name '_speed_PARM_3'
;percent                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:292: void speed(int percent, int motor, int backward)
;	-----------------------------------------
;	 function speed
;	-----------------------------------------
_speed:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:295: if(motor == 0)
	mov	a,_speed_PARM_2
	orl	a,(_speed_PARM_2 + 1)
	jnz	L016016?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:297: if(!backward){
	mov	a,_speed_PARM_3
	orl	a,(_speed_PARM_3 + 1)
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:298: percentage0 = 0;
	jnz	L016002?
	mov	_percentage0,a
	mov	(_percentage0 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:299: percentage1 = percent;
	mov	_percentage1,r2
	mov	(_percentage1 + 1),r3
	ret
L016002?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:302: percentage0 = percent;
	mov	_percentage0,r2
	mov	(_percentage0 + 1),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:303: percentage1 = 0;
	clr	a
	mov	_percentage1,a
	mov	(_percentage1 + 1),a
	ret
L016016?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:308: else if(motor == 1)
	mov	a,#0x01
	cjne	a,_speed_PARM_2,L016028?
	clr	a
	cjne	a,(_speed_PARM_2 + 1),L016028?
	sjmp	L016029?
L016028?:
	sjmp	L016013?
L016029?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:310: if(!backward){
	mov	a,_speed_PARM_3
	orl	a,(_speed_PARM_3 + 1)
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:311: percentage2 = 0;
	jnz	L016005?
	mov	_percentage2,a
	mov	(_percentage2 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:312: percentage3 = percent;
	mov	_percentage3,r2
	mov	(_percentage3 + 1),r3
	ret
L016005?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:315: percentage2 = percent;
	mov	_percentage2,r2
	mov	(_percentage2 + 1),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:316: percentage3 = 0;
	clr	a
	mov	_percentage3,a
	mov	(_percentage3 + 1),a
	ret
L016013?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:321: else if(motor == 2)
	mov	a,#0x02
	cjne	a,_speed_PARM_2,L016031?
	clr	a
	cjne	a,(_speed_PARM_2 + 1),L016031?
	sjmp	L016032?
L016031?:
	ret
L016032?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:323: if(!backward){
	mov	a,_speed_PARM_3
	orl	a,(_speed_PARM_3 + 1)
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:324: percentage0 = 0;
	jnz	L016008?
	mov	_percentage0,a
	mov	(_percentage0 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:325: percentage1 = percent;
	mov	_percentage1,r2
	mov	(_percentage1 + 1),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:326: percentage2 = 0;
	clr	a
	mov	_percentage2,a
	mov	(_percentage2 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:327: percentage3 = percent;
	mov	_percentage3,r2
	mov	(_percentage3 + 1),r3
	ret
L016008?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:331: percentage0 = percent;
	mov	_percentage0,r2
	mov	(_percentage0 + 1),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:332: percentage1 = 0;
	clr	a
	mov	_percentage1,a
	mov	(_percentage1 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:333: percentage2 = percent;
	mov	_percentage2,r2
	mov	(_percentage2 + 1),r3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:334: percentage3 = 0;
	clr	a
	mov	_percentage3,a
	mov	(_percentage3 + 1),a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'stop'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:339: void stop(void)
;	-----------------------------------------
;	 function stop
;	-----------------------------------------
_stop:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:342: speed(0,2,0);
	mov	_speed_PARM_2,#0x02
	clr	a
	mov	(_speed_PARM_2 + 1),a
	clr	a
	mov	_speed_PARM_3,a
	mov	(_speed_PARM_3 + 1),a
	mov	dpl,a
	mov	dph,a
	ljmp	_speed
;------------------------------------------------------------
;Allocation info for local variables in function 'turnRight'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:345: void turnRight(void)
;	-----------------------------------------
;	 function turnRight
;	-----------------------------------------
_turnRight:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:348: speed(100,1,backwardsFlag);
	mov	_speed_PARM_2,#0x01
	clr	a
	mov	(_speed_PARM_2 + 1),a
	mov	_speed_PARM_3,_backwardsFlag
	mov	(_speed_PARM_3 + 1),(_backwardsFlag + 1)
	mov	dptr,#0x0064
	lcall	_speed
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:350: speed(0,0,backwardsFlag);
	clr	a
	mov	_speed_PARM_2,a
	mov	(_speed_PARM_2 + 1),a
	mov	_speed_PARM_3,_backwardsFlag
	mov	(_speed_PARM_3 + 1),(_backwardsFlag + 1)
	mov	dptr,#0x0000
	ljmp	_speed
;------------------------------------------------------------
;Allocation info for local variables in function 'turnLeft'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:353: void turnLeft(void)
;	-----------------------------------------
;	 function turnLeft
;	-----------------------------------------
_turnLeft:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:356: speed(100,0,backwardsFlag);
	clr	a
	mov	_speed_PARM_2,a
	mov	(_speed_PARM_2 + 1),a
	mov	_speed_PARM_3,_backwardsFlag
	mov	(_speed_PARM_3 + 1),(_backwardsFlag + 1)
	mov	dptr,#0x0064
	lcall	_speed
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:358: speed(0,1,backwardsFlag);
	mov	_speed_PARM_2,#0x01
	clr	a
	mov	(_speed_PARM_2 + 1),a
	mov	_speed_PARM_3,_backwardsFlag
	mov	(_speed_PARM_3 + 1),(_backwardsFlag + 1)
	mov	dptr,#0x0000
	ljmp	_speed
;------------------------------------------------------------
;Allocation info for local variables in function 'forward'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:361: void forward(void)
;	-----------------------------------------
;	 function forward
;	-----------------------------------------
_forward:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:364: speed(100,2,backwardsFlag);
	mov	_speed_PARM_2,#0x02
	clr	a
	mov	(_speed_PARM_2 + 1),a
	mov	_speed_PARM_3,_backwardsFlag
	mov	(_speed_PARM_3 + 1),(_backwardsFlag + 1)
	mov	dptr,#0x0064
	ljmp	_speed
;------------------------------------------------------------
;Allocation info for local variables in function 'backward'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:367: void backward(void)
;	-----------------------------------------
;	 function backward
;	-----------------------------------------
_backward:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:370: speed(100,2,backwardsFlag);
	mov	_speed_PARM_2,#0x02
	clr	a
	mov	(_speed_PARM_2 + 1),a
	mov	_speed_PARM_3,_backwardsFlag
	mov	(_speed_PARM_3 + 1),(_backwardsFlag + 1)
	mov	dptr,#0x0064
	ljmp	_speed
;------------------------------------------------------------
;Allocation info for local variables in function 'rotate180'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:373: void rotate180(void)
;	-----------------------------------------
;	 function rotate180
;	-----------------------------------------
_rotate180:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:376: turnRight();
	lcall	_turnRight
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:377: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:378: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:379: waitms(1000);
	mov	dptr,#0x03E8
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:433: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:435: LCD_E=1;
	setb	_P0_3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:436: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:437: LCD_E=0;
	clr	_P0_3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:440: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:443: ACC=x; //Send high nible
	mov	_ACC,r2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:444: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:445: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:446: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:447: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P0_2,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:448: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:449: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:450: ACC=x; //Send low nible
	mov	_ACC,r2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:451: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:452: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:453: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:454: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P0_2,c
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:455: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:458: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:460: LCD_RS=1;
	setb	_P0_5
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:461: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:462: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:465: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:467: LCD_RS=0;
	clr	_P0_5
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:468: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:469: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:472: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:474: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P0_3
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:475: LCD_RW=0; // We are only writing to the LCD in this program
	clr	_P0_4
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:476: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:478: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:479: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:480: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:483: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:484: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:485: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:486: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:489: void LCDprint(char * string, unsigned char line, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:493: WriteCommand(line==2?0xc0:0x80);
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L028013?
	mov	r5,#0xC0
	sjmp	L028014?
L028013?:
	mov	r5,#0x80
L028014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:494: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:495: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L028003?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L028006?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L028003?
	inc	r6
	sjmp	L028003?
L028006?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:496: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_3,L028011?
	mov	ar2,r5
	mov	ar3,r6
L028007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L028011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L028007?
	inc	r3
	sjmp	L028007?
L028011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getKey'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:509: char getKey(void)
;	-----------------------------------------
;	 function getKey
;	-----------------------------------------
_getKey:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:511: if(!RI) return 0;
	jb	_RI,L029002?
	mov	dpl,#0x00
	ret
L029002?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:513: RI=0;
	clr	_RI
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:514: switch(toupper(SBUF))
	mov	dpl,_SBUF
	lcall	_islower
	mov	a,dpl
	jz	L029016?
	mov	r2,_SBUF
	anl	ar2,#0xDF
	sjmp	L029017?
L029016?:
	mov	r2,_SBUF
L029017?:
	cjne	r2,#0x20,L029030?
	sjmp	L029005?
L029030?:
	cjne	r2,#0x44,L029031?
	sjmp	L029006?
L029031?:
	cjne	r2,#0x45,L029032?
	sjmp	L029003?
L029032?:
	cjne	r2,#0x46,L029033?
	sjmp	L029004?
L029033?:
	cjne	r2,#0x50,L029034?
	sjmp	L029009?
L029034?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:516: case 'E': return KEY_UP;
	cjne	r2,#0x53,L029013?
	sjmp	L029007?
L029003?:
	mov	dpl,#0x01
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:517: case 'F': return KEY_RIGHT;
	ret
L029004?:
	mov	dpl,#0x02
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:518: case ' ': return KEY_ADC;
	ret
L029005?:
	mov	dpl,#0x05
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:519: case 'D': return KEY_DOWN;
	ret
L029006?:
	mov	dpl,#0x03
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:520: case 'S': return KEY_LEFT;
	ret
L029007?:
	mov	dpl,#0x04
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:522: while(!RI);
	ret
L029009?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:523: RI=0;
	jbc	_RI,L029036?
	sjmp	L029009?
L029036?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:526: }
L029013?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:527: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:531: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:535: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:537: "Check pins P2.3 and P2.4 with the oscilloscope.\r\n");
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:539: percentage0 = 0;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:540: percentage1 = 0;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:541: percentage2 = 0;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:542: percentage3 = 0;
	clr	a
	mov	_percentage0,a
	mov	(_percentage0 + 1),a
	mov	_percentage1,a
	mov	(_percentage1 + 1),a
	mov	_percentage2,a
	mov	(_percentage2 + 1),a
	mov	_percentage3,a
	mov	(_percentage3 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:545: InitPinADC(2, 1); // left
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:546: InitPinADC(2, 0); // right
	mov	_InitPinADC_PARM_2,#0x00
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:547: InitPinADC(1, 7); //middle
	mov	_InitPinADC_PARM_2,#0x07
	mov	dpl,#0x01
	lcall	_InitPinADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:548: InitPinADC(1, 5); // data
	mov	_InitPinADC_PARM_2,#0x05
	mov	dpl,#0x01
	lcall	_InitPinADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:550: UART1_Init(BAUDRATE);
	mov	dptr,#0xC200
	mov	b,#0x01
	clr	a
	lcall	_UART1_Init
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:551: InitADC();	
	lcall	_InitADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:552: LCD_4BIT();
	lcall	_LCD_4BIT
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:553: LCDprint("PWM F38x", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_2
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:556: while(1)
L030057?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:560: fieldLeft=ADC_at_Pin(LQFP32_MUX_P2_1); //Save ref peak voltage
	mov	dpl,#0x09
	lcall	_ADC_at_Pin
	mov	_fieldLeft,dpl
	mov	(_fieldLeft + 1),dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:561: fieldRight=ADC_at_Pin(LQFP32_MUX_P2_0); //Save ref peak voltage
	mov	dpl,#0x08
	lcall	_ADC_at_Pin
	mov	_fieldRight,dpl
	mov	(_fieldRight + 1),dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:562: fieldMiddle=ADC_at_Pin(LQFP32_MUX_P1_7); //Save ref peak voltage
	mov	dpl,#0x07
	lcall	_ADC_at_Pin
	mov	_fieldMiddle,dpl
	mov	(_fieldMiddle + 1),dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:578: printf("ADC @ Left  %u    ADC @ Right  %u ADC @ Middle  %u \n\r",fieldLeft,fieldRight,fieldMiddle);
	push	_fieldMiddle
	push	(_fieldMiddle + 1)
	push	_fieldRight
	push	(_fieldRight + 1)
	push	_fieldLeft
	push	(_fieldLeft + 1)
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf7
	mov	sp,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:583: if(taketurn){
	mov	a,_taketurn
	orl	a,(_taketurn + 1)
	jnz	L030085?
	ljmp	L030022?
L030085?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:584: if((fieldLeft - fieldRight) > 50){
	mov	a,_fieldLeft
	clr	c
	subb	a,_fieldRight
	mov	r2,a
	mov	a,(_fieldLeft + 1)
	subb	a,(_fieldRight + 1)
	mov	r3,a
	clr	c
	mov	a,#0x32
	subb	a,r2
	clr	a
	subb	a,r3
	jnc	L030008?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:585: printf("turning left\n\r");
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:586: LCDprint("<- Turn right",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_5
	mov	b,#0x80
	lcall	_LCDprint
	ljmp	L030023?
L030008?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:589: else if((fieldRight - fieldLeft) > 50){
	mov	a,_fieldRight
	clr	c
	subb	a,_fieldLeft
	mov	r2,a
	mov	a,(_fieldRight + 1)
	subb	a,(_fieldLeft + 1)
	mov	r3,a
	clr	c
	mov	a,#0x32
	subb	a,r2
	clr	a
	subb	a,r3
	jnc	L030005?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:590: printf("turning right\n\r");
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:591: LCDprint("-> Turn left",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_7
	mov	b,#0x80
	lcall	_LCDprint
	ljmp	L030023?
L030005?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:596: else if((fieldRight - fieldLeft < 30) || (fieldLeft - fieldRight< 30))
	mov	a,_fieldRight
	clr	c
	subb	a,_fieldLeft
	mov	r2,a
	mov	a,(_fieldRight + 1)
	subb	a,(_fieldLeft + 1)
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,#0x1E
	mov	a,r3
	subb	a,#0x00
	jc	L030001?
	mov	a,_fieldLeft
	clr	c
	subb	a,_fieldRight
	mov	r2,a
	mov	a,(_fieldLeft + 1)
	subb	a,(_fieldRight + 1)
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,#0x1E
	mov	a,r3
	subb	a,#0x00
	jc	L030089?
	ljmp	L030023?
L030089?:
L030001?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:598: printf("forward\n\r");
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:599: LCDprint("^ Go forward",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_9
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:600: forward();
	lcall	_forward
	ljmp	L030023?
L030022?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:604: else if(!taketurn){	
	mov	a,_taketurn
	orl	a,(_taketurn + 1)
	jz	L030090?
	ljmp	L030023?
L030090?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:605: if((fieldRight - fieldLeft) > 50){
	mov	a,_fieldRight
	clr	c
	subb	a,_fieldLeft
	mov	r2,a
	mov	a,(_fieldRight + 1)
	subb	a,(_fieldLeft + 1)
	mov	r3,a
	clr	c
	mov	a,#0x32
	subb	a,r2
	clr	a
	subb	a,r3
	jnc	L030017?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:606: printf("Turn right\n\r");
	mov	a,#__str_10
	push	acc
	mov	a,#(__str_10 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:607: LCDprint("-> Turn right",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_11
	mov	b,#0x80
	lcall	_LCDprint
	ljmp	L030023?
L030017?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:610: else if((fieldLeft - fieldRight) > 50){
	mov	a,_fieldLeft
	clr	c
	subb	a,_fieldRight
	mov	r2,a
	mov	a,(_fieldLeft + 1)
	subb	a,(_fieldRight + 1)
	mov	r3,a
	clr	c
	mov	a,#0x32
	subb	a,r2
	clr	a
	subb	a,r3
	jnc	L030014?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:611: printf("Turn left\n\r");
	mov	a,#__str_12
	push	acc
	mov	a,#(__str_12 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:612: LCDprint("<- Turn left",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_13
	mov	b,#0x80
	lcall	_LCDprint
	sjmp	L030023?
L030014?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:617: else if((fieldRight - fieldLeft < 30) || (fieldLeft - fieldRight< 30))
	mov	a,_fieldRight
	clr	c
	subb	a,_fieldLeft
	mov	r2,a
	mov	a,(_fieldRight + 1)
	subb	a,(_fieldLeft + 1)
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,#0x1E
	mov	a,r3
	subb	a,#0x00
	jc	L030010?
	mov	a,_fieldLeft
	clr	c
	subb	a,_fieldRight
	mov	r2,a
	mov	a,(_fieldLeft + 1)
	subb	a,(_fieldRight + 1)
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,#0x1E
	mov	a,r3
	subb	a,#0x00
	jnc	L030023?
L030010?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:619: printf("forward\n\r");
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:620: LCDprint("^ Go forward",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_9
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:621: forward();
	lcall	_forward
L030023?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:625: taketurn = !taketurn;
	mov	a,_taketurn
	orl	a,(_taketurn + 1)
	cjne	a,#0x01,L030095?
L030095?:
	clr	a
	rlc	a
	mov	r2,a
	mov	_taketurn,r2
	mov	(_taketurn + 1),#0x00
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:628: if((fieldRight < 3 && fieldLeft < 3 && fieldMiddle < 3))
	clr	c
	mov	a,_fieldRight
	subb	a,#0x03
	mov	a,(_fieldRight + 1)
	subb	a,#0x00
	jc	L030096?
	ljmp	L030031?
L030096?:
	clr	c
	mov	a,_fieldLeft
	subb	a,#0x03
	mov	a,(_fieldLeft + 1)
	subb	a,#0x00
	jc	L030097?
	ljmp	L030031?
L030097?:
	clr	c
	mov	a,_fieldMiddle
	subb	a,#0x03
	mov	a,(_fieldMiddle + 1)
	subb	a,#0x00
	jc	L030098?
	ljmp	L030031?
L030098?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:633: printf("no field detected, reading instruction\n\r");
	mov	a,#__str_14
	push	acc
	mov	a,#(__str_14 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:634: numPulse = 0;
	clr	a
	mov	_numPulse,a
	mov	(_numPulse + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:635: dataloopcount = 100;
	mov	_dataloopcount,#0x64
	clr	a
	mov	(_dataloopcount + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:636: while(dataloopcount > 0)
L030027?:
	mov	a,_dataloopcount
	orl	a,(_dataloopcount + 1)
	jz	L030031?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:638: if(ADC_at_Pin(LQFP32_MUX_P1_5)>200){
	mov	dpl,#0x05
	lcall	_ADC_at_Pin
	mov	r2,dpl
	mov	r3,dph
	clr	c
	mov	a,#0xC8
	subb	a,r2
	clr	a
	subb	a,r3
	jnc	L030025?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:639: logic = 1;
	mov	_logic,#0x01
	clr	a
	mov	(_logic + 1),a
	sjmp	L030026?
L030025?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:643: logic = 0;
	clr	a
	mov	_logic,a
	mov	(_logic + 1),a
L030026?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:645: numPulse += logic;
	mov	a,_logic
	add	a,_numPulse
	mov	_numPulse,a
	mov	a,(_logic + 1)
	addc	a,(_numPulse + 1)
	mov	(_numPulse + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:646: printf("Number of pulses : %d\r", numPulse);
	push	_numPulse
	push	(_numPulse + 1)
	mov	a,#__str_15
	push	acc
	mov	a,#(__str_15 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:647: waitms(30);
	mov	dptr,#0x001E
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:649: dataloopcount --;
	dec	_dataloopcount
	mov	a,#0xff
	cjne	a,_dataloopcount,L030101?
	dec	(_dataloopcount + 1)
L030101?:
	sjmp	L030027?
L030031?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:654: if((fieldLeft > 650) && (fieldRight > 650) && (fieldMiddle > 700)){
	clr	c
	mov	a,#0x8A
	subb	a,_fieldLeft
	mov	a,#0x02
	subb	a,(_fieldLeft + 1)
	jc	L030102?
	ljmp	L030052?
L030102?:
	clr	c
	mov	a,#0x8A
	subb	a,_fieldRight
	mov	a,#0x02
	subb	a,(_fieldRight + 1)
	jc	L030103?
	ljmp	L030052?
L030103?:
	clr	c
	mov	a,#0xBC
	subb	a,_fieldMiddle
	mov	a,#0x02
	subb	a,(_fieldMiddle + 1)
	jc	L030104?
	ljmp	L030052?
L030104?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:655: printf("stop\n\r");
	mov	a,#__str_16
	push	acc
	mov	a,#(__str_16 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:656: stop();
	lcall	_stop
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:657: waitms(100);
	mov	dptr,#0x0064
	lcall	_waitms
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:658: printf("intersection detected\n\r");
	mov	a,#__str_17
	push	acc
	mov	a,#(__str_17 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:660: if(numPulse < 5){
	clr	c
	mov	a,_numPulse
	subb	a,#0x05
	mov	a,(_numPulse + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L030047?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:661: printf("               Go forward straight\r");
	mov	a,#__str_18
	push	acc
	mov	a,#(__str_18 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:662: LCDprint(" ^ Go straight",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_19
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:663: forward();
	lcall	_forward
	ljmp	L030053?
L030047?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:667: else if(numPulse < 20){ 
	clr	c
	mov	a,_numPulse
	subb	a,#0x14
	mov	a,(_numPulse + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L030044?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:668: printf("                         Turn right\r");
	mov	a,#__str_20
	push	acc
	mov	a,#(__str_20 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:669: LCDprint("<- Turn Left",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_21
	mov	b,#0x80
	lcall	_LCDprint
	ljmp	L030053?
L030044?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:674: else if(numPulse < 40){
	clr	c
	mov	a,_numPulse
	subb	a,#0x28
	mov	a,(_numPulse + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L030041?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:675: printf("                          Turn 180\r");
	mov	a,#__str_22
	push	acc
	mov	a,#(__str_22 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:676: LCDprint("Rotate 180",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_23
	mov	b,#0x80
	lcall	_LCDprint
	ljmp	L030053?
L030041?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:680: else if(numPulse < 65){ 
	clr	c
	mov	a,_numPulse
	subb	a,#0x41
	mov	a,(_numPulse + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L030038?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:681: printf("                        Turn left\r");
	mov	a,#__str_24
	push	acc
	mov	a,#(__str_24 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:682: LCDprint("-> Turn right",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_11
	mov	b,#0x80
	lcall	_LCDprint
	sjmp	L030053?
L030038?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:687: else if(numPulse < 80){ 
	clr	c
	mov	a,_numPulse
	subb	a,#0x50
	mov	a,(_numPulse + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L030035?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:688: backwardsFlag = 0;//////////////////////////////////////
	clr	a
	mov	_backwardsFlag,a
	mov	(_backwardsFlag + 1),a
	sjmp	L030053?
L030035?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:696: printf("			Entering forwards mode\r");
	mov	a,#__str_25
	push	acc
	mov	a,#(__str_25 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	sjmp	L030053?
L030052?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:701: else if(numPulse < 100){ 
	clr	c
	mov	a,_numPulse
	subb	a,#0x64
	mov	a,(_numPulse + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L030053?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:702: printf("        	                   Stop\r");
	mov	a,#__str_26
	push	acc
	mov	a,#(__str_26 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:703: stop();
	lcall	_stop
L030053?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:706: waitsec(1);
	mov	dptr,#0x0001
	lcall	_waitsec
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\f38x_04_04.c:707: numPulse = 0;
	clr	a
	mov	_numPulse,a
	mov	(_numPulse + 1),a
	ljmp	L030057?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 0x1B
	db '[2J'
	db 0x00
__str_1:
	db 'Square wave generator for the F38x.'
	db 0x0D
	db 0x0A
	db 'Check pins P2.3 and P2.'
	db '4 with the oscilloscope.'
	db 0x0D
	db 0x0A
	db 0x00
__str_2:
	db 'PWM F38x'
	db 0x00
__str_3:
	db 'ADC @ Left  %u    ADC @ Right  %u ADC @ Middle  %u '
	db 0x0A
	db 0x0D
	db 0x00
__str_4:
	db 'turning left'
	db 0x0A
	db 0x0D
	db 0x00
__str_5:
	db '<- Turn right'
	db 0x00
__str_6:
	db 'turning right'
	db 0x0A
	db 0x0D
	db 0x00
__str_7:
	db '-> Turn left'
	db 0x00
__str_8:
	db 'forward'
	db 0x0A
	db 0x0D
	db 0x00
__str_9:
	db '^ Go forward'
	db 0x00
__str_10:
	db 'Turn right'
	db 0x0A
	db 0x0D
	db 0x00
__str_11:
	db '-> Turn right'
	db 0x00
__str_12:
	db 'Turn left'
	db 0x0A
	db 0x0D
	db 0x00
__str_13:
	db '<- Turn left'
	db 0x00
__str_14:
	db 'no field detected, reading instruction'
	db 0x0A
	db 0x0D
	db 0x00
__str_15:
	db 'Number of pulses : %d'
	db 0x0D
	db 0x00
__str_16:
	db 'stop'
	db 0x0A
	db 0x0D
	db 0x00
__str_17:
	db 'intersection detected'
	db 0x0A
	db 0x0D
	db 0x00
__str_18:
	db '               Go forward straight'
	db 0x0D
	db 0x00
__str_19:
	db ' ^ Go straight'
	db 0x00
__str_20:
	db '                         Turn right'
	db 0x0D
	db 0x00
__str_21:
	db '<- Turn Left'
	db 0x00
__str_22:
	db '                          Turn 180'
	db 0x0D
	db 0x00
__str_23:
	db 'Rotate 180'
	db 0x00
__str_24:
	db '                        Turn left'
	db 0x0D
	db 0x00
__str_25:
	db 0x09
	db 0x09
	db 0x09
	db 'Entering forwards mode'
	db 0x0D
	db 0x00
__str_26:
	db '        '
	db 0x09
	db '                   Stop'
	db 0x0D
	db 0x00

	CSEG

end
