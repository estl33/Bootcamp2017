;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Thu Mar 30 10:38:34 2017
;--------------------------------------------------------
$name head_tracking
$optc51 --model-small
$printf_float
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
	public _InitPinADC_PARM_2
	public _main
	public _map
	public _waitms
	public _Delay_servo
	public _Timer2_ISR
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public _Timer3us
	public __c51_external_startup
	public _map_PARM_5
	public _map_PARM_4
	public _map_PARM_3
	public _map_PARM_2
	public _pwm_count
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
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_pwm_count:
	ds 1
_map_PARM_2:
	ds 2
_map_PARM_3:
	ds 2
_map_PARM_4:
	ds 2
_map_PARM_5:
	ds 2
_main_val_1_66:
	ds 2
_main_count_1_66:
	ds 2
_main_sval_x_1_66:
	ds 4
_main_sval_z_1_66:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
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
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:20: volatile unsigned char pwm_count=0;
	mov	_pwm_count,#0x00
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:23: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:25: PCA0MD&=(~0x40) ;    // DISABLE WDT: clear Watchdog Enable bit
	anl	_PCA0MD,#0xBF
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:32: CLKSEL|=0b_0000_0011; // SYSCLK derived from the Internal High-Frequency Oscillator / 1.
	orl	_CLKSEL,#0x03
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:36: OSCICN |= 0x03; // Configure internal oscillator for its maximum frequency
	orl	_OSCICN,#0x03
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:43: AMX0N = LQFP32_MUX_GND;  // GND is negative input (Single-ended Mode)
	mov	_AMX0N,#0x1F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:46: ADC0CF = 0xF8; // SAR clock = 31, Right-justified result
	mov	_ADC0CF,#0xF8
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:47: ADC0CN = 0b_1000_0000; // AD0EN=1, AD0TM=0
	mov	_ADC0CN,#0x80
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:48: REF0CN=0b_0000_1000; //Select VDD as the voltage reference
	mov	_REF0CN,#0x08
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:50: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:51: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:52: P0MDOUT|=0x11;     // Enable Uart TX as push-pull output, P0.0 as output
	orl	_P0MDOUT,#0x11
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:53: XBR0=0x01;         // Enable UART on P0.4(TX) and P0.5(RX)
	mov	_XBR0,#0x01
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:54: XBR1=0x40;         // Enable crossbar and weak pull-ups
	mov	_XBR1,#0x40
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:57: TH1 = 0x10000-((SYSCLK/BAUDRATE)/2L);
	mov	_TH1,#0x30
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:58: CKCON &= ~0x0B;                  // T1M = 1; SCA1:0 = xx
	anl	_CKCON,#0xF4
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:59: CKCON |=  0x08;
	orl	_CKCON,#0x08
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:73: TL1 = TH1;     // Init timer 1
	mov	_TL1,_TH1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:74: TMOD &= 0x0f;  // TMOD: timer 1 in 8-bit autoreload
	anl	_TMOD,#0x0F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:75: TMOD |= 0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:76: TR1 = 1;       // Start timer1
	setb	_TR1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:77: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:79: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:83: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:88: CKCON|=0b_0100_0000;
	orl	_CKCON,#0x40
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:90: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xD0
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:91: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:93: TMR3CN = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN,#0x04
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:94: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003007?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:96: while (!(TMR3CN & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN
	jnb	acc.7,L003001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:97: TMR3CN &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN,#0x7F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:94: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003004?
L003007?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:99: TMR3CN = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:102: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:105: ADC0CF = 0xF8; // SAR clock = 31, Right-justified result
	mov	_ADC0CF,#0xF8
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:106: ADC0CN = 0b_1000_0000; // AD0EN=1, AD0TM=0
	mov	_ADC0CN,#0x80
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:107: REF0CN = 0b_0000_1000; //Select VDD as the voltage reference for the converter
	mov	_REF0CN,#0x08
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pinno                     Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:110: void InitPinADC (unsigned char portno, unsigned char pinno)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:114: mask=1<<pinno;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L005012?
L005010?:
	add	a,acc
L005012?:
	djnz	b,L005010?
	mov	r3,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:116: switch (portno)
	mov	a,r2
	add	a,#0xff - 0x03
	jc	L005007?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L005014?
	jmp	@a+dptr
L005014?:
	ljmp	L005001?
	ljmp	L005002?
	ljmp	L005003?
	ljmp	L005004?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:118: case 0:
L005001?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:119: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	anl	_P0MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:120: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:121: break;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:122: case 1:
	ret
L005002?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:123: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	anl	_P1MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:124: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:125: break;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:126: case 2:
	ret
L005003?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:127: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	anl	_P2MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:128: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:129: break;
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:130: case 3:
	ret
L005004?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:131: P3MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P3MDIN,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:132: P3SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P3SKIP,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:136: }
L005007?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:139: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_AMX0P,dpl
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:142: AMX0N = LQFP32_MUX_GND;  // GND is negative input (Single-ended Mode)
	mov	_AMX0N,#0x1F
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:144: AD0BUSY=1;
	setb	_AD0BUSY
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:145: while (AD0BUSY); // Wait for dummy conversion to finish
L006001?:
	jb	_AD0BUSY,L006001?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:147: AD0BUSY = 1;
	setb	_AD0BUSY
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:148: while (AD0BUSY); // Wait for conversion to complete
L006004?:
	jb	_AD0BUSY,L006004?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:149: return (ADC0L+(ADC0H*0x100));
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
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:152: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:154: return ((ADC_at_Pin(pin)*3.30)/1024.0);
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
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:168: void Timer2_ISR (void) interrupt 5
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:177: }
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'Delay_servo'
;------------------------------------------------------------
;us                        Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:178: void Delay_servo(int us)
;	-----------------------------------------
;	 function Delay_servo
;	-----------------------------------------
_Delay_servo:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:180: while(us--)
L009001?:
	mov	ar4,r2
	mov	ar5,r3
	dec	r2
	cjne	r2,#0xff,L009009?
	dec	r3
L009009?:
	mov	a,r4
	orl	a,r5
	jnz	L009010?
	ret
L009010?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:182: nop();
	 
	 nop 
	 nop 
	 nop 
	 nop 
	 nop 
	 nop 
	 
	ljmp	L009001?
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:185: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:189: for(j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L010005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L010009?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:190: for (k=0; k<4; k++) Timer3us(250);
	mov	r6,#0x00
L010001?:
	cjne	r6,#0x04,L010018?
L010018?:
	jnc	L010007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L010001?
L010007?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:189: for(j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L010005?
	inc	r5
	sjmp	L010005?
L010009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'map'
;------------------------------------------------------------
;in_min                    Allocated with name '_map_PARM_2'
;in_max                    Allocated with name '_map_PARM_3'
;out_min                   Allocated with name '_map_PARM_4'
;out_max                   Allocated with name '_map_PARM_5'
;x                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:193: unsigned int map(unsigned x, unsigned int in_min, unsigned int in_max, unsigned int out_min, unsigned int out_max)
;	-----------------------------------------
;	 function map
;	-----------------------------------------
_map:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:195: return (((x - in_min)*(out_max - out_min) / (in_max - in_min)) + out_min);
	mov	a,r2
	clr	c
	subb	a,_map_PARM_2
	mov	dpl,a
	mov	a,r3
	subb	a,(_map_PARM_2 + 1)
	mov	dph,a
	mov	a,_map_PARM_5
	clr	c
	subb	a,_map_PARM_4
	mov	__mulint_PARM_2,a
	mov	a,(_map_PARM_5 + 1)
	subb	a,(_map_PARM_4 + 1)
	mov	(__mulint_PARM_2 + 1),a
	lcall	__mulint
	mov	r2,dpl
	mov	r3,dph
	mov	a,_map_PARM_3
	clr	c
	subb	a,_map_PARM_2
	mov	__divuint_PARM_2,a
	mov	a,(_map_PARM_3 + 1)
	subb	a,(_map_PARM_2 + 1)
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__divuint
	mov	a,dpl
	mov	b,dph
	add	a,_map_PARM_4
	mov	dpl,a
	mov	a,(_map_PARM_4 + 1)
	addc	a,b
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;val                       Allocated with name '_main_val_1_66'
;count                     Allocated with name '_main_count_1_66'
;sval_x                    Allocated with name '_main_sval_x_1_66'
;sval_z                    Allocated with name '_main_sval_z_1_66'
;------------------------------------------------------------
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:199: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:201: volatile unsigned int val=300;
	mov	_main_val_1_66,#0x2C
	mov	(_main_val_1_66 + 1),#0x01
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:205: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
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
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:207: "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");
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
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:208: out_x=0;
	clr	_P2_1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:209: out_z=0;
	clr	_P2_0
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:211: InitPinADC(2, 0); // Configure P2.0 as analog input
	mov	_InitPinADC_PARM_2,#0x00
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:212: InitPinADC(2, 1); // Configure P2.1 as analog input
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:214: while(1)
L012005?:
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:217: count=35;//change this to change responsiveness of motor to accelerom
	mov	_main_count_1_66,#0x23
	clr	a
	mov	(_main_count_1_66 + 1),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:218: sval_x = Volts_at_Pin(LQFP32_MUX_P2_1);
	mov	dpl,#0x09
	lcall	_Volts_at_Pin
	mov	_main_sval_x_1_66,dpl
	mov	(_main_sval_x_1_66 + 1),dph
	mov	(_main_sval_x_1_66 + 2),b
	mov	(_main_sval_x_1_66 + 3),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:219: sval_z = Volts_at_Pin(LQFP32_MUX_P2_0);
	mov	dpl,#0x08
	lcall	_Volts_at_Pin
	mov	_main_sval_z_1_66,dpl
	mov	(_main_sval_z_1_66 + 1),dph
	mov	(_main_sval_z_1_66 + 2),b
	mov	(_main_sval_z_1_66 + 3),a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:226: sval_x=174 ;
	mov	_main_sval_x_1_66,#0x00
	mov	(_main_sval_x_1_66 + 1),#0x00
	mov	(_main_sval_x_1_66 + 2),#0x2E
	mov	(_main_sval_x_1_66 + 3),#0x43
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:229: printf ("V_x @ P2.1 = %f, V_z @P2.0= %f \r", sval_z, sval_x);
	push	_main_sval_x_1_66
	push	(_main_sval_x_1_66 + 1)
	push	(_main_sval_x_1_66 + 2)
	push	(_main_sval_x_1_66 + 3)
	push	_main_sval_z_1_66
	push	(_main_sval_z_1_66 + 1)
	push	(_main_sval_z_1_66 + 2)
	push	(_main_sval_z_1_66 + 3)
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf5
	mov	sp,a
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:231: while(count--){
L012001?:
	mov	r2,_main_count_1_66
	mov	r3,(_main_count_1_66 + 1)
	dec	_main_count_1_66
	mov	a,#0xff
	cjne	a,_main_count_1_66,L012012?
	dec	(_main_count_1_66 + 1)
L012012?:
	mov	a,r2
	orl	a,r3
	jz	L012005?
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:233: out_x=1;	
	setb	_P2_1
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:234: Delay_servo((sval_x));
	mov	dpl,_main_sval_x_1_66
	mov	dph,(_main_sval_x_1_66 + 1)
	mov	b,(_main_sval_x_1_66 + 2)
	mov	a,(_main_sval_x_1_66 + 3)
	lcall	___fs2sint
	lcall	_Delay_servo
;	C:\Users\esther86220\Desktop\ELEC 291\Project 2\head_tracking.c:235: out_x=0;
	clr	_P2_1
	sjmp	L012001?
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
	db 'Check pins P2.0 and P2.'
	db '1 with the oscilloscope.'
	db 0x0D
	db 0x0A
	db 0x00
__str_2:
	db 'V_x @ P2.1 = %f, V_z @P2.0= %f '
	db 0x0D
	db 0x00

	CSEG

end
