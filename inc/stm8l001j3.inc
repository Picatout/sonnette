;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2024/12/04
; STM8L001J3M3 µC registers map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.module stm8s001J3
	

; HSI clock frequency
 Fmaster = 16000000

; controller memory regions
RAM_SIZE = (1536) 
FLASH_SIZE = (8192)
PAGE_SIZE= (64)

 RAM_BASE = (0)
 RAM_END = (RAM_BASE+RAM_SIZE-1)
 SFR_BASE = (0x5000)
 SFR_END = (0x57FF)
 FLASH_BASE = (0x8000)
 FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
 OPTION_BASE = (0x4800)
 OPTION_END = (0x48FF)

; options bytes
; can be programmed only from SWIM  (ICP)
 OPT1  = (0x4800)   ; read out protrection
 OPT2  = (0x4802)   ; user boot code 
 OPT3  = (0x4803)   ; EEPROM size at end of flash memory
 OPT4  = (0x4808)   ; IWDG options  

; read out protection 
 ROP = OPT1 ; writ 0xAA for protection 
; user boot code protection 
 UBC = OPT2 ; 0..127 pages 

 IWDGOPT_HW = 0 ; IWDG activated by hardware 
 IWDGOPT_HALT = 1 ; IWDG  stopped in HALT mode 

; port bit
 PIN0 = (0) 
 PIN1 = (1)
 PIN2 = (2)
 PIN3 = (3)
 PIN4 = (4)
 PIN5 = (5)
 PIN6 = (6)
 PIN7 = (7)

GPIO_BASE = (0x5000)
GPIO_SIZE = (5)
; PORTS SFR OFFSET
PA = (0x5000)
PB = (0x5005)
PC = (0x500A)
PD = (0x500F)
PE = (0x5014)
PF = (0x5019)

GPIO_ODR = (0)
GPIO_IDR = (1)
GPIO_DDR = (2)
GPIO_CR1 = (3)
GPIO_CR2 = (4)

; GPIO
 PA_ODR  = (0x5000)
 PA_IDR  = (0x5001)
 PA_DDR  = (0x5002)
 PA_CR1  = (0x5003)
 PA_CR2  = (0x5004)

 PB_ODR  = (0x5005)
 PB_IDR  = (0x5006)
 PB_DDR  = (0x5007)
 PB_CR1  = (0x5008)
 PB_CR2  = (0x5009)

 PC_ODR  = (0x500A)
 PC_IDR  = (0x500B)
 PC_DDR  = (0x500C)
 PC_CR1  = (0x500D)
 PC_CR2  = (0x500E)

 PD_ODR  = (0x500F)
 PD_IDR  = (0x5010)
 PD_DDR  = (0x5011)
 PD_CR1  = (0x5012)
 PD_CR2  = (0x5013)


; input modes CR1
 INPUT_FLOAT = (0)
 INPUT_PULLUP = (1)
; output mode CR1
 OUTPUT_OD = (0)
 OUTPUT_PP = (1)
; input modes CR2
 INPUT_DI = (0)
 INPUT_EI = (1)
; output speed CR2
 OUTPUT_SLOW = (0)
 OUTPUT_FAST = (1)


; Flash
 FLASH_CR1  = (0x5050)
 FLASH_CR2  = (0x5051)
 FLASH_PUKR  = (0x5052)
 FLASH_DUKR  = (0x5053)
 FLASH_IAPSR  = (0x5054)

; data memory unlock keys
 FLASH_DUKR_KEY1 = (0xae)
 FLASH_DUKR_KEY2 = (0x56)
; flash memory unlock keys
 FLASH_PUKR_KEY1 = (0x56)
 FLASH_PUKR_KEY2 = (0xae)
; FLASH_CR1 bits
 FLASH_CR1_HALT = (3)
 FLASH_CR1_AHALT = (2)
 FLASH_CR1_IE = (1)
 FLASH_CR1_FIX = (0)
; FLASH_CR2 bits
 FLASH_CR2_OPT = (7)
 FLASH_CR2_WPRG = (6)
 FLASH_CR2_ERASE = (5)
 FLASH_CR2_FPRG = (4)
 FLASH_CR2_PRG = (0)
; FLASH_IAPSR bits
 FLASH_IAPSR_HVOFF = (6)
 FLASH_IAPSR_DUL = (3)
 FLASH_IAPSR_EOP = (2)
 FLASH_IAPSR_PUL = (1)
 FLASH_IAPSR_WR_PG_DIS = (0)

; Interrupt control
EXTI_CR1  = (0x50A0)
EXTI_CR2  = (0x50A1)
EXTI_CR3  = (0x50A2)
EXTI_SR1  = (0x50A3)
EXTI_SR2  = (0x50A4)
EXTI_CONF = (0x50A5)

; WFE controls registers 
WFE_CR1   = (0x50A6)
WFE_CR2   = (0x50A7)

; Reset control and Status
 RST_CR = (0x50B0)
 RST_SR = (0x50B1)

; Clock Registers
 CLK_CKDIVR =(0x50C0)
 CLK_ECKR =(0x50C1)
 CLK_PCKENR = (0x50C3)
 CLK_CCOR = (0x50C5)

; Peripherals clock gating
; CLK_PCKENR
 CLK_PCKENR_AWU_BEEP= (6)
 CLK_PCKENR_USART = (5)
 CLK_PCKENR_SPI = (4)
 CLK_PCKENR_I2C = (3)
 CLK_PCKENR_TIM4 = (2)
 CLK_PCKENR_TIM3 = (1)
 CLK_PCKENR_TIM2 = (0)

; IWDG 
 IWDG_KR = (0x50E0)
 IWDG_PR = (0x50E1)
 IWDG_RLR = (0x50E2)

; AWU 
;  auto wake up
AWU_CSR1 =(0x50F0)
AWU_APR =(0x50F1)
AWU_TBR =(0x50F2)

; BEEP 
 BEEP_CSR = (0x50F3)

; SPI
 SPI_CR1  = (0x5200)
 SPI_CR2  = (0x5201)
 SPI_ICR  = (0x5202)
 SPI_SR  = (0x5203)
 SPI_DR  = (0x5204)

; I2C
 I2C_CR1  = (0x5210)
 I2C_CR2  = (0x5211)
 I2C_FREQR  = (0x5212)
 I2C_OARL  = (0x5213)
 I2C_OARH  = (0x5214)
 I2C_DR  = (0x5216)
 I2C_SR1  = (0x5217)
 I2C_SR2  = (0x5218)
 I2C_SR3  = (0x5219)
 I2C_ITR  = (0x521A)
 I2C_CCRL  = (0x521B)
 I2C_CCRH  = (0x521C)
 I2C_TRISER  = (0x521D)

 I2C_STD = 0 
 I2C_FAST = 1 

 I2C_CR1_NOSTRETCH = (7)
 I2C_CR1_ENGC = (6)
 I2C_CR1_PE = (0)

 I2C_CR2_SWRST = (7)
 I2C_CR2_POS = (3)
 I2C_CR2_ACK = (2)
 I2C_CR2_STOP = (1)
 I2C_CR2_START = (0)

 I2C_OARL_ADD=(1)
 I2C_OARL_ADD0 = (0)

 I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
 I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))

 I2C_OARH_ADDMODE = (7)
 I2C_OARH_ADDCONF = (6)
 I2C_OARH_ADD9 = (2)
 I2C_OARH_ADD8 = (1)

 I2C_SR1_TXE = (7)
 I2C_SR1_RXNE = (6)
 I2C_SR1_STOPF = (4)
 I2C_SR1_ADD10 = (3)
 I2C_SR1_BTF = (2)
 I2C_SR1_ADDR = (1)
 I2C_SR1_SB = (0)

 I2C_SR2_WUFH = (5)
 I2C_SR2_OVR = (3)
 I2C_SR2_AF = (2)
 I2C_SR2_ARLO = (1)
 I2C_SR2_BERR = (0)

 I2C_SR3_DUALF = (7)
 I2C_SR3_GENCALL = (4)
 I2C_SR3_TRA = (2)
 I2C_SR3_BUSY = (1)
 I2C_SR3_MSL = (0)

 I2C_ITR_ITBUFEN = (2)
 I2C_ITR_ITEVTEN = (1)
 I2C_ITR_ITERREN = (0)

; Precalculated values, all in KHz
 I2C_CCRH_16MHZ_FAST_400 = 0x80
 I2C_CCRL_16MHZ_FAST_400 = 0x0D
;
; Fast I2C mode max rise time = 300ns
; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.

 I2C_TRISER_16MHZ_FAST_400 = 0x05

 I2C_CCRH_16MHZ_FAST_320 = 0xC0
 I2C_CCRL_16MHZ_FAST_320 = 0x02
 I2C_TRISER_16MHZ_FAST_320 = 0x05

 I2C_CCRH_16MHZ_FAST_200 = 0x80
 I2C_CCRL_16MHZ_FAST_200 = 0x1A
 I2C_TRISER_16MHZ_FAST_200 = 0x05

 I2C_CCRH_16MHZ_STD_100 = 0x00
 I2C_CCRL_16MHZ_STD_100 = 0x50
;
; Standard I2C mode max rise time = 1000ns
; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.

 I2C_TRISER_16MHZ_STD_100 = 0x11

 I2C_CCRH_16MHZ_STD_50 = 0x00
 I2C_CCRL_16MHZ_STD_50 = 0xA0
 I2C_TRISER_16MHZ_STD_50 = 0x11

 I2C_CCRH_16MHZ_STD_20 = 0x01
 I2C_CCRL_16MHZ_STD_20 = 0x90
 I2C_TRISER_16MHZ_STD_20 = 0x11;

 I2C_READ = 1
 I2C_WRITE = 0

; baudrate constant for brr_value table access
B2400=0
B4800=1
B9600=2
B19200=3
B38400=4
B57600=5
B115200=6
B230400=7
B460800=8
B921600=9

; USART
 USART_SR    = (0x5230)
 USART_DR    = (0x5231)
 USART_BRR1  = (0x5232)
 USART_BRR2  = (0x5233)
 USART_CR1   = (0x5234)
 USART_CR2   = (0x5235)
 USART_CR3   = (0x5236)
 USART_CR4   = (0x5237)

; USART Status Register bits
 USART_SR_TXE = (7)
 USART_SR_TC = (6)
 USART_SR_RXNE = (5)
 USART_SR_IDLE = (4)
 USART_SR_OR = (3)
 USART_SR_NF = (2)
 USART_SR_FE = (1)
 USART_SR_PE = (0)

; Uart Control Register bits
 USART_CR1_R8 = (7)
 USART_CR1_T8 = (6)
 USART_CR1_USARTD = (5)
 USART_CR1_M = (4)
 USART_CR1_WAKE = (3)
 USART_CR1_PCEN = (2)
 USART_CR1_PS = (1)
 USART_CR1_PIEN = (0)

 USART_CR2_TIEN = (7)
 USART_CR2_TCIEN = (6)
 USART_CR2_RIEN = (5)
 USART_CR2_ILIEN = (4)
 USART_CR2_TEN = (3)
 USART_CR2_REN = (2)
 USART_CR2_RWU = (1)
 USART_CR2_SBK = (0)

 USART_CR3_LINEN = (6)
 USART_CR3_STOP1 = (5)
 USART_CR3_STOP0 = (4)
 USART_CR3_CLKEN = (3)
 USART_CR3_CPOL = (2)
 USART_CR3_CPHA = (1)
 USART_CR3_LBCL = (0)

 USART_CR4_LBDIEN = (6)
 USART_CR4_LBDL = (5)
 USART_CR4_LBDF = (4)
 USART_CR4_ADD3 = (3)
 USART_CR4_ADD2 = (2)
 USART_CR4_ADD1 = (1)
 USART_CR4_ADD0 = (0)

; TIMERS
; TIMER2 
 TIM2_CR1  = (0x5250)
 TIM2_CR2  = (0x5251)
 TIM2_SMCR  = (0x5252)
 TIM2_ETR  = (0x5253)
 TIM2_IER  = (0x5254)
 TIM2_SR1  = (0x5255)
 TIM2_SR2  = (0x5256)
 TIM2_EGR  = (0x5257)
 TIM2_CCMR1  = (0x5258)
 TIM2_CCMR2  = (0x5259)
 TIM2_CCER1  = (0x525A)
 TIM2_CNTRH  = (0x525B)
 TIM2_CNTRL  = (0x525C)
 TIM2_PSCR  = (0x525D)
 TIM2_ARRH  = (0x525E)
 TIM2_ARRL  = (0x525F)
 TIM2_CCR1H  = (0x5260)
 TIM2_CCR1L  = (0x5261)
 TIM2_CCR2H  = (0x5262)
 TIM2_CCR2L  = (0x5263)
 TIM2_BKR  = (0x5264)
 TIM2_OISR  = (0x5265)

; Timer 3 - 16-bit timer
TIM3_CR1 = (0x5280)
TIM3_CR2 = (0x5281)
TIM3_SMCR = (0x5282)
TIM3_ETR = (0x5283)
TIM3_IER = (0x5284)
TIM3_SR1 = (0x5285)
TIM3_SR2 = (0x5286)
TIM3_EGR = (0x5287)
TIM3_CCMR1 = (0x5288)
TIM3_CCMR2 = (0x5289)
TIM3_CCER1 = (0x528A)
TIM3_CNTRH = (0x528B)
TIM3_CNTRL = (0x528C)
TIM3_PSCR = (0x528D)
TIM3_ARRH = (0x528E)
TIM3_ARRL = (0x528F)
TIM3_CCR1H = (0x5290)
TIM3_CCR1L = (0x5291)
TIM3_CCR2H = (0x5292)
TIM3_CCR2L = (0x5293)
TIM3_BKR = (0x5294)
TIM3_OISR = (0x5295)

; TIM2 and TIM3 registers bits fields 
; Timer Control 1 
 TIM_CR1_ARPE = (7)
 TIM_CR1_CMS = (5) ; field 6:5
 TIM_CR1_DIR = (4)
 TIM_CR1_OPM = (3)
 TIM_CR1_URS = (2)
 TIM_CR1_UDIS = (1)
 TIM_CR1_CEN = (0)

 TIM_CR2_MMS = (4) ; field 6:4

; Timer Slave Mode Control bits
 TIM_SMCR_MSM = (7)
 TIM_SMCR_TS = (4) ; filed 6:4
 TIM_SMCR_SMS = (0) ; filed 2:0

; Timer External Trigger Enable bits
 TIM_ETR_ETP = (7)
 TIM_ETR_ECE = (6)
 TIM_ETR_ETPS = (4) ; field 5:4
 TIM_ETR_ETF = (0) ; field 3:0

; Timer Interrupt Enable bits
 TIM_IER_BIE = (7)
 TIM_IER_TIE = (6)
 TIM_IER_CC2IE = (2)
 TIM_IER_CC1IE = (1)
 TIM_IER_UIE = (0)

; Timer Status Register 1 bits
 TIM_SR1_BIF = (7)
 TIM_SR1_TIF = (6)
 TIM_SR1_CC2IF = (2)
 TIM_SR1_CC1IF = (1)
 TIM_SR1_UIF = (0)

; Timer status register 2 bits 
 TIM_SR2_CC2OF = (2)
 TIM_SR2_CC1OF = (1)

; Timer Event Generation Register bits
 TIM_EGR_BG = (7)
 TIM_EGR_TG = (6)
 TIM_EGR_CC2G = (2)
 TIM_EGR_CC1G = (1)
 TIM_EGR_UG = (0)

; Capture/Compare Mode Register 1 - channel configured in output
 TIM_CCMR1_OC1M = (4) ; field 6:4
 TIM_CCMR1_OC1PE = (3)
 TIM_CCMR1_OC1FE = (2)
 TIM_CCMR1_CC1S = (0) ; field 1:0

; Capture/Compare Mode Register 1 - channel configured in input
 TIM_CCMR1_IC1F = (4) ; field 7:4
 TIM_CCMR1_IC1PSC = (2) ; field 3:2
 TIM_CCMR1_CC1S = (0) ; field 1:0

; Capture/Compare Mode Register 2 - channel configured in output
 TIM_CCMR2_OC2M = (4) ; field 6:4
 TIM_CCMR2_OC2PE = (3)
 TIM_CCMR2_OC2FE = (2)
 TIM_CCMR2_CC2S0 = (0) ; field 1:0

; Capture/Compare Mode Register 2 - channel configured in input
 TIM_CCMR2_IC2F = (4) ; field 7:4 
 TIM_CCMR2_IC2PSC = (2) ; field 3:2 
 TIM_CCMR2_CC2S = (0) ; field 1:0

; Capture/compare enable register 1 (TIM_CCER1)
TIM_CCER1_CC2P = (5)
TIM_CCER1_CC2E = (4)
TIM_CCER1_CC1P = (1)
TIM_CCER1_CC1E = (0)

; Prescaler register (TIM_PSCR)
TIM_PSCR = (0) ; field 2:0

; Break register (TIM_BKR)
TIM_BKR_MOE = (7)
TIM_BKR_AOE = (6)
TIM_BKR_BKP = (5)
TIM_BKR_BKE = (4)
TIM_BKR_OSSI = (2)
TIM_BKR_LOCK = (0) ; field 1:0 

; Output idle state register (TIM_OISR) 
TIM_OISR_OIS2 = (2)
TIM_OISR_OIS1 = (0)


; Timer 4
TIM4_CR1 = (0x52E0)
TIM4_CR2 = (0x52E1)
TIM4_SMCR = (0X52E2)
TIM4_IER = (0x52E3)
TIM4_SR = (0x52E4)
TIM4_EGR = (0x52E5)
TIM4_CNTR = (0x52E6)
TIM4_PSCR = (0x52E7)
TIM4_ARR = (0x52E8)

; Timer 4 bitfields

 TIM4_CR1_ARPE = (7)
 TIM4_CR1_OPM = (3)
 TIM4_CR1_URS = (2)
 TIM4_CR1_UDIS = (1)
 TIM4_CR1_CEN = (0)

 TIM4_IER_UIE = (0)

 TIM4_SR_UIF = (0)

 TIM4_EGR_UG = (0)

 TIM4_PSCR_PSC2 = (2)
 TIM4_PSCR_PSC1 = (1)
 TIM4_PSCR_PSC0 = (0)

 TIM4_PSCR_1 = 0
 TIM4_PSCR_2 = 1
 TIM4_PSCR_4 = 2
 TIM4_PSCR_8 = 3
 TIM4_PSCR_16 = 4
 TIM4_PSCR_32 = 5
 TIM4_PSCR_64 = 6
 TIM4_PSCR_128 = 7

; IRTIM infrared control register 
 IR_CR = (0x52FF)

; comparator 1
 COMP_CR = (0x5300)
 COMP_CSR = (0x5301)
 COMP_CCS = (0x5302)

; CPU
 CPU_A  = (0x7F00)
 CPU_PCE  = (0x7F01)
 CPU_PCH  = (0x7F02)
 CPU_PCL  = (0x7F03)
 CPU_XH  = (0x7F04)
 CPU_XL  = (0x7F05)
 CPU_YH  = (0x7F06)
 CPU_YL  = (0x7F07)
 CPU_SPH  = (0x7F08)
 CPU_SPL   = (0x7F09)
 CPU_CCR   = (0x7F0A)

; global configuration register
 CFG_GCR   = (0x7F60)
 CFG_GCR_SWD = (0)
 CFG_GCR_HALT = (1)	

; interrupt control registers
 ITC_SPR1   = (0x7F70)
 ITC_SPR2   = (0x7F71)
 ITC_SPR3   = (0x7F72)
 ITC_SPR4   = (0x7F73)
 ITC_SPR5   = (0x7F74)
 ITC_SPR6   = (0x7F75)
 ITC_SPR7   = (0x7F76)
 ITC_SPR8   = (0x7F77)

ITC_SPR_LEVEL1=1 
ITC_SPR_LEVEL2=0
ITC_SPR_LEVEL3=3 


; SWIM, control and status register
 SWIM_CSR   = (0x7F80)
; debug registers
 DM_BK1RE   = (0x7F90)
 DM_BK1RH   = (0x7F91)
 DM_BK1RL   = (0x7F92)
 DM_BK2RE   = (0x7F93)
 DM_BK2RH   = (0x7F94)
 DM_BK2RL   = (0x7F95)
 DM_CR1   = (0x7F96)
 DM_CR2   = (0x7F97)
 DM_CSR1   = (0x7F98)
 DM_CSR2   = (0x7F99)
 DM_ENFCTR   = (0x7F9A)

; vector 0 is reset 
; vector 1 is TRAP 
; Interrupt Numbers begin at vector 3
INT_FLASH = 1
INT_CLK = 2 
INT_AWU = 4
INT_EXTIB = 6
INT_EXTID = 7
INT_EXTI0 = 8
INT_EXTI1 = 9
INT_EXTI2 = 10
INT_EXTI3 = 11
INT_EXTI4 = 12
INT_EXTI5 = 13 
INT_EXTI6 = 14
INT_EXTI7 = 15
INT_COMP= 18 
INT_TIM2_OVF = 19
INT_TIM2_CC = 20
INT_TIM3_OVF = 21
INT_TIM3_CC = 22
INT_TIM4_OVF = 25
INT_SPI  = 26
INT_USART_TX = 27 
INT_USART_RX = 28 
INT_I2C = 29

; Interrupt Vector address
INT_VECTOR_RESET = 0x8000
INT_VECTOR_TRAP = 0x8004
INT_VECTOR_FLASH = 0x800C
INT_VECTOR_AWU = 0x8018
INT_VECTOR_EXTIB = 0x8020
INT_VECTOR_EXTID = 0x8024
INT_VECTOR_EXTI0 = 0x8028
INT_VECTOR_EXTI1 = 0x802C
INT_VECTOR_EXTI2 = 0x8030
INT_VECTOR_EXTI3 = 0x8024
INT_VECTOR_EXTI4 = 0x8038
INT_VECTOR_EXTI5 = 0x803C 
INT_VECTOR_EXTI6 = 0x8040
INT_VECTOR_EXTI7 = 0x8044
INT_VECTOR_COMP = 0x8050
INT_VECTOR_TIM2_OVF = 0x8054
INT_VECTOR_TIM2_CCM = 0x8058
INT_VECTOR_TIM3_OVF = 0x805C
INT_VECTOR_TIM3_CCM = 0x8060
INT_VECTOR_TIM4_OVF = 0x806C
INT_VECTOR_SPI  = 0x8070
INT_VECTOR_USART_TX_COMPLETE = 0x8074
INT_VECTOR_USART_RX_FULL = 0x8078
INT_VECTOR_I2C = 0x807C

