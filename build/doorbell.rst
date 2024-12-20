ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2024 
                                      3 ; This file is part of doorbell.asm
                                      4 ;
                                      5 ;     doorbell.asm is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     doorbell.asm is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with doorbell.asm.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialisation
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23     .module HW_INIT 
                                     24 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     25 	.include "app_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of doorbell.asm 
                                      4 ;
                                      5 ;     doorbell.asm is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     doorbell.asm is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with doorbell.asm.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                                     19 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     20 	.include "inc/stm8l001j3.inc" 
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ; 2024/12/04
                                      3 ; STM8L001J3M3 µC registers map
                                      4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      5 	.module stm8s001J3
                                      6 	
                                      7 
                                      8 ; HSI clock frequency
                           F42400     9  Fmaster = 16000000
                                     10 
                                     11 ; controller memory regions
                           000600    12 RAM_SIZE = (1536) 
                           002000    13 FLASH_SIZE = (8192)
                           000040    14 PAGE_SIZE= (64)
                                     15 
                           000000    16  RAM_BASE = (0)
                           0005FF    17  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           005000    18  SFR_BASE = (0x5000)
                           0057FF    19  SFR_END = (0x57FF)
                           008000    20  FLASH_BASE = (0x8000)
                           009FFF    21  FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
                           004800    22  OPTION_BASE = (0x4800)
                           0048FF    23  OPTION_END = (0x48FF)
                                     24 
                                     25 ; options bytes
                                     26 ; can be programmed only from SWIM  (ICP)
                           004800    27  OPT1  = (0x4800)   ; read out protrection
                           004802    28  OPT2  = (0x4802)   ; user boot code 
                           004803    29  OPT3  = (0x4803)   ; EEPROM size at end of flash memory
                           004808    30  OPT4  = (0x4808)   ; IWDG options  
                                     31 
                                     32 ; read out protection 
                           004800    33  ROP = OPT1 ; writ 0xAA for protection 
                                     34 ; user boot code protection 
                           004802    35  UBC = OPT2 ; 0..127 pages 
                                     36 
                           000000    37  IWDGOPT_HW = 0 ; IWDG activated by hardware 
                           000001    38  IWDGOPT_HALT = 1 ; IWDG  stopped in HALT mode 
                                     39 
                                     40 ; port bit
                           000000    41  PIN0 = (0) 
                           000001    42  PIN1 = (1)
                           000002    43  PIN2 = (2)
                           000003    44  PIN3 = (3)
                           000004    45  PIN4 = (4)
                           000005    46  PIN5 = (5)
                           000006    47  PIN6 = (6)
                           000007    48  PIN7 = (7)
                                     49 
                           005000    50 GPIO_BASE = (0x5000)
                           000005    51 GPIO_SIZE = (5)
                                     52 ; PORTS SFR OFFSET
                           005000    53 PA = (0x5000)
                           005005    54 PB = (0x5005)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
Hexadecimal [24-Bits]



                           00500A    55 PC = (0x500A)
                           00500F    56 PD = (0x500F)
                           005014    57 PE = (0x5014)
                           005019    58 PF = (0x5019)
                                     59 
                           000000    60 GPIO_ODR = (0)
                           000001    61 GPIO_IDR = (1)
                           000002    62 GPIO_DDR = (2)
                           000003    63 GPIO_CR1 = (3)
                           000004    64 GPIO_CR2 = (4)
                                     65 
                                     66 ; GPIO
                           005000    67  PA_ODR  = (0x5000)
                           005001    68  PA_IDR  = (0x5001)
                           005002    69  PA_DDR  = (0x5002)
                           005003    70  PA_CR1  = (0x5003)
                           005004    71  PA_CR2  = (0x5004)
                                     72 
                           005005    73  PB_ODR  = (0x5005)
                           005006    74  PB_IDR  = (0x5006)
                           005007    75  PB_DDR  = (0x5007)
                           005008    76  PB_CR1  = (0x5008)
                           005009    77  PB_CR2  = (0x5009)
                                     78 
                           00500A    79  PC_ODR  = (0x500A)
                           00500B    80  PC_IDR  = (0x500B)
                           00500C    81  PC_DDR  = (0x500C)
                           00500D    82  PC_CR1  = (0x500D)
                           00500E    83  PC_CR2  = (0x500E)
                                     84 
                           00500F    85  PD_ODR  = (0x500F)
                           005010    86  PD_IDR  = (0x5010)
                           005011    87  PD_DDR  = (0x5011)
                           005012    88  PD_CR1  = (0x5012)
                           005013    89  PD_CR2  = (0x5013)
                                     90 
                                     91 
                                     92 ; input modes CR1
                           000000    93  INPUT_FLOAT = (0)
                           000001    94  INPUT_PULLUP = (1)
                                     95 ; output mode CR1
                           000000    96  OUTPUT_OD = (0)
                           000001    97  OUTPUT_PP = (1)
                                     98 ; input modes CR2
                           000000    99  INPUT_DI = (0)
                           000001   100  INPUT_EI = (1)
                                    101 ; output speed CR2
                           000000   102  OUTPUT_SLOW = (0)
                           000001   103  OUTPUT_FAST = (1)
                                    104 
                                    105 
                                    106 ; Flash
                           005050   107  FLASH_CR1  = (0x5050)
                           005051   108  FLASH_CR2  = (0x5051)
                           005052   109  FLASH_PUKR  = (0x5052)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                           005053   110  FLASH_DUKR  = (0x5053)
                           005054   111  FLASH_IAPSR  = (0x5054)
                                    112 
                                    113 ; data memory unlock keys
                           0000AE   114  FLASH_DUKR_KEY1 = (0xae)
                           000056   115  FLASH_DUKR_KEY2 = (0x56)
                                    116 ; flash memory unlock keys
                           000056   117  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   118  FLASH_PUKR_KEY2 = (0xae)
                                    119 ; FLASH_CR1 bits
                           000003   120  FLASH_CR1_HALT = (3)
                           000002   121  FLASH_CR1_AHALT = (2)
                           000001   122  FLASH_CR1_IE = (1)
                           000000   123  FLASH_CR1_FIX = (0)
                                    124 ; FLASH_CR2 bits
                           000007   125  FLASH_CR2_OPT = (7)
                           000006   126  FLASH_CR2_WPRG = (6)
                           000005   127  FLASH_CR2_ERASE = (5)
                           000004   128  FLASH_CR2_FPRG = (4)
                           000000   129  FLASH_CR2_PRG = (0)
                                    130 ; FLASH_IAPSR bits
                           000006   131  FLASH_IAPSR_HVOFF = (6)
                           000003   132  FLASH_IAPSR_DUL = (3)
                           000002   133  FLASH_IAPSR_EOP = (2)
                           000001   134  FLASH_IAPSR_PUL = (1)
                           000000   135  FLASH_IAPSR_WR_PG_DIS = (0)
                                    136 
                                    137 ; Interrupt control
                           0050A0   138 EXTI_CR1  = (0x50A0)
                           0050A1   139 EXTI_CR2  = (0x50A1)
                           0050A2   140 EXTI_CR3  = (0x50A2)
                           0050A3   141 EXTI_SR1  = (0x50A3)
                           0050A4   142 EXTI_SR2  = (0x50A4)
                           0050A5   143 EXTI_CONF = (0x50A5)
                                    144 
                                    145 ; WFE controls registers 
                           0050A6   146 WFE_CR1   = (0x50A6)
                           0050A7   147 WFE_CR2   = (0x50A7)
                                    148 
                                    149 ; Reset control and Status
                           0050B0   150  RST_CR = (0x50B0)
                           0050B1   151  RST_SR = (0x50B1)
                                    152 
                                    153 ; Clock Registers
                           0050C0   154  CLK_CKDIVR =(0x50C0)
                           0050C1   155  CLK_ECKR =(0x50C1)
                           0050C3   156  CLK_PCKENR = (0x50C3)
                           0050C5   157  CLK_CCOR = (0x50C5)
                                    158 
                                    159 ; Peripherals clock gating
                                    160 ; CLK_PCKENR
                           000006   161  CLK_PCKENR_AWU_BEEP= (6)
                           000005   162  CLK_PCKENR_USART = (5)
                           000004   163  CLK_PCKENR_SPI = (4)
                           000003   164  CLK_PCKENR_I2C = (3)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
Hexadecimal [24-Bits]



                           000002   165  CLK_PCKENR_TIM4 = (2)
                           000001   166  CLK_PCKENR_TIM3 = (1)
                           000000   167  CLK_PCKENR_TIM2 = (0)
                                    168 
                                    169 ; IWDG 
                           0050E0   170  IWDG_KR = (0x50E0)
                           0050E1   171  IWDG_PR = (0x50E1)
                           0050E2   172  IWDG_RLR = (0x50E2)
                                    173 
                                    174 ; AWU 
                                    175 ;  auto wake up
                           0050F0   176 AWU_CSR1 =(0x50F0)
                           0050F1   177 AWU_APR =(0x50F1)
                           0050F2   178 AWU_TBR =(0x50F2)
                                    179 
                                    180 ; BEEP 
                           0050F3   181  BEEP_CSR = (0x50F3)
                                    182 
                                    183 ; SPI
                           005200   184  SPI_CR1  = (0x5200)
                           005201   185  SPI_CR2  = (0x5201)
                           005202   186  SPI_ICR  = (0x5202)
                           005203   187  SPI_SR  = (0x5203)
                           005204   188  SPI_DR  = (0x5204)
                                    189 
                                    190 ; I2C
                           005210   191  I2C_CR1  = (0x5210)
                           005211   192  I2C_CR2  = (0x5211)
                           005212   193  I2C_FREQR  = (0x5212)
                           005213   194  I2C_OARL  = (0x5213)
                           005214   195  I2C_OARH  = (0x5214)
                           005216   196  I2C_DR  = (0x5216)
                           005217   197  I2C_SR1  = (0x5217)
                           005218   198  I2C_SR2  = (0x5218)
                           005219   199  I2C_SR3  = (0x5219)
                           00521A   200  I2C_ITR  = (0x521A)
                           00521B   201  I2C_CCRL  = (0x521B)
                           00521C   202  I2C_CCRH  = (0x521C)
                           00521D   203  I2C_TRISER  = (0x521D)
                                    204 
                           000000   205  I2C_STD = 0 
                           000001   206  I2C_FAST = 1 
                                    207 
                           000007   208  I2C_CR1_NOSTRETCH = (7)
                           000006   209  I2C_CR1_ENGC = (6)
                           000000   210  I2C_CR1_PE = (0)
                                    211 
                           000007   212  I2C_CR2_SWRST = (7)
                           000003   213  I2C_CR2_POS = (3)
                           000002   214  I2C_CR2_ACK = (2)
                           000001   215  I2C_CR2_STOP = (1)
                           000000   216  I2C_CR2_START = (0)
                                    217 
                           000001   218  I2C_OARL_ADD=(1)
                           000000   219  I2C_OARL_ADD0 = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                                    220 
                           000009   221  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   222  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    223 
                           000007   224  I2C_OARH_ADDMODE = (7)
                           000006   225  I2C_OARH_ADDCONF = (6)
                           000002   226  I2C_OARH_ADD9 = (2)
                           000001   227  I2C_OARH_ADD8 = (1)
                                    228 
                           000007   229  I2C_SR1_TXE = (7)
                           000006   230  I2C_SR1_RXNE = (6)
                           000004   231  I2C_SR1_STOPF = (4)
                           000003   232  I2C_SR1_ADD10 = (3)
                           000002   233  I2C_SR1_BTF = (2)
                           000001   234  I2C_SR1_ADDR = (1)
                           000000   235  I2C_SR1_SB = (0)
                                    236 
                           000005   237  I2C_SR2_WUFH = (5)
                           000003   238  I2C_SR2_OVR = (3)
                           000002   239  I2C_SR2_AF = (2)
                           000001   240  I2C_SR2_ARLO = (1)
                           000000   241  I2C_SR2_BERR = (0)
                                    242 
                           000007   243  I2C_SR3_DUALF = (7)
                           000004   244  I2C_SR3_GENCALL = (4)
                           000002   245  I2C_SR3_TRA = (2)
                           000001   246  I2C_SR3_BUSY = (1)
                           000000   247  I2C_SR3_MSL = (0)
                                    248 
                           000002   249  I2C_ITR_ITBUFEN = (2)
                           000001   250  I2C_ITR_ITEVTEN = (1)
                           000000   251  I2C_ITR_ITERREN = (0)
                                    252 
                                    253 ; Precalculated values, all in KHz
                           000080   254  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   255  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    256 ;
                                    257 ; Fast I2C mode max rise time = 300ns
                                    258 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    259 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
                                    260 
                           000005   261  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    262 
                           0000C0   263  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   264  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   265  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    266 
                           000080   267  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   268  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   269  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    270 
                           000000   271  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   272  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    273 ;
                                    274 ; Standard I2C mode max rise time = 1000ns
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                                    275 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    276 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    277 
                           000011   278  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    279 
                           000000   280  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   281  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   282  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    283 
                           000001   284  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   285  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   286  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    287 
                           000001   288  I2C_READ = 1
                           000000   289  I2C_WRITE = 0
                                    290 
                                    291 ; baudrate constant for brr_value table access
                           000000   292 B2400=0
                           000001   293 B4800=1
                           000002   294 B9600=2
                           000003   295 B19200=3
                           000004   296 B38400=4
                           000005   297 B57600=5
                           000006   298 B115200=6
                           000007   299 B230400=7
                           000008   300 B460800=8
                           000009   301 B921600=9
                                    302 
                                    303 ; USART
                           005230   304  USART_SR    = (0x5230)
                           005231   305  USART_DR    = (0x5231)
                           005232   306  USART_BRR1  = (0x5232)
                           005233   307  USART_BRR2  = (0x5233)
                           005234   308  USART_CR1   = (0x5234)
                           005235   309  USART_CR2   = (0x5235)
                           005236   310  USART_CR3   = (0x5236)
                           005237   311  USART_CR4   = (0x5237)
                                    312 
                                    313 ; USART Status Register bits
                           000007   314  USART_SR_TXE = (7)
                           000006   315  USART_SR_TC = (6)
                           000005   316  USART_SR_RXNE = (5)
                           000004   317  USART_SR_IDLE = (4)
                           000003   318  USART_SR_OR = (3)
                           000002   319  USART_SR_NF = (2)
                           000001   320  USART_SR_FE = (1)
                           000000   321  USART_SR_PE = (0)
                                    322 
                                    323 ; Uart Control Register bits
                           000007   324  USART_CR1_R8 = (7)
                           000006   325  USART_CR1_T8 = (6)
                           000005   326  USART_CR1_USARTD = (5)
                           000004   327  USART_CR1_M = (4)
                           000003   328  USART_CR1_WAKE = (3)
                           000002   329  USART_CR1_PCEN = (2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                           000001   330  USART_CR1_PS = (1)
                           000000   331  USART_CR1_PIEN = (0)
                                    332 
                           000007   333  USART_CR2_TIEN = (7)
                           000006   334  USART_CR2_TCIEN = (6)
                           000005   335  USART_CR2_RIEN = (5)
                           000004   336  USART_CR2_ILIEN = (4)
                           000003   337  USART_CR2_TEN = (3)
                           000002   338  USART_CR2_REN = (2)
                           000001   339  USART_CR2_RWU = (1)
                           000000   340  USART_CR2_SBK = (0)
                                    341 
                           000006   342  USART_CR3_LINEN = (6)
                           000005   343  USART_CR3_STOP1 = (5)
                           000004   344  USART_CR3_STOP0 = (4)
                           000003   345  USART_CR3_CLKEN = (3)
                           000002   346  USART_CR3_CPOL = (2)
                           000001   347  USART_CR3_CPHA = (1)
                           000000   348  USART_CR3_LBCL = (0)
                                    349 
                           000006   350  USART_CR4_LBDIEN = (6)
                           000005   351  USART_CR4_LBDL = (5)
                           000004   352  USART_CR4_LBDF = (4)
                           000003   353  USART_CR4_ADD3 = (3)
                           000002   354  USART_CR4_ADD2 = (2)
                           000001   355  USART_CR4_ADD1 = (1)
                           000000   356  USART_CR4_ADD0 = (0)
                                    357 
                                    358 ; TIMERS
                                    359 ; TIMER2 
                           005250   360  TIM2_CR1  = (0x5250)
                           005251   361  TIM2_CR2  = (0x5251)
                           005252   362  TIM2_SMCR  = (0x5252)
                           005253   363  TIM2_ETR  = (0x5253)
                           005254   364  TIM2_IER  = (0x5254)
                           005255   365  TIM2_SR1  = (0x5255)
                           005256   366  TIM2_SR2  = (0x5256)
                           005257   367  TIM2_EGR  = (0x5257)
                           005258   368  TIM2_CCMR1  = (0x5258)
                           005259   369  TIM2_CCMR2  = (0x5259)
                           00525A   370  TIM2_CCER1  = (0x525A)
                           00525B   371  TIM2_CNTRH  = (0x525B)
                           00525C   372  TIM2_CNTRL  = (0x525C)
                           00525D   373  TIM2_PSCR  = (0x525D)
                           00525E   374  TIM2_ARRH  = (0x525E)
                           00525F   375  TIM2_ARRL  = (0x525F)
                           005260   376  TIM2_CCR1H  = (0x5260)
                           005261   377  TIM2_CCR1L  = (0x5261)
                           005262   378  TIM2_CCR2H  = (0x5262)
                           005263   379  TIM2_CCR2L  = (0x5263)
                           005264   380  TIM2_BKR  = (0x5264)
                           005265   381  TIM2_OISR  = (0x5265)
                                    382 
                                    383 ; Timer 3 - 16-bit timer
                           005280   384 TIM3_CR1 = (0x5280)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                           005281   385 TIM3_CR2 = (0x5281)
                           005282   386 TIM3_SMCR = (0x5282)
                           005283   387 TIM3_ETR = (0x5283)
                           005284   388 TIM3_IER = (0x5284)
                           005285   389 TIM3_SR1 = (0x5285)
                           005286   390 TIM3_SR2 = (0x5286)
                           005287   391 TIM3_EGR = (0x5287)
                           005288   392 TIM3_CCMR1 = (0x5288)
                           005289   393 TIM3_CCMR2 = (0x5289)
                           00528A   394 TIM3_CCER1 = (0x528A)
                           00528B   395 TIM3_CNTRH = (0x528B)
                           00528C   396 TIM3_CNTRL = (0x528C)
                           00528D   397 TIM3_PSCR = (0x528D)
                           00528E   398 TIM3_ARRH = (0x528E)
                           00528F   399 TIM3_ARRL = (0x528F)
                           005290   400 TIM3_CCR1H = (0x5290)
                           005291   401 TIM3_CCR1L = (0x5291)
                           005292   402 TIM3_CCR2H = (0x5292)
                           005293   403 TIM3_CCR2L = (0x5293)
                           005294   404 TIM3_BKR = (0x5294)
                           005295   405 TIM3_OISR = (0x5295)
                                    406 
                                    407 ; TIM2 and TIM3 registers bits fields 
                                    408 ; Timer Control 1 
                           000007   409  TIM_CR1_ARPE = (7)
                           000005   410  TIM_CR1_CMS = (5) ; field 6:5
                           000004   411  TIM_CR1_DIR = (4)
                           000003   412  TIM_CR1_OPM = (3)
                           000002   413  TIM_CR1_URS = (2)
                           000001   414  TIM_CR1_UDIS = (1)
                           000000   415  TIM_CR1_CEN = (0)
                                    416 
                           000004   417  TIM_CR2_MMS = (4) ; field 6:4
                                    418 
                                    419 ; Timer Slave Mode Control bits
                           000007   420  TIM_SMCR_MSM = (7)
                           000004   421  TIM_SMCR_TS = (4) ; filed 6:4
                           000000   422  TIM_SMCR_SMS = (0) ; filed 2:0
                                    423 
                                    424 ; Timer External Trigger Enable bits
                           000007   425  TIM_ETR_ETP = (7)
                           000006   426  TIM_ETR_ECE = (6)
                           000004   427  TIM_ETR_ETPS = (4) ; field 5:4
                           000000   428  TIM_ETR_ETF = (0) ; field 3:0
                                    429 
                                    430 ; Timer Interrupt Enable bits
                           000007   431  TIM_IER_BIE = (7)
                           000006   432  TIM_IER_TIE = (6)
                           000002   433  TIM_IER_CC2IE = (2)
                           000001   434  TIM_IER_CC1IE = (1)
                           000000   435  TIM_IER_UIE = (0)
                                    436 
                                    437 ; Timer Status Register 1 bits
                           000007   438  TIM_SR1_BIF = (7)
                           000006   439  TIM_SR1_TIF = (6)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                           000002   440  TIM_SR1_CC2IF = (2)
                           000001   441  TIM_SR1_CC1IF = (1)
                           000000   442  TIM_SR1_UIF = (0)
                                    443 
                                    444 ; Timer status register 2 bits 
                           000002   445  TIM_SR2_CC2OF = (2)
                           000001   446  TIM_SR2_CC1OF = (1)
                                    447 
                                    448 ; Timer Event Generation Register bits
                           000007   449  TIM_EGR_BG = (7)
                           000006   450  TIM_EGR_TG = (6)
                           000002   451  TIM_EGR_CC2G = (2)
                           000001   452  TIM_EGR_CC1G = (1)
                           000000   453  TIM_EGR_UG = (0)
                                    454 
                                    455 ; Capture/Compare Mode Register 1 - channel configured in output
                           000004   456  TIM_CCMR1_OC1M = (4) ; field 6:4
                           000003   457  TIM_CCMR1_OC1PE = (3)
                           000002   458  TIM_CCMR1_OC1FE = (2)
                           000000   459  TIM_CCMR1_CC1S = (0) ; field 1:0
                                    460 
                                    461 ; Capture/Compare Mode Register 1 - channel configured in input
                           000004   462  TIM_CCMR1_IC1F = (4) ; field 7:4
                           000002   463  TIM_CCMR1_IC1PSC = (2) ; field 3:2
                           000000   464  TIM_CCMR1_CC1S = (0) ; field 1:0
                                    465 
                                    466 ; Capture/Compare Mode Register 2 - channel configured in output
                           000004   467  TIM_CCMR2_OC2M = (4) ; field 6:4
                           000003   468  TIM_CCMR2_OC2PE = (3)
                           000002   469  TIM_CCMR2_OC2FE = (2)
                           000000   470  TIM_CCMR2_CC2S0 = (0) ; field 1:0
                                    471 
                                    472 ; Capture/Compare Mode Register 2 - channel configured in input
                           000004   473  TIM_CCMR2_IC2F = (4) ; field 7:4 
                           000002   474  TIM_CCMR2_IC2PSC = (2) ; field 3:2 
                           000000   475  TIM_CCMR2_CC2S = (0) ; field 1:0
                                    476 
                                    477 ; Capture/compare enable register 1 (TIM_CCER1)
                           000005   478 TIM_CCER1_CC2P = (5)
                           000004   479 TIM_CCER1_CC2E = (4)
                           000001   480 TIM_CCER1_CC1P = (1)
                           000000   481 TIM_CCER1_CC1E = (0)
                                    482 
                                    483 ; Prescaler register (TIM_PSCR)
                           000000   484 TIM_PSCR = (0) ; field 2:0
                                    485 
                                    486 ; Break register (TIM_BKR)
                           000007   487 TIM_BKR_MOE = (7)
                           000006   488 TIM_BKR_AOE = (6)
                           000005   489 TIM_BKR_BKP = (5)
                           000004   490 TIM_BKR_BKE = (4)
                           000002   491 TIM_BKR_OSSI = (2)
                           000000   492 TIM_BKR_LOCK = (0) ; field 1:0 
                                    493 
                                    494 ; Output idle state register (TIM_OISR) 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                           000002   495 TIM_OISR_OIS2 = (2)
                           000000   496 TIM_OISR_OIS1 = (0)
                                    497 
                                    498 
                                    499 ; Timer 4
                           0052E0   500 TIM4_CR1 = (0x52E0)
                           0052E1   501 TIM4_CR2 = (0x52E1)
                           0052E2   502 TIM4_SMCR = (0X52E2)
                           0052E3   503 TIM4_IER = (0x52E3)
                           0052E4   504 TIM4_SR = (0x52E4)
                           0052E5   505 TIM4_EGR = (0x52E5)
                           0052E6   506 TIM4_CNTR = (0x52E6)
                           0052E7   507 TIM4_PSCR = (0x52E7)
                           0052E8   508 TIM4_ARR = (0x52E8)
                                    509 
                                    510 ; Timer 4 bitfields
                                    511 
                           000007   512  TIM4_CR1_ARPE = (7)
                           000003   513  TIM4_CR1_OPM = (3)
                           000002   514  TIM4_CR1_URS = (2)
                           000001   515  TIM4_CR1_UDIS = (1)
                           000000   516  TIM4_CR1_CEN = (0)
                                    517 
                           000000   518  TIM4_IER_UIE = (0)
                                    519 
                           000000   520  TIM4_SR_UIF = (0)
                                    521 
                           000000   522  TIM4_EGR_UG = (0)
                                    523 
                           000002   524  TIM4_PSCR_PSC2 = (2)
                           000001   525  TIM4_PSCR_PSC1 = (1)
                           000000   526  TIM4_PSCR_PSC0 = (0)
                                    527 
                           000000   528  TIM4_PSCR_1 = 0
                           000001   529  TIM4_PSCR_2 = 1
                           000002   530  TIM4_PSCR_4 = 2
                           000003   531  TIM4_PSCR_8 = 3
                           000004   532  TIM4_PSCR_16 = 4
                           000005   533  TIM4_PSCR_32 = 5
                           000006   534  TIM4_PSCR_64 = 6
                           000007   535  TIM4_PSCR_128 = 7
                                    536 
                                    537 ; IRTIM infrared control register 
                           0052FF   538  IR_CR = (0x52FF)
                                    539 
                                    540 ; comparator 1
                           005300   541  COMP_CR = (0x5300)
                           005301   542  COMP_CSR = (0x5301)
                           005302   543  COMP_CCS = (0x5302)
                                    544 
                                    545 ; CPU
                           007F00   546  CPU_A  = (0x7F00)
                           007F01   547  CPU_PCE  = (0x7F01)
                           007F02   548  CPU_PCH  = (0x7F02)
                           007F03   549  CPU_PCL  = (0x7F03)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                           007F04   550  CPU_XH  = (0x7F04)
                           007F05   551  CPU_XL  = (0x7F05)
                           007F06   552  CPU_YH  = (0x7F06)
                           007F07   553  CPU_YL  = (0x7F07)
                           007F08   554  CPU_SPH  = (0x7F08)
                           007F09   555  CPU_SPL   = (0x7F09)
                           007F0A   556  CPU_CCR   = (0x7F0A)
                                    557 
                                    558 ; global configuration register
                           007F60   559  CFG_GCR   = (0x7F60)
                           000000   560  CFG_GCR_SWD = (0)
                           000001   561  CFG_GCR_HALT = (1)	
                                    562 
                                    563 ; interrupt control registers
                           007F70   564  ITC_SPR1   = (0x7F70)
                           007F71   565  ITC_SPR2   = (0x7F71)
                           007F72   566  ITC_SPR3   = (0x7F72)
                           007F73   567  ITC_SPR4   = (0x7F73)
                           007F74   568  ITC_SPR5   = (0x7F74)
                           007F75   569  ITC_SPR6   = (0x7F75)
                           007F76   570  ITC_SPR7   = (0x7F76)
                           007F77   571  ITC_SPR8   = (0x7F77)
                                    572 
                           000001   573 ITC_SPR_LEVEL1=1 
                           000000   574 ITC_SPR_LEVEL2=0
                           000003   575 ITC_SPR_LEVEL3=3 
                                    576 
                                    577 
                                    578 ; SWIM, control and status register
                           007F80   579  SWIM_CSR   = (0x7F80)
                                    580 ; debug registers
                           007F90   581  DM_BK1RE   = (0x7F90)
                           007F91   582  DM_BK1RH   = (0x7F91)
                           007F92   583  DM_BK1RL   = (0x7F92)
                           007F93   584  DM_BK2RE   = (0x7F93)
                           007F94   585  DM_BK2RH   = (0x7F94)
                           007F95   586  DM_BK2RL   = (0x7F95)
                           007F96   587  DM_CR1   = (0x7F96)
                           007F97   588  DM_CR2   = (0x7F97)
                           007F98   589  DM_CSR1   = (0x7F98)
                           007F99   590  DM_CSR2   = (0x7F99)
                           007F9A   591  DM_ENFCTR   = (0x7F9A)
                                    592 
                                    593 ; vector 0 is reset 
                                    594 ; vector 1 is TRAP 
                                    595 ; Interrupt Numbers begin at vector 3
                           000001   596 INT_FLASH = 1
                           000002   597 INT_CLK = 2 
                           000004   598 INT_AWU = 4
                           000006   599 INT_EXTIB = 6
                           000007   600 INT_EXTID = 7
                           000008   601 INT_EXTI0 = 8
                           000009   602 INT_EXTI1 = 9
                           00000A   603 INT_EXTI2 = 10
                           00000B   604 INT_EXTI3 = 11
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                           00000C   605 INT_EXTI4 = 12
                           00000D   606 INT_EXTI5 = 13 
                           00000E   607 INT_EXTI6 = 14
                           00000F   608 INT_EXTI7 = 15
                           000012   609 INT_COMP= 18 
                           000013   610 INT_TIM2_OVF = 19
                           000014   611 INT_TIM2_CC = 20
                           000015   612 INT_TIM3_OVF = 21
                           000016   613 INT_TIM3_CC = 22
                           000019   614 INT_TIM4_OVF = 25
                           00001A   615 INT_SPI  = 26
                           00001B   616 INT_USART_TX = 27 
                           00001C   617 INT_USART_RX = 28 
                           00001D   618 INT_I2C = 29
                                    619 
                                    620 ; Interrupt Vector address
                           008000   621 INT_VECTOR_RESET = 0x8000
                           008004   622 INT_VECTOR_TRAP = 0x8004
                           00800C   623 INT_VECTOR_FLASH = 0x800C
                           008018   624 INT_VECTOR_AWU = 0x8018
                           008020   625 INT_VECTOR_EXTIB = 0x8020
                           008024   626 INT_VECTOR_EXTID = 0x8024
                           008028   627 INT_VECTOR_EXTI0 = 0x8028
                           00802C   628 INT_VECTOR_EXTI1 = 0x802C
                           008030   629 INT_VECTOR_EXTI2 = 0x8030
                           008024   630 INT_VECTOR_EXTI3 = 0x8024
                           008038   631 INT_VECTOR_EXTI4 = 0x8038
                           00803C   632 INT_VECTOR_EXTI5 = 0x803C 
                           008040   633 INT_VECTOR_EXTI6 = 0x8040
                           008044   634 INT_VECTOR_EXTI7 = 0x8044
                           008050   635 INT_VECTOR_COMP = 0x8050
                           008054   636 INT_VECTOR_TIM2_OVF = 0x8054
                           008058   637 INT_VECTOR_TIM2_CCM = 0x8058
                           00805C   638 INT_VECTOR_TIM3_OVF = 0x805C
                           008060   639 INT_VECTOR_TIM3_CCM = 0x8060
                           00806C   640 INT_VECTOR_TIM4_OVF = 0x806C
                           008070   641 INT_VECTOR_SPI  = 0x8070
                           008074   642 INT_VECTOR_USART_TX_COMPLETE = 0x8074
                           008078   643 INT_VECTOR_USART_RX_FULL = 0x8078
                           00807C   644 INT_VECTOR_I2C = 0x807C
                                    645 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                                     21 
                           1E8480    22     FMSTR = 2000000 ; 2Mhz
                                     23 
                           000000    24 TREMOLO=0
                                     25 ; sound output 
                           00500F    26     BELL_PORT=PD
                           000000    27     BELL_BIT=0
                                     28 
                                     29     .macro _tone_on
                                     30     bset TIM3_CR1,#TIM_CR1_CEN 
                                     31     .endm
                                     32 
                                     33     .macro _tone_off 
                                     34 	bres TIM3_CR1,#TIM_CR1_CEN 
                                     35     .endm 
                                     36 
                                     37 ; bell button input 
                           00500A    38     BTN_PORT=PC 
                           000001    39     BTN_BIT=1 
                                     40 
                                     41     ; enable exti on ring button 
                                     42     .macro _enable_button
                                     43     bset BTN_PORT+GPIO_CR2,#BTN_BIT 
                                     44     .endm 
                                     45 
                                     46     ; disable exti on ring button 
                                     47     .macro _disable_button
                                     48     bres BTN_PORT+GPIO_CR2,#BTN_BIT 
                                     49     .endm 
                                     50 
                                     51 ; LED port 
                           005005    52     LED_PORT=PB 
                           000007    53     LED_BIT=7
                                     54 
                                     55     .macro _led_on 
                                     56     bres LED_PORT,#LED_BIT 
                                     57     .endm 
                                     58 
                                     59     .macro _led_off 
                                     60     bset LED_PORT,#LED_BIT 
                                     61     .endm 
                                     62 
                                     63     .macro _led_toggle 
                                     64     bcpl LED_PORT,#LED_BIT 
                                     65     .endm 
                                     66 
                                     67 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                                     68 	.include "inc/gen_macros.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                                     19 ;   console Input/Output module
                                     20 ;   DATE: 2019-12-11
                                     21 ;    
                                     22 ;   General usage macros.   
                                     23 ;
                                     24 ;--------------------------------------
                                     25 
                                     26     ; reserve space on stack
                                     27     ; for local variables
                                     28     .macro _vars n 
                                     29     sub sp,#n 
                                     30     .endm 
                                     31     
                                     32     ; free space on stack
                                     33     .macro _drop n 
                                     34     addw sp,#n 
                                     35     .endm
                                     36 
                                     37     ; declare ARG_OFS for arguments 
                                     38     ; displacement on stack. This 
                                     39     ; value depend on local variables 
                                     40     ; size.
                                     41     .macro _argofs n 
                                     42     ARG_OFS=2+n 
                                     43     .endm 
                                     44 
                                     45     ; declare a function argument 
                                     46     ; position relative to stack pointer 
                                     47     ; _argofs must be called before it.
                                     48     .macro _arg name ofs 
                                     49     name=ARG_OFS+ofs 
                                     50     .endm 
                                     51 
                                     52     ; increment zero page variable 
                                     53     .macro _incz v 
                                     54     .byte 0x3c, v 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                                     55     .endm 
                                     56 
                                     57     ; decrement zero page variable 
                                     58     .macro _decz v 
                                     59     .byte 0x3a,v 
                                     60     .endm 
                                     61 
                                     62     ; clear zero page variable 
                                     63     .macro _clrz v 
                                     64     .byte 0x3f, v 
                                     65     .endm 
                                     66 
                                     67     ; load A zero page variable 
                                     68     .macro _ldaz v 
                                     69     .byte 0xb6,v 
                                     70     .endm 
                                     71 
                                     72     ; store A zero page variable 
                                     73     .macro _straz v 
                                     74     .byte 0xb7,v 
                                     75     .endm 
                                     76 
                                     77     ; load x from variable in zero page 
                                     78     .macro _ldxz v 
                                     79     .byte 0xbe,v 
                                     80     .endm 
                                     81 
                                     82     ; load y from variable in zero page 
                                     83     .macro _ldyz v 
                                     84     .byte 0x90,0xbe,v 
                                     85     .endm 
                                     86 
                                     87     ; store x in zero page variable 
                                     88     .macro _strxz v 
                                     89     .byte 0xbf,v 
                                     90     .endm 
                                     91 
                                     92     ; store y in zero page variable 
                                     93     .macro _stryz v 
                                     94     .byte 0x90,0xbf,v 
                                     95     .endm 
                                     96 
                                     97     ;  increment 16 bits variable
                                     98     ;  use 10 bytes  
                                     99     .macro _incwz  v 
                                    100         _incz v+1   ; 1 cy, 2 bytes 
                                    101         jrne .+4  ; 1|2 cy, 2 bytes 
                                    102         _incz v     ; 1 cy, 2 bytes  
                                    103     .endm ; 3 cy 
                                    104 
                                    105     ; xor op with zero page variable 
                                    106     .macro _xorz v 
                                    107     .byte 0xb8,v 
                                    108     .endm 
                                    109     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                                    110 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                                     69 
                           000080    70     STACK_SIZE=128
                           0005FF    71     STACK_EMPTY=RAM_SIZE-1 
                                     72 
                                     73 ; boolean flags 
                           000007    74     FTIMER=7 
                                     75 
                                     76 ;--------------------------------------
                                     77 ;   assembler flags 
                                     78 ;-------------------------------------
                                     79 
                                     80     ; assume 16 Mhz Fcpu 
                                     81      .macro _usec_dly n 
                                     82     ldw x,#(16*n-2)/4 ; 2 cy 
                                     83     decw x  ; 1 cy 
                                     84     nop     ; 1 cy 
                                     85     jrne .-2 ; 2 cy 
                                     86     .endm 
                                     87 
                                     88 ;----------------------------------
                                     89 ; functions arguments access 
                                     90 ; from stack 
                                     91 ; caller push arguments before call
                                     92 ; and drop them after call  
                                     93 ;----------------------------------    
                                     94     ; get argument in X 
                                     95     .macro _get_arg n 
                                     96     ldw x,(2*(n+1),sp)
                                     97     .endm 
                                     98 
                                     99     ; store X in argument n 
                                    100     .macro _store_arg n 
                                    101     ldw (2*(n+1),sp),x 
                                    102     .endm 
                                    103 
                                    104     ; drop function arguments 
                                    105     .macro _drop_args n 
                                    106     addw sp,#2*n
                                    107     .endm 
                                    108 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                                     26 
                                     27 
                                     28 ;;-----------------------------------
                                     29     .area SSEG (ABS)
                                     30 ;; working buffers and stack at end of RAM. 	
                                     31 ;;-----------------------------------
      00057F                         32     .org RAM_END - STACK_SIZE 
      00057F                         33 stack_full:: .ds STACK_SIZE   ; control stack 
      0005FF                         34 stack_unf:: ; stack underflow ; control_stack bottom 
                                     35 
                                     36 ;;--------------------------------------
                                     37     .area HOME 
                                     38 ;; interrupt vector table at 0x8000
                                     39 ;;--------------------------------------
                                     40 
      008000 82 00 81 55             41     int reset   			; RESET vector 
      008004 82 00 80 80             42 	int NonHandledInterrupt ; TRAP instruction 
      008008 00 00 00 00             43 	.word 0,0               ; not used  
      00800C 82 00 80 80             44 	int NonHandledInterrupt ; int1 FLASH   
      008010 00 00 00 00 00 00 00    45 	.word 0,0,0,0           ; 2,3 not used
             00
      008018 82 00 80 80             46 	int NonHandledInterrupt ; int4 AWU 
      00801C 00 00 00 00             47 	.word 0,0               ; 5 not used 
      008020 82 00 80 80             48 	int NonHandledInterrupt ; int6 EXTIB
      008024 82 00 80 80             49 	int NonHandledInterrupt ; int7 EXITD  
      008028 82 00 80 80             50 	int NonHandledInterrupt ; int8 EXTI0
      00802C 82 00 80 81             51 	int BtnExtiHandler      ; int9 EXIT1  
      008030 82 00 80 80             52 	int NonHandledInterrupt ; int10 EXTI2 
      008034 82 00 80 80             53 	int NonHandledInterrupt ; int11 EXTI3 
      008038 82 00 80 80             54 	int NonHandledInterrupt ; int12 EXTI4 
      00803C 82 00 80 80             55 	int NonHandledInterrupt ; int13 EXTI5 
      008040 82 00 80 80             56 	int NonHandledInterrupt ; int14 EXTI6 
      008044 82 00 80 80             57 	int NonHandledInterrupt ; int15 EXTI7 
      008048 00 00 00 00 00 00 00    58 	.word 0,0,0,0           ; 16,17 not used 
             00
      008050 82 00 80 80             59 	int NonHandledInterrupt ; int18 COMP 
      008054 82 00 80 80             60 	int NonHandledInterrupt ;int19 TIM2 update /overflow
      008058 82 00 80 80             61 	int NonHandledInterrupt ;int20 TIM2 capture/compare
      00805C 82 00 80 80             62 	int NonHandledInterrupt ;int21 TIM3 Update/overflow
      008060 82 00 80 80             63 	int NonHandledInterrupt ;int22 TIM3 Capture/compare
      008064 00 00 00 00             64 	.word 0,0				; int23 not used 
      008068 00 00 00 00             65 	.word 0,0               ; int24 not used 
      00806C 82 00 80 8A             66 	int Timer4UpdateHandler ; int25 TIMER4 overflow
      008070 82 00 80 8A             67 	int Timer4UpdateHandler ; int26 SPI 
      008074 82 00 80 80             68 	int NonHandledInterrupt ;int27 USART TX completed
      008078 82 00 80 80             69 	int NonHandledInterrupt ;int28 USART RX full 
      00807C 82 00 80 80             70 	int NonHandledInterrupt ;int29 I2C 
                                     71 
                                     72 ;--------------------------------------
                                     73     .area DATA (ABS)
      000001                         74 	.org 1 
                                     75 ;--------------------------------------	
                                     76 ; keep the following 3 variables in this order 
      000001                         77 ticks:: .blkw 1 ; milliseconds ticks counter (see Timer4UpdateHandler)
      000003                         78 timer:: .blkw 1 ;  milliseconds count down timer 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



      000005                         79 duration:: .blkw 1 ; tone duration 
      000007                         80 flags:: .blkb 1 ; various boolean flags
      000008                         81 ptr:: .blkw 1 ; score pointer 
                                     82 
      000100                         83 	.org 0x100
      000100                         84 free_ram:: ; from here RAM free for BASIC text 
                                     85 
                                     86 	.area CODE
                                     87 
                                     88 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     89 ; non handled interrupt 
                                     90 ; reset MCU
                                     91 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                         92 NonHandledInterrupt:
      008080 80               [11]   93 	iret 
                                     94 
                                     95 ;;;;;;;;;;;;;;;;;;;;;;;
                                     96 ; doorbell button 
                                     97 ; interrupt handler 
                                     98 ;;;;;;;;;;;;;;;;;;;;;;;
      008081                         99 BtnExtiHandler:
      000001                        100 	_disable_button
      008081 72 13 50 0E      [ 1]    1     bres BTN_PORT+GPIO_CR2,#BTN_BIT 
      008085 72 12 50 A3      [ 1]  101 	bset EXTI_SR1,#BTN_BIT ; clear interrupt
      008089 80               [11]  102 	iret 
                                    103 	
                                    104 ;------------------------------
                                    105 ; TIMER 4 is used to maintain 
                                    106 ; a milliseconds 'ticks' counter
                                    107 ; and decrement 'timer' varaiable
                                    108 ; ticks range {0..65535}
                                    109 ; timer range {0..65535}
                                    110 ;--------------------------------
      00808A                        111 Timer4UpdateHandler:
      00808A                        112 0$:
      00808A 72 5F 52 E4      [ 1]  113 	clr TIM4_SR 
      00000E                        114 	_ldxz ticks
      00808E BE 01                    1     .byte 0xbe,ticks 
      008090 1C 00 01         [ 2]  115 	addw x,#1 
      000013                        116 	_strxz ticks 
      008093 BF 01                    1     .byte 0xbf,ticks 
      008095 72 0F 00 07 0B   [ 2]  117 	btjf flags,#FTIMER,1$
      00001A                        118 	_ldxz timer
      00809A BE 03                    1     .byte 0xbe,timer 
      00809C 5A               [ 2]  119 	decw x 
      00001D                        120 	_strxz timer
      00809D BF 03                    1     .byte 0xbf,timer 
      00809F 26 04            [ 1]  121 	jrne 1$ 
      0080A1 72 1F 00 07      [ 1]  122 	bres flags,#FTIMER  
      0080A5                        123 1$:	
      0080A5 80               [11]  124 	iret 
                                    125 
                                    126 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    127 ;    peripherals initialization
                                    128 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                                    129 
                                    130 ;----------------------------------------
                                    131 ; inialize MCU clock 
                                    132 ; keep it at default 2Mhz 
                                    133 ;----------------------------------------
      0080A6                        134 clock_init:	
                                    135 ;	clr CLK_CKDIVR ; 16Mhz HSI oscillator 
      0080A6 81               [ 4]  136 	ret
                                    137 
                                    138 ;---------------------------------
                                    139 ; TIM4 is configured to generate an 
                                    140 ; interrupt every millisecond 
                                    141 ;----------------------------------
      0080A7                        142 timer4_init:
      0080A7 72 14 50 C3      [ 1]  143 	bset CLK_PCKENR,#CLK_PCKENR_TIM4
      0080AB 72 11 52 E0      [ 1]  144 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080AF 35 04 52 E7      [ 1]  145 	mov TIM4_PSCR,#4 ; FMSTR/16=125000 hertz  
      0080B3 35 83 52 E8      [ 1]  146 	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
      0080B7 35 05 52 E0      [ 1]  147 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080BB 72 10 52 E3      [ 1]  148 	bset TIM4_IER,#TIM4_IER_UIE
      0080BF 81               [ 4]  149 	ret
                                    150 
                                    151 ;---------------------------------------
                                    152 ; confirugre TIMER3 in PWM mode 
                                    153 ; for sound generation
                                    154 ; output TIMER3:CH2 on mcu pin 5 
                                    155 ;---------------------------------------
      0080C0                        156 timer3_init:
      0080C0 72 12 50 C3      [ 1]  157 	bset CLK_PCKENR,#CLK_PCKENR_TIM3 ; enable TIMER3 clock 
      0080C4 35 60 52 89      [ 1]  158  	mov TIM3_CCMR2,#(6<<TIM_CCMR2_OC2M) ; PWM mode 1 
                                    159 ;	mov TIM3_PSCR,#3 ; FMSTR/8
      0080C8 72 19 52 8A      [ 1]  160 	bres TIM3_CCER1,#TIM_CCER1_CC2E
      0080CC 72 1E 52 94      [ 1]  161 	bset TIM3_BKR,#TIM_BKR_MOE
      0080D0 81               [ 4]  162 	ret 
                                    163 
                                    164 ;---------------------------------------
                                    165 ; configure external interrupt on 
                                    166 ; doorbell button. This wakeup mcu from 
                                    167 ; halt state 
                                    168 ; exti on PC:1, mcu pin 8 
                                    169 ;---------------------------------------
      0080D1                        170 config_exti:
      0080D1 35 08 50 A0      [ 1]  171 	mov EXTI_CR1,#(2<<(2*BTN_BIT)) ; falling edge trigger  
      0080D5 81               [ 4]  172 	ret 
                                    173 
                                    174 
                                    175 ;---------------------
                                    176 ; delay_msec 
                                    177 ; input:
                                    178 ;    X  delay in msec 
                                    179 ; output:
                                    180 ;    none 
                                    181 ;---------------------
      0080D6                        182 delay_msec: 
      000056                        183 	_strxz timer 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



      0080D6 BF 03                    1     .byte 0xbf,timer 
      0080D8 72 1E 00 07      [ 1]  184 	bset flags,#FTIMER 
      0080DC 72 0E 00 07 FB   [ 2]  185 1$: btjt flags,#FTIMER,1$
      0080E1 81               [ 4]  186 	ret 
                                    187 
                                    188 ;---------------------
                                    189 ; tone generator 
                                    190 ; use TIMER3 channel 2
                                    191 ; input:
                                    192 ;   Y   frequency (arr value) 
                                    193 ;   x   duration (msec)
                                    194 ;---------------------
                           000001   195 	DIVR=1  ; divisor 
                           000003   196 	DLY_MS=3
                           000004   197 	VSIZE=4 
                           1E8480   198 FR_TIM3=FMSTR 
      0080E2                        199 tone:: 
      000062                        200 	_strxz duration 
      0080E2 BF 05                    1     .byte 0xbf,duration 
      0080E4 90 9E            [ 1]  201 	ld a,yh 
      0080E6 C7 52 8E         [ 1]  202 	ld TIM3_ARRH,a 
      0080E9 90 9F            [ 1]  203 	ld a,yl 
      0080EB C7 52 8F         [ 1]  204 	ld TIM3_ARRL,a 
                                    205 ; 25% duty cycle 
      0080EE 90 54            [ 2]  206 	srlw y  
      0080F0 90 9E            [ 1]  207 	ld a,yh 
      0080F2 C7 52 92         [ 1]  208 	ld TIM3_CCR2H,a 
      0080F5 90 9F            [ 1]  209 	ld a,yl
      0080F7 C7 52 93         [ 1]  210 	ld TIM3_CCR2L,a
      0080FA 72 18 52 8A      [ 1]  211 	bset TIM3_CCER1,#TIM_CCER1_CC2E
      0080FE 72 10 52 80      [ 1]  212 	bset TIM3_CR1,#TIM_CR1_CEN
      008102 72 10 52 87      [ 1]  213 	bset TIM3_EGR,#TIM_EGR_UG 	
      000086                        214 	_tone_on
      008106 72 10 52 80      [ 1]    1     bset TIM3_CR1,#TIM_CR1_CEN 
                           000000   215 .if TREMOLO
                                    216 ;tremolo loop 
                                    217 tremolo:
                                    218 	_led_toggle 
                                    219 	ldw x,#30
                                    220 	call delay_msec
                                    221 	_ldxz duration
                                    222 	subw x,#30
                                    223 	_strxz duration 
                                    224 	cpw x,#60 
                                    225 	jrpl  tremolo 
                           000001   226 .else 
      00008A                        227 	_led_on
      00810A 72 1F 50 05      [ 1]    1     bres LED_PORT,#LED_BIT 
      00810E 1D 00 3C         [ 2]  228 	subw x,#60 
      008111 CD 80 D6         [ 4]  229 	call delay_msec 
                                    230 .endif 
      008114                        231 tone_off: 
      000094                        232 	_tone_off
      008114 72 11 52 80      [ 1]    1 	bres TIM3_CR1,#TIM_CR1_CEN 
      000098                        233 	_led_off  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



      008118 72 1E 50 05      [ 1]    1     bset LED_PORT,#LED_BIT 
      00811C AE 00 3C         [ 2]  234 	ldw x,#60 
      00811F CD 80 D6         [ 4]  235 	call delay_msec
      008122 81               [ 4]  236 	ret 
                                    237 
      008123                        238 score: ; frenquency (ARR value), duration (msec) 
      008123 09 F7 01 F4            239 	.word 2551,500 ; sol4 
      008127 08 E1 01 F4            240 	.word 2273,500 ; la4 
      00812B 0B 2F 01 F4            241 	.word 2863,500 ; fa4 
      00812F 16 5F 01 F4            242 	.word 5727,500 ; fa3 
      008133 0E EE 01 F4            243 	.word 3822,500 ; do4 
      008137 00 00 00 00            244 	.word 0,0 ; end marker 
                                    245 
                                    246 ;-----------------------------
                                    247 ; doorbell play a short tune 
                                    248 ;-----------------------------
                                    249 
      00813B                        250 play_tune:
      00813B AE 81 23         [ 2]  251 	ldw x,#score 
      0000BE                        252 	_strxz ptr 
      00813E BF 08                    1     .byte 0xbf,ptr 
      008140                        253 1$:
      008140 91 CE 08         [ 5]  254 	ldw y,[ptr]
      008143 27 0F            [ 1]  255 	jreq 3$
      0000C5                        256 	_ldxz ptr 
      008145 BE 08                    1     .byte 0xbe,ptr 
      008147 1C 00 04         [ 2]  257 	addw x,#4
      0000CA                        258 	_strxz ptr 
      00814A BF 08                    1     .byte 0xbf,ptr 
      00814C 5A               [ 2]  259 	decw x 
      00814D 5A               [ 2]  260 	decw x 
      00814E FE               [ 2]  261 	ldw x,(x)
      00814F CD 80 E2         [ 4]  262 	call tone
      008152 20 EC            [ 2]  263 	jra 1$ 
      008154                        264 3$: 
                                    265 ; end test code 
      008154 81               [ 4]  266 	ret 
                                    267 
                                    268 	
                                    269 ;-------------------------------------
                                    270 ;  initialization entry point 
                                    271 ;-------------------------------------
      008155                        272 reset:
                                    273 ;set stack 
      008155 AE 05 FF         [ 2]  274 	ldw x,#STACK_EMPTY
      008158 94               [ 1]  275 	ldw sp,x
                                    276 ; clear all ram 
      008159 7F               [ 1]  277 0$: clr (x)
      00815A 5A               [ 2]  278 	decw x 
      00815B 26 FC            [ 1]  279 	jrne 0$
                                    280 ; set user BELL sound pin as output 
      00815D 72 10 50 11      [ 1]  281     bset BELL_PORT+GPIO_DDR,#BELL_BIT ; output
      008161 72 10 50 12      [ 1]  282     bset BELL_PORT+GPIO_CR1,#BELL_BIT ; push pull 
                                    283 ; set LED port as output open drain 
      008165 72 1E 50 07      [ 1]  284 	bset LED_PORT+GPIO_DDR,#LED_BIT
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



      008169 72 1E 50 08      [ 1]  285     bset LED_PORT+GPIO_CR1,#LED_BIT ; push pull 
      0000ED                        286 	_led_off 
      00816D 72 1E 50 05      [ 1]    1     bset LED_PORT,#LED_BIT 
                                    287 ; init TIMER4 to interrupt at every millisecond
      008171 CD 80 A7         [ 4]  288 	call timer4_init
                                    289 ; init TIMER3, for sound generation 
      008174 CD 80 C0         [ 4]  290 	call timer3_init
                                    291 ; configure EXTI on button 
      008177 CD 80 D1         [ 4]  292 	call config_exti
                                    293 ; enable interrupts	
      00817A 9A               [ 1]  294 	rim
      00817B 90 AE 07 D0      [ 2]  295 	ldw y,#2000
      00817F AE 00 96         [ 2]  296 	ldw x,#150
      008182 CD 80 E2         [ 4]  297 	call tone 
      008185                        298 1$:
      000105                        299 	_enable_button
      008185 72 12 50 0E      [ 1]    1     bset BTN_PORT+GPIO_CR2,#BTN_BIT 
      008189 8E               [10]  300     halt  	
      00818A CD 81 3B         [ 4]  301 	call play_tune 
      00818D 20 F6            [ 2]  302 	jra 1$ 
                                    303  
                                    304  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     AWU_APR =  0050F1     |     AWU_CSR1=  0050F0 
    AWU_TBR =  0050F2     |     B115200 =  000006     |     B19200  =  000003 
    B230400 =  000007     |     B2400   =  000000     |     B38400  =  000004 
    B460800 =  000008     |     B4800   =  000001     |     B57600  =  000005 
    B921600 =  000009     |     B9600   =  000002     |     BEEP_CSR=  0050F3 
    BELL_BIT=  000000     |     BELL_POR=  00500F     |     BTN_BIT =  000001 
    BTN_PORT=  00500A     |   7 BtnExtiH   000001 R   |     CFG_GCR =  007F60 
    CFG_GCR_=  000001     |     CFG_GCR_=  000000     |     CLK_CCOR=  0050C5 
    CLK_CKDI=  0050C0     |     CLK_ECKR=  0050C1     |     CLK_PCKE=  0050C3 
    CLK_PCKE=  000006     |     CLK_PCKE=  000003     |     CLK_PCKE=  000004 
    CLK_PCKE=  000000     |     CLK_PCKE=  000001     |     CLK_PCKE=  000002 
    CLK_PCKE=  000005     |     COMP_CCS=  005302     |     COMP_CR =  005300 
    COMP_CSR=  005301     |     CPU_A   =  007F00     |     CPU_CCR =  007F0A 
    CPU_PCE =  007F01     |     CPU_PCH =  007F02     |     CPU_PCL =  007F03 
    CPU_SPH =  007F08     |     CPU_SPL =  007F09     |     CPU_XH  =  007F04 
    CPU_XL  =  007F05     |     CPU_YH  =  007F06     |     CPU_YL  =  007F07 
    DIVR    =  000001     |     DLY_MS  =  000003     |     DM_BK1RE=  007F90 
    DM_BK1RH=  007F91     |     DM_BK1RL=  007F92     |     DM_BK2RE=  007F93 
    DM_BK2RH=  007F94     |     DM_BK2RL=  007F95     |     DM_CR1  =  007F96 
    DM_CR2  =  007F97     |     DM_CSR1 =  007F98     |     DM_CSR2 =  007F99 
    DM_ENFCT=  007F9A     |     EXTI_CON=  0050A5     |     EXTI_CR1=  0050A0 
    EXTI_CR2=  0050A1     |     EXTI_CR3=  0050A2     |     EXTI_SR1=  0050A3 
    EXTI_SR2=  0050A4     |     FLASH_BA=  008000     |     FLASH_CR=  005050 
    FLASH_CR=  000002     |     FLASH_CR=  000000     |     FLASH_CR=  000003 
    FLASH_CR=  000001     |     FLASH_CR=  005051     |     FLASH_CR=  000005 
    FLASH_CR=  000004     |     FLASH_CR=  000007     |     FLASH_CR=  000000 
    FLASH_CR=  000006     |     FLASH_DU=  005053     |     FLASH_DU=  0000AE 
    FLASH_DU=  000056     |     FLASH_EN=  009FFF     |     FLASH_IA=  005054 
    FLASH_IA=  000003     |     FLASH_IA=  000002     |     FLASH_IA=  000006 
    FLASH_IA=  000001     |     FLASH_IA=  000000     |     FLASH_PU=  005052 
    FLASH_PU=  000056     |     FLASH_PU=  0000AE     |     FLASH_SI=  002000 
    FMSTR   =  1E8480     |     FR_TIM3 =  1E8480     |     FTIMER  =  000007 
    Fmaster =  F42400     |     GPIO_BAS=  005000     |     GPIO_CR1=  000003 
    GPIO_CR2=  000004     |     GPIO_DDR=  000002     |     GPIO_IDR=  000001 
    GPIO_ODR=  000000     |     GPIO_SIZ=  000005     |     I2C_CCRH=  00521C 
    I2C_CCRH=  000080     |     I2C_CCRH=  0000C0     |     I2C_CCRH=  000080 
    I2C_CCRH=  000000     |     I2C_CCRH=  000001     |     I2C_CCRH=  000000 
    I2C_CCRL=  00521B     |     I2C_CCRL=  00001A     |     I2C_CCRL=  000002 
    I2C_CCRL=  00000D     |     I2C_CCRL=  000050     |     I2C_CCRL=  000090 
    I2C_CCRL=  0000A0     |     I2C_CR1 =  005210     |     I2C_CR1_=  000006 
    I2C_CR1_=  000007     |     I2C_CR1_=  000000     |     I2C_CR2 =  005211 
    I2C_CR2_=  000002     |     I2C_CR2_=  000003     |     I2C_CR2_=  000000 
    I2C_CR2_=  000001     |     I2C_CR2_=  000007     |     I2C_DR  =  005216 
    I2C_FAST=  000001     |     I2C_FREQ=  005212     |     I2C_ITR =  00521A 
    I2C_ITR_=  000002     |     I2C_ITR_=  000000     |     I2C_ITR_=  000001 
    I2C_OARH=  005214     |     I2C_OARH=  000001     |     I2C_OARH=  000002 
    I2C_OARH=  000006     |     I2C_OARH=  000007     |     I2C_OARL=  005213 
    I2C_OARL=  000001     |     I2C_OARL=  000000     |     I2C_OAR_=  000813 
    I2C_OAR_=  000009     |     I2C_READ=  000001     |     I2C_SR1 =  005217 
    I2C_SR1_=  000003     |     I2C_SR1_=  000001     |     I2C_SR1_=  000002 
    I2C_SR1_=  000006     |     I2C_SR1_=  000000     |     I2C_SR1_=  000004 
    I2C_SR1_=  000007     |     I2C_SR2 =  005218     |     I2C_SR2_=  000002 
    I2C_SR2_=  000001     |     I2C_SR2_=  000000     |     I2C_SR2_=  000003 
    I2C_SR2_=  000005     |     I2C_SR3 =  005219     |     I2C_SR3_=  000001 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]

Symbol Table

    I2C_SR3_=  000007     |     I2C_SR3_=  000004     |     I2C_SR3_=  000000 
    I2C_SR3_=  000002     |     I2C_STD =  000000     |     I2C_TRIS=  00521D 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000005 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_TRIS=  000011 
    I2C_WRIT=  000000     |     INPUT_DI=  000000     |     INPUT_EI=  000001 
    INPUT_FL=  000000     |     INPUT_PU=  000001     |     INT_AWU =  000004 
    INT_CLK =  000002     |     INT_COMP=  000012     |     INT_EXTI=  000008 
    INT_EXTI=  000009     |     INT_EXTI=  00000A     |     INT_EXTI=  00000B 
    INT_EXTI=  00000C     |     INT_EXTI=  00000D     |     INT_EXTI=  00000E 
    INT_EXTI=  00000F     |     INT_EXTI=  000006     |     INT_EXTI=  000007 
    INT_FLAS=  000001     |     INT_I2C =  00001D     |     INT_SPI =  00001A 
    INT_TIM2=  000014     |     INT_TIM2=  000013     |     INT_TIM3=  000016 
    INT_TIM3=  000015     |     INT_TIM4=  000019     |     INT_USAR=  00001C 
    INT_USAR=  00001B     |     INT_VECT=  008018     |     INT_VECT=  008050 
    INT_VECT=  008028     |     INT_VECT=  00802C     |     INT_VECT=  008030 
    INT_VECT=  008024     |     INT_VECT=  008038     |     INT_VECT=  00803C 
    INT_VECT=  008040     |     INT_VECT=  008044     |     INT_VECT=  008020 
    INT_VECT=  008024     |     INT_VECT=  00800C     |     INT_VECT=  00807C 
    INT_VECT=  008000     |     INT_VECT=  008070     |     INT_VECT=  008058 
    INT_VECT=  008054     |     INT_VECT=  008060     |     INT_VECT=  00805C 
    INT_VECT=  00806C     |     INT_VECT=  008004     |     INT_VECT=  008078 
    INT_VECT=  008074     |     IR_CR   =  0052FF     |     ITC_SPR1=  007F70 
    ITC_SPR2=  007F71     |     ITC_SPR3=  007F72     |     ITC_SPR4=  007F73 
    ITC_SPR5=  007F74     |     ITC_SPR6=  007F75     |     ITC_SPR7=  007F76 
    ITC_SPR8=  007F77     |     ITC_SPR_=  000001     |     ITC_SPR_=  000000 
    ITC_SPR_=  000003     |     IWDGOPT_=  000001     |     IWDGOPT_=  000000 
    IWDG_KR =  0050E0     |     IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2 
    LED_BIT =  000007     |     LED_PORT=  005005     |   7 NonHandl   000000 R
    OPT1    =  004800     |     OPT2    =  004802     |     OPT3    =  004803 
    OPT4    =  004808     |     OPTION_B=  004800     |     OPTION_E=  0048FF 
    OUTPUT_F=  000001     |     OUTPUT_O=  000000     |     OUTPUT_P=  000001 
    OUTPUT_S=  000000     |     PA      =  005000     |     PAGE_SIZ=  000040 
    PA_CR1  =  005003     |     PA_CR2  =  005004     |     PA_DDR  =  005002 
    PA_IDR  =  005001     |     PA_ODR  =  005000     |     PB      =  005005 
    PB_CR1  =  005008     |     PB_CR2  =  005009     |     PB_DDR  =  005007 
    PB_IDR  =  005006     |     PB_ODR  =  005005     |     PC      =  00500A 
    PC_CR1  =  00500D     |     PC_CR2  =  00500E     |     PC_DDR  =  00500C 
    PC_IDR  =  00500B     |     PC_ODR  =  00500A     |     PD      =  00500F 
    PD_CR1  =  005012     |     PD_CR2  =  005013     |     PD_DDR  =  005011 
    PD_IDR  =  005010     |     PD_ODR  =  00500F     |     PE      =  005014 
    PF      =  005019     |     PIN0    =  000000     |     PIN1    =  000001 
    PIN2    =  000002     |     PIN3    =  000003     |     PIN4    =  000004 
    PIN5    =  000005     |     PIN6    =  000006     |     PIN7    =  000007 
    RAM_BASE=  000000     |     RAM_END =  0005FF     |     RAM_SIZE=  000600 
    ROP     =  004800     |     RST_CR  =  0050B0     |     RST_SR  =  0050B1 
    SFR_BASE=  005000     |     SFR_END =  0057FF     |     SPI_CR1 =  005200 
    SPI_CR2 =  005201     |     SPI_DR  =  005204     |     SPI_ICR =  005202 
    SPI_SR  =  005203     |     STACK_EM=  0005FF     |     STACK_SI=  000080 
    SWIM_CSR=  007F80     |     TIM2_ARR=  00525E     |     TIM2_ARR=  00525F 
    TIM2_BKR=  005264     |     TIM2_CCE=  00525A     |     TIM2_CCM=  005258 
    TIM2_CCM=  005259     |     TIM2_CCR=  005260     |     TIM2_CCR=  005261 
    TIM2_CCR=  005262     |     TIM2_CCR=  005263     |     TIM2_CNT=  00525B 
    TIM2_CNT=  00525C     |     TIM2_CR1=  005250     |     TIM2_CR2=  005251 
    TIM2_EGR=  005257     |     TIM2_ETR=  005253     |     TIM2_IER=  005254 
    TIM2_OIS=  005265     |     TIM2_PSC=  00525D     |     TIM2_SMC=  005252 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]

Symbol Table

    TIM2_SR1=  005255     |     TIM2_SR2=  005256     |     TIM3_ARR=  00528E 
    TIM3_ARR=  00528F     |     TIM3_BKR=  005294     |     TIM3_CCE=  00528A 
    TIM3_CCM=  005288     |     TIM3_CCM=  005289     |     TIM3_CCR=  005290 
    TIM3_CCR=  005291     |     TIM3_CCR=  005292     |     TIM3_CCR=  005293 
    TIM3_CNT=  00528B     |     TIM3_CNT=  00528C     |     TIM3_CR1=  005280 
    TIM3_CR2=  005281     |     TIM3_EGR=  005287     |     TIM3_ETR=  005283 
    TIM3_IER=  005284     |     TIM3_OIS=  005295     |     TIM3_PSC=  00528D 
    TIM3_SMC=  005282     |     TIM3_SR1=  005285     |     TIM3_SR2=  005286 
    TIM4_ARR=  0052E8     |     TIM4_CNT=  0052E6     |     TIM4_CR1=  0052E0 
    TIM4_CR1=  000007     |     TIM4_CR1=  000000     |     TIM4_CR1=  000003 
    TIM4_CR1=  000001     |     TIM4_CR1=  000002     |     TIM4_CR2=  0052E1 
    TIM4_EGR=  0052E5     |     TIM4_EGR=  000000     |     TIM4_IER=  0052E3 
    TIM4_IER=  000000     |     TIM4_PSC=  0052E7     |     TIM4_PSC=  000000 
    TIM4_PSC=  000007     |     TIM4_PSC=  000004     |     TIM4_PSC=  000001 
    TIM4_PSC=  000005     |     TIM4_PSC=  000002     |     TIM4_PSC=  000006 
    TIM4_PSC=  000003     |     TIM4_PSC=  000000     |     TIM4_PSC=  000001 
    TIM4_PSC=  000002     |     TIM4_SMC=  0052E2     |     TIM4_SR =  0052E4 
    TIM4_SR_=  000000     |     TIM_BKR_=  000006     |     TIM_BKR_=  000004 
    TIM_BKR_=  000005     |     TIM_BKR_=  000000     |     TIM_BKR_=  000007 
    TIM_BKR_=  000002     |     TIM_CCER=  000000     |     TIM_CCER=  000001 
    TIM_CCER=  000004     |     TIM_CCER=  000005     |     TIM_CCMR=  000000 
    TIM_CCMR=  000004     |     TIM_CCMR=  000002     |     TIM_CCMR=  000002 
    TIM_CCMR=  000004     |     TIM_CCMR=  000003     |     TIM_CCMR=  000000 
    TIM_CCMR=  000000     |     TIM_CCMR=  000004     |     TIM_CCMR=  000002 
    TIM_CCMR=  000002     |     TIM_CCMR=  000004     |     TIM_CCMR=  000003 
    TIM_CR1_=  000007     |     TIM_CR1_=  000000     |     TIM_CR1_=  000005 
    TIM_CR1_=  000004     |     TIM_CR1_=  000003     |     TIM_CR1_=  000001 
    TIM_CR1_=  000002     |     TIM_CR2_=  000004     |     TIM_EGR_=  000007 
    TIM_EGR_=  000001     |     TIM_EGR_=  000002     |     TIM_EGR_=  000006 
    TIM_EGR_=  000000     |     TIM_ETR_=  000006     |     TIM_ETR_=  000000 
    TIM_ETR_=  000007     |     TIM_ETR_=  000004     |     TIM_IER_=  000007 
    TIM_IER_=  000001     |     TIM_IER_=  000002     |     TIM_IER_=  000006 
    TIM_IER_=  000000     |     TIM_OISR=  000000     |     TIM_OISR=  000002 
    TIM_PSCR=  000000     |     TIM_SMCR=  000007     |     TIM_SMCR=  000000 
    TIM_SMCR=  000004     |     TIM_SR1_=  000007     |     TIM_SR1_=  000001 
    TIM_SR1_=  000002     |     TIM_SR1_=  000006     |     TIM_SR1_=  000000 
    TIM_SR2_=  000001     |     TIM_SR2_=  000002     |     TREMOLO =  000000 
  7 Timer4Up   00000A R   |     UBC     =  004802     |     USART_BR=  005232 
    USART_BR=  005233     |     USART_CR=  005234     |     USART_CR=  000004 
    USART_CR=  000002     |     USART_CR=  000000     |     USART_CR=  000001 
    USART_CR=  000007     |     USART_CR=  000006     |     USART_CR=  000005 
    USART_CR=  000003     |     USART_CR=  005235     |     USART_CR=  000004 
    USART_CR=  000002     |     USART_CR=  000005     |     USART_CR=  000001 
    USART_CR=  000000     |     USART_CR=  000006     |     USART_CR=  000003 
    USART_CR=  000007     |     USART_CR=  005236     |     USART_CR=  000003 
    USART_CR=  000001     |     USART_CR=  000002     |     USART_CR=  000000 
    USART_CR=  000006     |     USART_CR=  000004     |     USART_CR=  000005 
    USART_CR=  005237     |     USART_CR=  000000     |     USART_CR=  000001 
    USART_CR=  000002     |     USART_CR=  000003     |     USART_CR=  000004 
    USART_CR=  000006     |     USART_CR=  000005     |     USART_DR=  005231 
    USART_SR=  005230     |     USART_SR=  000001     |     USART_SR=  000004 
    USART_SR=  000002     |     USART_SR=  000003     |     USART_SR=  000000 
    USART_SR=  000005     |     USART_SR=  000006     |     USART_SR=  000007 
    VSIZE   =  000004     |     WFE_CR1 =  0050A6     |     WFE_CR2 =  0050A7 
  7 clock_in   000026 R   |   7 config_e   000051 R   |   7 delay_ms   000056 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]

Symbol Table

  5 duration   000005 GR  |   5 flags      000007 GR  |   6 free_ram   000100 GR
  7 play_tun   0000BB R   |   5 ptr        000008 GR  |   7 reset      0000D5 R
  7 score      0000A3 R   |   2 stack_fu   00057F GR  |   2 stack_un   0005FF GR
  5 ticks      000001 GR  |   5 timer      000003 GR  |   7 timer3_i   000040 R
  7 timer4_i   000027 R   |   7 tone       000062 GR  |   7 tone_off   000094 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size      9   flags    8
   6 DATA2      size      0   flags    8
   7 CODE       size    10F   flags    0

