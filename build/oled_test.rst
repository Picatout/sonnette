ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialisation
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23 ;------------------------
                                     24 ; if unified compilation 
                                     25 ; must be first in list 
                                     26 ;-----------------------
                                     27 
                                     28     .module HW_INIT 
                                     29 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     30     .include "config.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;  configuration parameters 
                                      3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      4 
                                      5 ;-----------------------
                                      6 ;  version  
                                      7 ;  information 
                                      8 ;-----------------------
                           000001     9 	MAJOR=1
                           000000    10 	MINOR=0
                           000000    11 	REV=0
                                     12 
                                     13 ; master clock frequency in Mhz 
                           000010    14 	FMSTR=16 
                                     15 
                                     16 ; LED ON pin 5 
                                     17 ; LED port 
                           00500F    18 	LED_PORT =PD 
                           000000    19 	LED_BIT = PIN0  
                                     20 
                                     21 ; beep on pin 1 
                           005000    22 	BEEP_PORT = PA 
                           000000    23 	BEEP_BIT = PIN0 
                                     24 
                                     25 ; I2C port on pin 7,8 
                           00500A    26 	I2C_PORT=PC 
                           000000    27 	SDA_BIT=0
                           000001    28 	SCL_BIT=1
                                     29 
                                     30 ; OLED display buffer size 
                           000080    31 DISPLAY_BUFFER_SIZE=128 ; horz pixels   
                                     32 ; OLED i2c device ID 
                           000078    33 OLED_DEVID=0x78
                                     34 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     35 	.include "inc/ascii.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------------------------------
                                     20 ;     ASCII control  values
                                     21 ;     CTRL_x   are VT100 keyboard values  
                                     22 ; REF: https://en.wikipedia.org/wiki/ASCII    
                                     23 ;-------------------------------------------------------
                           000001    24 		CTRL_A = 1
                           000001    25 		SOH=CTRL_A  ; start of heading 
                           000002    26 		CTRL_B = 2
                           000002    27 		STX=CTRL_B  ; start of text 
                           000003    28 		CTRL_C = 3
                           000003    29 		ETX=CTRL_C  ; end of text 
                           000004    30 		CTRL_D = 4
                           000004    31 		EOT=CTRL_D  ; end of transmission 
                           000005    32 		CTRL_E = 5
                           000005    33 		ENQ=CTRL_E  ; enquery 
                           000006    34 		CTRL_F = 6
                           000006    35 		ACK=CTRL_F  ; acknowledge
                           000007    36 		CTRL_G = 7
                           000007    37         BELL = 7    ; vt100 terminal generate a sound.
                           000008    38 		CTRL_H = 8  
                           000008    39 		BS = 8     ; back space 
                           000009    40         CTRL_I = 9
                           000009    41     	TAB = 9     ; horizontal tabulation
                           00000A    42         CTRL_J = 10 
                           00000A    43 		LF = 10     ; line feed
                           00000B    44 		CTRL_K = 11
                           00000B    45         VT = 11     ; vertical tabulation 
                           00000C    46 		CTRL_L = 12
                           00000C    47         FF = 12      ; new page
                           00000D    48 		CTRL_M = 13
                           00000D    49 		CR = 13      ; carriage return 
                           00000E    50 		CTRL_N = 14
                           00000E    51 		SO=CTRL_N    ; shift out 
                           00000F    52 		CTRL_O = 15
                           00000F    53 		SI=CTRL_O    ; shift in 
                           000010    54 		CTRL_P = 16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
Hexadecimal [24-Bits]



                           000010    55 		DLE=CTRL_P   ; data link escape 
                           000011    56 		CTRL_Q = 17
                           000011    57 		DC1=CTRL_Q   ; device control 1 
                           000011    58 		XON=DC1 
                           000012    59 		CTRL_R = 18
                           000012    60 		DC2=CTRL_R   ; device control 2 
                           000013    61 		CTRL_S = 19
                           000013    62 		DC3=CTRL_S   ; device control 3
                           000013    63 		XOFF=DC3 
                           000014    64 		CTRL_T = 20
                           000014    65 		DC4=CTRL_T   ; device control 4 
                           000015    66 		CTRL_U = 21
                           000015    67 		NAK=CTRL_U   ; negative acknowledge
                           000016    68 		CTRL_V = 22
                           000016    69 		SYN=CTRL_V   ; synchronous idle 
                           000017    70 		CTRL_W = 23
                           000017    71 		ETB=CTRL_W   ; end of transmission block
                           000018    72 		CTRL_X = 24
                           000018    73 		CAN=CTRL_X   ; cancel 
                           000019    74 		CTRL_Y = 25
                           000019    75 		EM=CTRL_Y    ; end of medium
                           00001A    76 		CTRL_Z = 26
                           00001A    77 		SUB=CTRL_Z   ; substitute 
                           00001A    78 		EOF=SUB      ; end of text file in MSDOS 
                           00001B    79 		ESC = 27     ; escape 
                           00001C    80 		FS=28        ; file separator 
                           00001D    81 		GS=29        ; group separator 
                           00001E    82 		RS=30		 ; record separator 
                           00001F    83 		US=31 		 ; unit separator 
                           000020    84 		SPACE = 32
                           00002C    85 		COMMA = 44
                           00003A    86 		COLON = 58 
                           00003B    87 		SEMIC = 59  
                           000023    88 		SHARP = 35
                           000027    89 		TICK = 39
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                                     36 	.include "inc/gen_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                                    110 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                                     37 	.include "app_macros.inc" 
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
                                     19 
                           00F424    20     TIM2_CLK_FREQ=62500
                                     21 
                                     22 ; boolean flags 
                           000007    23     FTIMER=7 
                                     24 
                                     25 ;--------------------------------------
                                     26 ;   assembler flags 
                                     27 ;-------------------------------------
                                     28 
                                     29     ; assume 16 Mhz Fcpu 
                                     30      .macro _usec_dly n 
                                     31     ldw x,#(16*n-2)/4 ; 2 cy 
                                     32     decw x  ; 1 cy 
                                     33     nop     ; 1 cy 
                                     34     jrne .-2 ; 2 cy 
                                     35     .endm 
                                     36 
                                     37 ;----------------------------------
                                     38 ; functions arguments access 
                                     39 ; from stack 
                                     40 ; caller push arguments before call
                                     41 ; and drop them after call  
                                     42 ;----------------------------------    
                                     43     ; get argument in X 
                                     44     .macro _get_arg n 
                                     45     ldw x,(2*(n+1),sp)
                                     46     .endm 
                                     47 
                                     48     ; store X in argument n 
                                     49     .macro _store_arg n 
                                     50     ldw (2*(n+1),sp),x 
                                     51     .endm 
                                     52 
                                     53     ; drop function arguments 
                                     54     .macro _drop_args n 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                                     55     addw sp,#2*n
                                     56     .endm 
                                     57 
                                     58 
                                     59 ;------------------------------------
                                     60 ;  board user LED control macros 
                                     61 ;------------------------------------
                                     62 
                                     63     .macro _led_on 
                                     64         bset LED_PORT,#LED_BIT 
                                     65     .endm 
                                     66 
                                     67     .macro _led_off 
                                     68         bres LED_PORT,#LED_BIT 
                                     69     .endm 
                                     70 
                                     71     .macro _led_toggle
                                     72         bcpl LED_PORT,#LED_BIT  
                                     73     .endm 
                                     74 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                                     38     .include "inc/stm8l001j3.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ; 2023/10/17
                                      3 ; STM8S001J3M3 µC registers map
                                      4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      5 	.module stm8s001J3
                                      6 	
                                      7 
                                      8 ; HSI clock frequency
                           F42400     9  Fmaster = 16000000
                                     10 
                                     11 ; controller memory regions
                           000600    12 RAM_SIZE = (1536) 
                           000800    13 EEPROM_SIZE = (2048)
                           002000    14 FLASH_SIZE = (8192)
                           000040    15 PAGE_SIZE= (64)
                                     16 
                           000000    17  RAM_BASE = (0)
                           0005FF    18  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           009800    19  EEPROM_BASE = (0x9800)
                           009FFF    20  EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
                           005000    21  SFR_BASE = (0x5000)
                           0057FF    22  SFR_END = (0x57FF)
                           008000    23  FLASH_BASE = (0x8000)
                           009FFF    24  FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
                           004800    25  OPTION_BASE = (0x4800)
                           00483F    26  OPTION_END = (0x483F)
                                     27 
                                     28 ; options bytes
                                     29 ; can be programmed only from SWIM  (ICP)
                           004800    30  OPT1  = (0x4800) ; read out protection 
                           004802    31  OPT2  = (0x4802)   ; alternate functions remapping
                           004803    32  OPT3  = (0x4803)   ; misc. options 
                           004808    33  OPT4  = (0x4808)   ; clock options 
                                     34 
                                     35 ; read out protection 
                           004800    36  ROP = OPT1 ; writ 0xAA for protection 
                                     37 ; user boot code protection 
                           004802    38  UBC = OPT2 ; 0..127 pages 
                                     39 ; EEPROM size 0..32 pages 
                           004803    40  DATASIZE = OPT3
                                     41 ; IWDG options 
                           004808    42  IWDGOPT = OPT4
                                     43 
                           000000    44  IWDGOPT_HW = 0 ; IWDG activated by hardware 
                           000001    45  IWDGOPT_HALT = 1 ; IWDG  stopped in HALT mode 
                                     46 
                                     47 ; port bit
                           000000    48  PIN0 = (0) 
                           000001    49  PIN1 = (1)
                           000002    50  PIN2 = (2)
                           000003    51  PIN3 = (3)
                           000004    52  PIN4 = (4)
                           000005    53  PIN5 = (5)
                           000006    54  PIN6 = (6)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                           000007    55  PIN7 = (7)
                                     56 
                           005000    57 GPIO_BASE = (0x5000)
                           000005    58 GPIO_SIZE = (5)
                                     59 ; PORTS SFR OFFSET
                           005000    60 PA = (0x5000)
                           005005    61 PB = (0x5005)
                           00500A    62 PC = (0x500A)
                           00500F    63 PD = (0x500F)
                                     64 
                           000000    65 GPIO_ODR = (0)
                           000001    66 GPIO_IDR = (1)
                           000002    67 GPIO_DDR = (2)
                           000003    68 GPIO_CR1 = (3)
                           000004    69 GPIO_CR2 = (4)
                                     70 
                                     71 ; GPIO
                           005000    72  PA_ODR  = (0x5000)
                           005001    73  PA_IDR  = (0x5001)
                           005002    74  PA_DDR  = (0x5002)
                           005003    75  PA_CR1  = (0x5003)
                           005004    76  PA_CR2  = (0x5004)
                                     77 
                           005005    78  PB_ODR  = (0x5005)
                           005006    79  PB_IDR  = (0x5006)
                           005007    80  PB_DDR  = (0x5007)
                           005008    81  PB_CR1  = (0x5008)
                           005009    82  PB_CR2  = (0x5009)
                                     83 
                           00500A    84  PC_ODR  = (0x500A)
                           00500B    85  PC_IDR  = (0x500B)
                           00500C    86  PC_DDR  = (0x500C)
                           00500D    87  PC_CR1  = (0x500D)
                           00500E    88  PC_CR2  = (0x500E)
                                     89 
                           00500F    90  PD_ODR  = (0x500F)
                           005010    91  PD_IDR  = (0x5010)
                           005011    92  PD_DDR  = (0x5011)
                           005012    93  PD_CR1  = (0x5012)
                           005013    94  PD_CR2  = (0x5013)
                                     95 
                                     96 ; input modes CR1
                           000000    97  INPUT_FLOAT = (0)
                           000001    98  INPUT_PULLUP = (1)
                                     99 ; output mode CR1
                           000000   100  OUTPUT_OD = (0)
                           000001   101  OUTPUT_PP = (1)
                                    102 ; input modes CR2
                           000000   103  INPUT_DI = (0)
                           000001   104  INPUT_EI = (1)
                                    105 ; output speed CR2
                           000000   106  OUTPUT_SLOW = (0)
                           000001   107  OUTPUT_FAST = (1)
                                    108 
                                    109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                                    110 ; Flash
                           005050   111  FLASH_CR1  = (0x5050)
                           005051   112  FLASH_CR2  = (0x5051)
                           005052   113  FLASH_PUKR  = (0x5052)
                           005053   114  FLASH_DUKR  = (0x5053)
                           005054   115  FLASH_IAPSR  = (0x5054)
                                    116 
                                    117 ; data memory unlock keys
                           0000AE   118  FLASH_DUKR_KEY1 = (0xae)
                           000056   119  FLASH_DUKR_KEY2 = (0x56)
                                    120 ; flash memory unlock keys
                           000056   121  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   122  FLASH_PUKR_KEY2 = (0xae)
                                    123 ; FLASH_CR1 bits
                           000003   124  FLASH_CR1_HALT = (3)
                           000002   125  FLASH_CR1_AHALT = (2)
                           000001   126  FLASH_CR1_IE = (1)
                           000000   127  FLASH_CR1_FIX = (0)
                                    128 ; FLASH_CR2 bits
                           000007   129  FLASH_CR2_OPT = (7)
                           000006   130  FLASH_CR2_WPRG = (6)
                           000005   131  FLASH_CR2_ERASE = (5)
                           000004   132  FLASH_CR2_FPRG = (4)
                           000000   133  FLASH_CR2_PRG = (0)
                                    134 ; FLASH_FPR bits
                           000005   135  FLASH_FPR_WPB5 = (5)
                           000004   136  FLASH_FPR_WPB4 = (4)
                           000003   137  FLASH_FPR_WPB3 = (3)
                           000002   138  FLASH_FPR_WPB2 = (2)
                           000001   139  FLASH_FPR_WPB1 = (1)
                           000000   140  FLASH_FPR_WPB0 = (0)
                                    141 ; FLASH_NFPR bits
                           000005   142  FLASH_NFPR_NWPB5 = (5)
                           000004   143  FLASH_NFPR_NWPB4 = (4)
                           000003   144  FLASH_NFPR_NWPB3 = (3)
                           000002   145  FLASH_NFPR_NWPB2 = (2)
                           000001   146  FLASH_NFPR_NWPB1 = (1)
                           000000   147  FLASH_NFPR_NWPB0 = (0)
                                    148 ; FLASH_IAPSR bits
                           000006   149  FLASH_IAPSR_HVOFF = (6)
                           000003   150  FLASH_IAPSR_DUL = (3)
                           000002   151  FLASH_IAPSR_EOP = (2)
                           000001   152  FLASH_IAPSR_PUL = (1)
                           000000   153  FLASH_IAPSR_WR_PG_DIS = (0)
                                    154 
                                    155 ; Interrupt control
                           0050A0   156 EXTI_CR1  = (0x50A0)
                           0050A1   157 EXTI_CR2  = (0x50A1)
                           0050A2   158 EXTI_CR3 = (0x50A2)
                           0050A3   159 EXTI_SR1 =(0x50A3)
                           0050A4   160 EXTI_SR2 =(0x50A4)
                           0050A5   161 EXTI_CONF =(0x50A5)
                                    162 
                                    163 ; WFE control
                           0050A6   164  WFE_CR1  =(0x50A6)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                           0050A7   165  WFE_CR2  =(0x50A7)
                                    166 
                                    167 ; Reset Status
                           0050B0   168  RST_CR  = (0x50B0)
                           0050B1   169  RST_SR = (0x50B1)
                                    170 
                                    171 ; Clock Registers
                           0050C0   172  CLK_CKDIVR =(0x50C0)
                           0050C3   173  CLK_PCKENR =(0x50C3)
                           0050C5   174  CLK_CCOR =(0x50C5)
                                    175 
                                    176 ; Peripherals clock gating
                                    177 ; CLK_PCKENR 
                           000006   178  CLK_PCKENR_AWU_BEEP = (6)
                           000005   179  CLK_PCKENR_USART = (5)
                           000004   180  CLK_PCKENR_SPI = (4)
                           000003   181  CLK_PCKENR_I2C = (3)
                           000002   182  CLK_PCKENR_TIM4 = (2)
                           000001   183  CLK_PCKENR_TIM3 = (1)
                           000000   184  CLK_PCKENR_TIM2 = (0)
                                    185 
                                    186 ; independant watchdog 
                           0050E0   187 IWDG_KR =(0x50E0)
                           0050E1   188 IWDG_PR =(0x50E1)
                           0050E2   189 IWDG_RLR =(0x50E2)
                                    190 
                                    191 ;  auto wake up
                           0050F0   192 AWU_CSR1 =(0x50F0)
                           0050F1   193 AWU_APR =(0x50F1)
                           0050F2   194 AWU_TBR =(0x50F2)
                                    195 
                                    196 ; beep generator control status register 
                           0050F3   197 BEEP_CSR =(0x50F3)
                                    198 
                                    199 ; SPI
                           005200   200  SPI_CR1  = (0x5200)
                           005201   201  SPI_CR2  = (0x5201)
                           005202   202  SPI_ICR  = (0x5202)
                           005203   203  SPI_SR  = (0x5203)
                           005204   204  SPI_DR  = (0x5204)
                                    205  
                                    206 ; I2C
                           005210   207  I2C_CR1  = (0x5210)
                           005211   208  I2C_CR2  = (0x5211)
                           005212   209  I2C_FREQR  = (0x5212)
                           005213   210  I2C_OARL  = (0x5213)
                           005214   211  I2C_OARH  = (0x5214)
                           005216   212  I2C_DR  = (0x5216)
                           005217   213  I2C_SR1  = (0x5217)
                           005218   214  I2C_SR2  = (0x5218)
                           005219   215  I2C_SR3  = (0x5219)
                           00521A   216  I2C_ITR  = (0x521A)
                           00521B   217  I2C_CCRL  = (0x521B)
                           00521C   218  I2C_CCRH  = (0x521C)
                           00521D   219  I2C_TRISER  = (0x521D)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                                    220  
                           000000   221  I2C_STD = 0 
                           000001   222  I2C_FAST = 1 
                                    223 
                           000007   224  I2C_CR1_NOSTRETCH = (7)
                           000006   225  I2C_CR1_ENGC = (6)
                           000000   226  I2C_CR1_PE = (0)
                                    227 
                           000007   228  I2C_CR2_SWRST = (7)
                           000003   229  I2C_CR2_POS = (3)
                           000002   230  I2C_CR2_ACK = (2)
                           000001   231  I2C_CR2_STOP = (1)
                           000000   232  I2C_CR2_START = (0)
                                    233 
                           000000   234  I2C_OARL_ADD0 = (0)
                                    235 
                           000009   236  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   237  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    238 
                           000007   239  I2C_OARH_ADDMODE = (7)
                           000006   240  I2C_OARH_ADDCONF = (6)
                           000002   241  I2C_OARH_ADD9 = (2)
                           000001   242  I2C_OARH_ADD8 = (1)
                                    243 
                           000007   244  I2C_SR1_TXE = (7)
                           000006   245  I2C_SR1_RXNE = (6)
                           000004   246  I2C_SR1_STOPF = (4)
                           000003   247  I2C_SR1_ADD10 = (3)
                           000002   248  I2C_SR1_BTF = (2)
                           000001   249  I2C_SR1_ADDR = (1)
                           000000   250  I2C_SR1_SB = (0)
                                    251 
                           000005   252  I2C_SR2_WUFH = (5)
                           000003   253  I2C_SR2_OVR = (3)
                           000002   254  I2C_SR2_AF = (2)
                           000001   255  I2C_SR2_ARLO = (1)
                           000000   256  I2C_SR2_BERR = (0)
                                    257 
                           000007   258  I2C_SR3_DUALF = (7)
                           000004   259  I2C_SR3_GENCALL = (4)
                           000002   260  I2C_SR3_TRA = (2)
                           000001   261  I2C_SR3_BUSY = (1)
                           000000   262  I2C_SR3_MSL = (0)
                                    263 
                           000002   264  I2C_ITR_ITBUFEN = (2)
                           000001   265  I2C_ITR_ITEVTEN = (1)
                           000000   266  I2C_ITR_ITERREN = (0)
                                    267 
                                    268 ; Precalculated values, all in KHz
                           000080   269  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   270  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    271 ;
                                    272 ; Fast I2C mode max rise time = 300ns
                                    273 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    274 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                                    275 
                           000005   276  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    277 
                           0000C0   278  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   279  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   280  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    281 
                           000080   282  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   283  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   284  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    285 
                           000000   286  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   287  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    288 ;
                                    289 ; Standard I2C mode max rise time = 1000ns
                                    290 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    291 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    292 
                           000011   293  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    294 
                           000000   295  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   296  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   297  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    298 
                           000001   299  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   300  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   301  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    302 
                           000001   303  I2C_READ = 1
                           000000   304  I2C_WRITE = 0
                                    305 
                                    306 ; baudrate constant for brr_value table access
                           000000   307 B2400=0
                           000001   308 B4800=1
                           000002   309 B9600=2
                           000003   310 B19200=3
                           000004   311 B38400=4
                           000005   312 B57600=5
                           000006   313 B115200=6
                           000007   314 B230400=7
                           000008   315 B460800=8
                           000009   316 B921600=9
                                    317 
                                    318 ; USART
                           005230   319  USART_SR    = (0x5230)
                           005231   320  USART_DR    = (0x5231)
                           005232   321  USART_BRR1  = (0x5232)
                           005233   322  USART_BRR2  = (0x5233)
                           005234   323  USART_CR1   = (0x5234)
                           005235   324  USART_CR2   = (0x5235)
                           005236   325  USART_CR3   = (0x5236)
                           005237   326  USART_CR4   = (0x5237)
                                    327 
                                    328 ; USART Status Register bits
                           000007   329  USART_SR_TXE = (7)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                           000006   330  USART_SR_TC = (6)
                           000005   331  USART_SR_RXNE = (5)
                           000004   332  USART_SR_IDLE = (4)
                           000003   333  USART_SR_OR = (3)
                           000002   334  USART_SR_NF = (2)
                           000001   335  USART_SR_FE = (1)
                           000000   336  USART_SR_PE = (0)
                                    337 
                                    338 ; Uart Control Register bits
                           000007   339  USART_CR1_R8 = (7)
                           000006   340  USART_CR1_T8 = (6)
                           000005   341  USART_CR1_USARTD = (5)
                           000004   342  USART_CR1_M = (4)
                           000003   343  USART_CR1_WAKE = (3)
                           000002   344  USART_CR1_PCEN = (2)
                           000001   345  USART_CR1_PS = (1)
                           000000   346  USART_CR1_PIEN = (0)
                                    347 
                           000007   348  USART_CR2_TIEN = (7)
                           000006   349  USART_CR2_TCIEN = (6)
                           000005   350  USART_CR2_RIEN = (5)
                           000004   351  USART_CR2_ILIEN = (4)
                           000003   352  USART_CR2_TEN = (3)
                           000002   353  USART_CR2_REN = (2)
                           000001   354  USART_CR2_RWU = (1)
                           000000   355  USART_CR2_SBK = (0)
                                    356 
                           000006   357  USART_CR3_LINEN = (6)
                           000005   358  USART_CR3_STOP1 = (5)
                           000004   359  USART_CR3_STOP0 = (4)
                           000003   360  USART_CR3_CLKEN = (3)
                           000002   361  USART_CR3_CPOL = (2)
                           000001   362  USART_CR3_CPHA = (1)
                           000000   363  USART_CR3_LBCL = (0)
                                    364 
                           000006   365  USART_CR4_LBDIEN = (6)
                           000005   366  USART_CR4_LBDL = (5)
                           000004   367  USART_CR4_LBDF = (4)
                           000003   368  USART_CR4_ADD3 = (3)
                           000002   369  USART_CR4_ADD2 = (2)
                           000001   370  USART_CR4_ADD1 = (1)
                           000000   371  USART_CR4_ADD0 = (0)
                                    372 
                                    373 ; TIMERS
                                    374 ; Timer 2 - 16-bit timer with complementary PWM outputs
                           005250   375  TIM2_CR1  = (0x5250)
                           005251   376  TIM2_CR2  = (0x5251)
                           005252   377  TIM2_SMCR  = (0x5252)
                           005253   378  TIM2_ETR  = (0x5253)
                           005254   379  TIM2_IER  = (0x5254)
                           005255   380  TIM2_SR1  = (0x5255)
                           005256   381  TIM2_SR2  = (0x5256)
                           005257   382  TIM2_EGR  = (0x5257)
                           005258   383  TIM2_CCMR1  = (0x5258)
                           005259   384  TIM2_CCMR2  = (0x5259)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                           00525A   385  TIM2_CCER1  = (0x525A)
                           00525B   386  TIM2_CNTRH  = (0x525B)
                           00525C   387  TIM2_CNTRL  = (0x525C)
                           00525D   388  TIM2_PSCR  = (0x525D)
                           00525E   389  TIM2_ARRH  = (0x525E)
                           00525F   390  TIM2_ARRL  = (0x525F)
                           005260   391  TIM2_CCR1H  = (0x5260)
                           005261   392  TIM2_CCR1L  = (0x5261)
                           005262   393  TIM2_CCR2H  = (0x5262)
                           005263   394  TIM2_CCR2L  = (0x5263)
                           005264   395  TIM2_BKR  = (0x5264)
                           005265   396  TIM2_OISR  = (0x5265)
                                    397 
                                    398 ; Timer 3 - 16-bit timer
                           005280   399 TIM3_CR1 = (0x5280)
                           005281   400 TIM3_CR2 = (0x5281)
                           005282   401 TIM3_SMCR = (0x5282)
                           005283   402 TIM3_ETR = (0x5283)
                           005284   403 TIM3_IER = (0x5284)
                           005285   404 TIM3_SR1 = (0x5285)
                           005286   405 TIM3_SR2 = (0x5286)
                           005287   406 TIM3_EGR = (0x5287)
                           005288   407 TIM3_CCMR1 = (0x5288)
                           005289   408 TIM3_CCMR2 = (0x5289)
                           00528A   409 TIM3_CCER1 = (0x528A)
                           00528B   410 TIM3_CNTRH = (0x528B)
                           00528C   411 TIM3_CNTRL = (0x528C)
                           00528D   412 TIM3_PSCR = (0x528D)
                           00528E   413 TIM3_ARRH = (0x528E)
                           00528F   414 TIM3_ARRL = (0x528F)
                           005290   415 TIM3_CCR1H = (0x5290)
                           005291   416 TIM3_CCR1L = (0x5291)
                           005292   417 TIM3_CCR2H = (0x5292)
                           005293   418 TIM3_CCR2L = (0x5293)
                           005294   419 TIM3_BKR = (0x5294)
                           005295   420 TIM3_OISR = (0x5295)
                                    421 
                                    422 ; TIM2 and TIM3 registers bits fields 
                                    423 ; Timer Control 1 
                           000007   424  TIM_CR1_ARPE = (7)
                           000005   425  TIM_CR1_CMS = (5) ; field 6:5
                           000004   426  TIM_CR1_DIR = (4)
                           000003   427  TIM_CR1_OPM = (3)
                           000002   428  TIM_CR1_URS = (2)
                           000001   429  TIM_CR1_UDIS = (1)
                           000000   430  TIM_CR1_CEN = (0)
                                    431 
                           000004   432  TIM_CR2_MMS = (4) ; field 6:4
                                    433 
                                    434 ; Timer Slave Mode Control bits
                           000007   435  TIM_SMCR_MSM = (7)
                           000004   436  TIM_SMCR_TS = (4) ; filed 6:4
                           000000   437  TIM_SMCR_SMS = (0) ; filed 2:0
                                    438 
                                    439 ; Timer External Trigger Enable bits
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                           000007   440  TIM_ETR_ETP = (7)
                           000006   441  TIM_ETR_ECE = (6)
                           000004   442  TIM_ETR_ETPS = (4) ; field 5:4
                           000000   443  TIM_ETR_ETF = (0) ; field 3:0
                                    444 
                                    445 ; Timer Interrupt Enable bits
                           000007   446  TIM_IER_BIE = (7)
                           000006   447  TIM_IER_TIE = (6)
                           000002   448  TIM_IER_CC2IE = (2)
                           000001   449  TIM_IER_CC1IE = (1)
                           000000   450  TIM_IER_UIE = (0)
                                    451 
                                    452 ; Timer Status Register 1 bits
                           000007   453  TIM_SR1_BIF = (7)
                           000006   454  TIM_SR1_TIF = (6)
                           000002   455  TIM_SR1_CC2IF = (2)
                           000001   456  TIM_SR1_CC1IF = (1)
                           000000   457  TIM_SR1_UIF = (0)
                                    458 
                                    459 ; Timer status register 2 bits 
                           000002   460  TIM_SR2_CC2OF = (2)
                           000001   461  TIM_SR2_CC1OF = (1)
                                    462 
                                    463 ; Timer Event Generation Register bits
                           000007   464  TIM_EGR_BG = (7)
                           000006   465  TIM_EGR_TG = (6)
                           000002   466  TIM_EGR_CC2G = (2)
                           000001   467  TIM_EGR_CC1G = (1)
                           000000   468  TIM_EGR_UG = (0)
                                    469 
                                    470 ; Capture/Compare Mode Register 1 - channel configured in output
                           000004   471  TIM_CCMR1_OC1M = (4) ; field 6:4
                           000003   472  TIM_CCMR1_OC1PE = (3)
                           000002   473  TIM_CCMR1_OC1FE = (2)
                           000000   474  TIM_CCMR1_CC1S = (0) ; field 1:0
                                    475 
                                    476 ; Capture/Compare Mode Register 1 - channel configured in input
                           000004   477  TIM_CCMR1_IC1F = (4) ; field 7:4
                           000002   478  TIM_CCMR1_IC1PSC = (2) ; field 3:2
                           000000   479  TIM_CCMR1_CC1S = (0) ; field 1:0
                                    480 
                                    481 ; Capture/Compare Mode Register 2 - channel configured in output
                           000004   482  TIM_CCMR2_OC2M = (4) ; field 6:4
                           000003   483  TIM_CCMR2_OC2PE = (3)
                           000002   484  TIM_CCMR2_OC2FE = (2)
                           000000   485  TIM_CCMR2_CC2S0 = (0) ; field 1:0
                                    486 
                                    487 ; Capture/Compare Mode Register 2 - channel configured in input
                           000004   488  TIM_CCMR2_IC2F = (4) ; field 7:4 
                           000002   489  TIM_CCMR2_IC2PSC = (2) ; field 3:2 
                           000000   490  TIM_CCMR2_CC2S = (0) ; field 1:0
                                    491 
                                    492 ; Capture/compare enable register 1 (TIM_CCER1)
                           000005   493 TIM_CCER1_CC2P = (5)
                           000004   494 TIM_CCER1_CC2E = (4)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                           000001   495 TIM_CCER1_CC1P = (1)
                           000000   496 TIM_CCER1_CC1E = (0)
                                    497 
                                    498 ; Prescaler register (TIM_PSCR)
                           000000   499 TIM_PSCR = (0) ; field 2:0
                                    500 
                                    501 ; Break register (TIM_BKR)
                           000007   502 TIM_BKR_MOE = (7)
                           000006   503 TIM_BKR_AOE = (6)
                           000005   504 TIM_BKR_BKP = (5)
                           000004   505 TIM_BKR_BKE = (4)
                           000002   506 TIM_BKR_OSSI = (2)
                           000000   507 TIM_BKR_LOCK = (0) ; field 1:0 
                                    508 
                                    509 ; Output idle state register (TIM_OISR) 
                           000002   510 TIM_OISR_OIS2 = (2)
                           000000   511 TIM_OISR_OIS1 = (0)
                                    512 
                                    513 
                                    514 ; Timer 4
                           0052E0   515 TIM4_CR1 = (0x52E0)
                           0052E1   516 TIM4_CR2 = (0x52E1)
                           0052E2   517 TIM4_SMCR = (0x52E2)
                           0052E3   518 TIM4_IER = (0x52E3)
                           0052E4   519 TIM4_SR1 = (0x52E4)
                           0052E5   520 TIM4_EGR = (0x52E5)
                           0052E6   521 TIM4_CNTR = (0x52E6)
                           0052E7   522 TIM4_PSCR = (0x52E7)
                           0052E8   523 TIM4_ARR = (0x52E8)
                                    524 
                                    525 ; Timer 4 bitmasks
                                    526 
                           000007   527  TIM4_CR1_ARPE = (7)
                           000003   528  TIM4_CR1_OPM = (3)
                           000002   529  TIM4_CR1_URS = (2)
                           000001   530  TIM4_CR1_UDIS = (1)
                           000000   531  TIM4_CR1_CEN = (0)
                                    532 
                           000000   533  TIM4_IER_UIE = (0)
                                    534 
                           000000   535  TIM4_SR_UIF = (0)
                                    536 
                           000000   537  TIM4_EGR_UG = (0)
                                    538 
                           000002   539  TIM4_PSCR_PSC2 = (2)
                           000001   540  TIM4_PSCR_PSC1 = (1)
                           000000   541  TIM4_PSCR_PSC0 = (0)
                                    542 
                           000000   543  TIM4_PSCR_1 = 0
                           000001   544  TIM4_PSCR_2 = 1
                           000002   545  TIM4_PSCR_4 = 2
                           000003   546  TIM4_PSCR_8 = 3
                           000004   547  TIM4_PSCR_16 = 4
                           000005   548  TIM4_PSCR_32 = 5
                           000006   549  TIM4_PSCR_64 = 6
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                           000007   550  TIM4_PSCR_128 = 7
                                    551 
                                    552 ; ADC1 individual data access
                           0053E0   553  ADC1_DB0RH  = (0x53E0)
                           0053E1   554  ADC1_DB0RL  = (0x53E1)
                           0053E2   555  ADC1_DB1RH  = (0x53E2)
                           0053E3   556  ADC1_DB1RL  = (0x53E3)
                           0053E4   557  ADC1_DB2RH  = (0x53E4)
                           0053E5   558  ADC1_DB2RL  = (0x53E5)
                           0053E6   559  ADC1_DB3RH  = (0x53E6)
                           0053E7   560  ADC1_DB3RL  = (0x53E7)
                           0053E8   561  ADC1_DB4RH  = (0x53E8)
                           0053E9   562  ADC1_DB4RL  = (0x53E9)
                           0053EA   563  ADC1_DB5RH  = (0x53EA)
                           0053EB   564  ADC1_DB5RL  = (0x53EB)
                           0053EC   565  ADC1_DB6RH  = (0x53EC)
                           0053ED   566  ADC1_DB6RL  = (0x53ED)
                           0053EE   567  ADC1_DB7RH  = (0x53EE)
                           0053EF   568  ADC1_DB7RL  = (0x53EF)
                           0053F0   569  ADC1_DB8RH  = (0x53F0)
                           0053F1   570  ADC1_DB8RL  = (0x53F1)
                           0053F2   571  ADC1_DB9RH  = (0x53F2)
                           0053F3   572  ADC1_DB9RL  = (0x53F3)
                                    573 
                                    574 ; ADC1 control registers 
                           005400   575  ADC1_CSR  = (0x5400)
                           005401   576  ADC1_CR1  = (0x5401)
                           005402   577  ADC1_CR2  = (0x5402)
                           005403   578  ADC1_CR3  = (0x5403)
                           005404   579  ADC1_DRH  = (0x5404)
                           005405   580  ADC1_DRL  = (0x5405)
                           005406   581  ADC1_TDRH  = (0x5406)
                           005407   582  ADC1_TDRL  = (0x5407)
                           005408   583  ADC1_HTRH  = (0x5408)
                           005409   584  ADC1_HTRL  = (0x5409)
                           00540A   585  ADC1_LTRH  = (0x540A)
                           00540B   586  ADC1_LTRL  = (0x540B)
                           00540C   587  ADC1_AWSRH  = (0x540C)
                           00540D   588  ADC1_AWSRL  = (0x540D)
                           00540E   589  ADC1_AWCRH  = (0x540E)
                           00540F   590  ADC1_AWCRL  = (0x540F)
                                    591 
                                    592 ; ADC1 bitmasks
                                    593 
                           000007   594  ADC1_CSR_EOC = (7)
                           000006   595  ADC1_CSR_AWD = (6)
                           000005   596  ADC1_CSR_EOCIE = (5)
                           000004   597  ADC1_CSR_AWDIE = (4)
                           000003   598  ADC1_CSR_CH3 = (3)
                           000002   599  ADC1_CSR_CH2 = (2)
                           000001   600  ADC1_CSR_CH1 = (1)
                           000000   601  ADC1_CSR_CH0 = (0)
                                    602 
                           000006   603  ADC1_CR1_SPSEL2 = (6)
                           000005   604  ADC1_CR1_SPSEL1 = (5)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                           000004   605  ADC1_CR1_SPSEL0 = (4)
                           000001   606  ADC1_CR1_CONT = (1)
                           000000   607  ADC1_CR1_ADON = (0)
                                    608 
                           000006   609  ADC1_CR2_EXTTRIG = (6)
                           000005   610  ADC1_CR2_EXTSEL1 = (5)
                           000004   611  ADC1_CR2_EXTSEL0 = (4)
                           000003   612  ADC1_CR2_ALIGN = (3)
                           000001   613  ADC1_CR2_SCAN = (1)
                                    614 
                           000007   615  ADC1_CR3_DBUF = (7)
                           000006   616  ADC1_CR3_DRH = (6)
                                    617 
                                    618 ; CPU
                           007F00   619  CPU_A  = (0x7F00)
                           007F01   620  CPU_PCE  = (0x7F01)
                           007F02   621  CPU_PCH  = (0x7F02)
                           007F03   622  CPU_PCL  = (0x7F03)
                           007F04   623  CPU_XH  = (0x7F04)
                           007F05   624  CPU_XL  = (0x7F05)
                           007F06   625  CPU_YH  = (0x7F06)
                           007F07   626  CPU_YL  = (0x7F07)
                           007F08   627  CPU_SPH  = (0x7F08)
                           007F09   628  CPU_SPL   = (0x7F09)
                           007F0A   629  CPU_CCR   = (0x7F0A)
                                    630 
                                    631 ; global configuration register
                           007F60   632  CFG_GCR   = (0x7F60)
                           000000   633  CFG_GCR_SWD = (0)
                           000001   634  CFG_GCR_HALT = (1)	
                                    635 
                                    636 ; interrupt control registers
                           007F70   637  ITC_SPR1   = (0x7F70)
                           007F71   638  ITC_SPR2   = (0x7F71)
                           007F72   639  ITC_SPR3   = (0x7F72)
                           007F73   640  ITC_SPR4   = (0x7F73)
                           007F74   641  ITC_SPR5   = (0x7F74)
                           007F75   642  ITC_SPR6   = (0x7F75)
                           007F76   643  ITC_SPR7   = (0x7F76)
                           007F77   644  ITC_SPR8   = (0x7F77)
                                    645 
                           000001   646 ITC_SPR_LEVEL1=1 
                           000000   647 ITC_SPR_LEVEL2=0
                           000003   648 ITC_SPR_LEVEL3=3 
                                    649 
                                    650 
                                    651 ; SWIM, control and status register
                           007F80   652  SWIM_CSR   = (0x7F80)
                                    653 ; debug registers
                           007F90   654  DM_BK1RE   = (0x7F90)
                           007F91   655  DM_BK1RH   = (0x7F91)
                           007F92   656  DM_BK1RL   = (0x7F92)
                           007F93   657  DM_BK2RE   = (0x7F93)
                           007F94   658  DM_BK2RH   = (0x7F94)
                           007F95   659  DM_BK2RL   = (0x7F95)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           007F96   660  DM_CR1   = (0x7F96)
                           007F97   661  DM_CR2   = (0x7F97)
                           007F98   662  DM_CSR1   = (0x7F98)
                           007F99   663  DM_CSR2   = (0x7F99)
                           007F9A   664  DM_ENFCTR   = (0x7F9A)
                                    665 
                                    666 ; vector 0 is reset 
                                    667 ; vector 1 is TRAP 
                                    668 ; Interrupt Numbers begin at vector 3
                           000001   669 INT_FLASH = 1
                           000004   670 INT_AWU = 4
                           000006   671 INT_EXTIB = 6
                           000007   672 INT_EXTID = 7
                           000008   673 INT_EXTI0 = 8
                           000009   674 INT_EXTI1 = 9
                           00000A   675 INT_EXTI2 = 10
                           00000B   676 INT_EXTI3 = 11
                           00000C   677 INT_EXTI4 = 12
                           00000D   678 INT_EXTI5 = 13
                           00000E   679 INT_EXTI6 = 14
                           00000F   680 INT_EXTI7 = 15
                           000012   681 INT_COMP  = 18
                           000013   682 INT_TIM2_OVF = 19
                           000014   683 INT_TIM2_CC = 20
                           000015   684 INT_TIM3_OVF = 21
                           000016   685 INT_TIM3_CC = 22
                           000019   686 INT_TIM4_OVF = 25
                           00001A   687 INT_SPI  = 26
                           00001B   688 INT_USART_TX = 27 
                           00001C   689 INT_USART_RX = 28 
                           00001D   690 INT_I2C = 29 
                                    691 
                                    692 ; Interrupt Vectors
                           008000   693 INT_VECTOR_RESET = 0x8000
                           008004   694 INT_VECTOR_TRAP = 0x8004
                           00800C   695 INT_VECTOR_FLASH = 0x800C
                           008018   696 INT_VECTOR_AWU = 0x8018
                           008020   697 INT_VECTOR_EXTIB = 0x8020
                           008024   698 INT_VECTOR_EXTID = 0x8024
                           008028   699 INT_VECTOR_EXTI0 = 0x8028
                           00802C   700 INT_VECTOR_EXTI1 = 0x802C
                           008030   701 INT_VECTOR_EXTI2 = 0x8030
                           008034   702 INT_VECTOR_EXTI3 = 0x8034
                           008038   703 INT_VECTOR_EXTI4 = 0x8038
                           00803C   704 INT_VECTOR_EXTI5 = 0x803C
                           008040   705 INT_VECTOR_EXTI6 = 0x8040
                           008044   706 INT_VECTOR_EXTI7 = 0x8044
                           008050   707 INT_VECTOR_COMP  = 0x8050
                           008054   708 INT_VECTOR_TIM2_OVF = 0x8054
                           008058   709 INT_VECTOR_TIM2_CCM = 0x8058
                           00805C   710 INT_VECTOR_TIM3_OVF = 0x805C
                           008060   711 INT_VECTOR_TIM3_CCM = 0x8060
                           00806C   712 INT_VECTOR_TIM4_OVF = 0x806C
                           008070   713 INT_VECTOR_SPI = 0x8070
                           008074   714 INT_VECTOR_USART_TX_COMPLETE = 0x8074
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           008078   715 INT_VECTOR_USART_RX_FULL = 0x8078
                           00807C   716 INT_VECTOR_I2C = 0x807C
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                                     39 	.include "inc/ssd1306.inc" 
                                      1 ;-----------------------
                                      2 ;  SSD1306 commands set 
                                      3 ;-----------------------
                                      4 
                                      5 
                           000040     6 DISP_HEIGHT=64 ; pixels 
                           000080     7 DISP_WIDTH=128 ; pixels 
                                      8 
                                      9 ;-------------------------------
                                     10 ;  SSD1306 commands set 
                                     11 ;-------------------------------
                                     12 ; display on/off commands 
                           0000AE    13 DISP_OFF=0XAE      ; turn off display 
                           0000AF    14 DISP_ON=0XAF       ; turn on display 
                           000081    15 DISP_CONTRAST=0X81 ; adjust contrast 0..127
                           0000A4    16 DISP_RAM=0XA4     ; diplay RAM bits 
                           0000A5    17 DISP_ALL_ON=0XA5  ; all pixel on 
                           0000A6    18 DISP_NORMAL=0XA6  ; normal display, i.e. bit set oled light 
                           0000A7    19 DISP_INVERSE=0XA7 ; inverted display 
                           00008D    20 DISP_CHARGE_PUMP=0X8D ; enable charge pump 
                                     21 ; scrolling commands 
                           000026    22 SCROLL_RIGHT=0X26  ; scroll pages range right 
                           000027    23 SCROLL_LEFT=0X27   ; scroll pages range left 
                           000029    24 SCROLL_VRIGHT=0X29 ; scroll vertical and right  
                           00002A    25 SCROLL_VLEFT=0X2A ; scroll vertical and left 
                           00002E    26 SCROLL_STOP=0X2E   ; stop scrolling 
                           00002F    27 SCROLL_START=0X2F  ; start scrolling 
                           0000A3    28 VERT_SCROLL_AREA=0XA3  ; set vertical scrolling area 
                                     29 ; addressing setting commands 
                                     30 ; 0x00-0x0f set lower nibble for column start address, page mode  
                                     31 ; 0x10-0x1f set high nibble for column start address, page mode 
                           000020    32 ADR_MODE=0X20 ; 0-> horz mode, 1-> vert mode, 2->page mode 
                           000021    33 COL_WND=0X21 ; set column window for horz and vert mode 
                           000022    34 PAG_WND=0X22 ; set page window for horz and vert mode 
                                     35 ; 0xb0-0xb7 set start page for page mode 
                           000040    36 START_LINE=0X40 ; 0x40-0x7f set display start line 
                           0000A0    37 MAP_SEG0_COL0=0XA0 ; map segment 0 to column 0 
                           0000A1    38 MAP_SEG0_COL128=0XA1 ; inverse mapping segment 0 to col 127   
                           0000A8    39 MUX_RATIO=0XA8 ; reset to 64 
                           0000C0    40 SCAN_TOP_DOWN=0XC0 ; scan from COM0 to COM63 
                           0000C8    41 SCAN_REVERSE=0XC8 ; scan from COM63 to COM0 
                           0000D3    42 DISP_OFFSET=0XD3 ; display offset to COMx 
                           0000DA    43 COM_CFG=0XDA ; set COM pins hardware configuration 
                                     44 ;Timing & Driving Scheme Setting Command Table
                           0000D5    45 CLK_FREQ_DIV=0xD5 ; clock frequency and divisor 
                           0000D9    46 PRE_CHARGE=0xD9 ; set pre-charge period 
                           0000DB    47 VCOMH_DSEL=0XDB ; set Vcomh deselect level 
                           0000E3    48 OLED_NOP=0xE3 
                                     49 
                                     50 ; memory addressing mode 
                           000000    51 HORZ_MODE=0 ; At each byte write column address pointer increase by 1 
                                     52             ; when reach end rollback to 0 and page pointer is increased by 1.
                           000001    53 VERT_MODE=1 ; At each byte write page pointer is increased by 1 and 
                                     54             ; when last page is reached rollback to page 0 and column pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                                     55             ; is increased by 1.
                           000002    56 PAGE_MODE=2 ; At each byte write column address pointer is increased by 1 
                                     57             ; when reach end rollback to 0 but page address pointer is not modified. 
                                     58 
                                     59 ; switch charge pump on/off 
                           000010    60 CP_OFF=0x10 
                           000014    61 CP_ON=0x14 
                                     62 
                                     63 ; co byte, first byte sent 
                                     64 ; after device address.
                           000080    65 OLED_CMD=0x80 
                           000040    66 OLED_DATA=0x40 
                                     67 
                                     68 
                                     69 ;--------------------------------
                                     70 ; command 0XDA parameter  
                                     71 ; COM pins hardware configuration
                                     72 ;--------------------------------
                           000000    73 COM_SEQUENTIAL=0 ; sequential pin scanning 0..63
                           000010    74 COM_ALTERNATE=0x10 ; alternate pin scanning 
                           000000    75 COM_DISABLE_REMAP=0  ; direct scanning 
                           000020    76 COM_ENABLE_REMAP=0x20 ; inverse scanning 
                                     77 
                                     78 ;------------------------
                                     79 ; command 0xD5 
                                     80 ; set display clock Divide
                                     81 ; and frequency 
                                     82 ;--------------------------
                           000004    83 CLK_FREQ=4; bit field 7:4 clok frequency (0..15)
                           000000    84 DISP_DIV=0 ; bit field 3:0 display clock divisor {0..15}
                                     85 
                                     86 ;--------------------------
                                     87 ; command 0xD9 
                                     88 ; set pre-charge period 
                                     89 ;-------------------------
                           000000    90 PHASE1_PERIOD=0 ; bit field 3:0 range {0..15}
                           000004    91 PHASE2_PERIOD=4 ; bit field 7:4 range {0..15}
                                     92 
                                     93 ;-------------------------
                                     94 ; command 0XDB 
                                     95 ; set Vcomh deslect level 
                                     96 ;------------------------
                           000000    97 VCOMH_DSEL_65=0
                           000020    98 VCOMH_DSEL_77=0X20 
                           000030    99 VCOMH_DSEL_83=0X30
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                     40 
                                     41 
                                     42 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                                     31 
                                     32 
                           000080    33 STACK_SIZE=128
                           0005FF    34 STACK_EMPTY=RAM_SIZE-1 
                                     35 
                                     36 ;;-----------------------------------
                                     37     .area SSEG (ABS)
                                     38 ;; working buffers and stack at end of RAM. 	
                                     39 ;;-----------------------------------
      00057F                         40     .org RAM_END - STACK_SIZE 
      00057F                         41 stack_full:: .ds STACK_SIZE   ; control stack 
      0005FF                         42 stack_unf: ; stack underflow ; control_stack bottom 
                                     43 
                                     44 ;;--------------------------------------
                                     45     .area HOME 
                                     46 ;; interrupt vector table at 0x8000
                                     47 ;;--------------------------------------
                                     48 
      008000 82 00 80 BF             49     int cold_start			; RESET vector 
      008004 82 00 80 80             50 	int NonHandledInterrupt ; trap instruction 
      008008 00 00 00 00             51 	.word 0,0  ; vector 0 not used 
      00800C 82 00 80 80             52 	int NonHandledInterrupt ;int0 FLASH programming  
      008010 00 00 00 00 00 00 00    53 	.word 0,0,0,0  ; vector 2,3 not used 
             00
      008018 82 00 80 80             54 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      00801C 00 00 00 00             55 	.word 0,0 ; vector 5 not used 
      008020 82 00 80 80             56 	int NonHandledInterrupt ;int6 EXITB 
      008024 82 00 80 80             57 	int NonHandledInterrupt ;int7 EXTID 
      008028 82 00 80 80             58 	int NonHandledInterrupt ;int8 EXTI0
      00802C 82 00 80 80             59 	int NonHandledInterrupt ;int9 EXIT1  
      008030 82 00 80 80             60 	int NonHandledInterrupt ;int10 EXTI2 gpio C external interrupts
      008034 82 00 80 80             61 	int NonHandledInterrupt ;int11 EXTI3 gpio D external interrupts
      008038 82 00 80 80             62 	int NonHandledInterrupt ;int12 EXTI4 
      00803C 82 00 80 80             63 	int NonHandledInterrupt ;int13 EXTI5  
      008040 82 00 80 80             64 	int NonHandledInterrupt ;int14 EXTI6 
      008044 82 00 80 80             65 	int NonHandledInterrupt ;int15 EXTI7 
      008048 00 00 00 00 00 00 00    66 	.word 0,0,0,0 ; vector 16,17 not used 
             00
      008050 82 00 80 80             67 	int NonHandledInterrupt ;int18 comparators
      008054 82 00 80 80             68 	int NonHandledInterrupt ;int19 TIM2 update /overflow
      008058 82 00 80 80             69 	int NonHandledInterrupt ;int20 TIM2 capture/compare
      00805C 82 00 80 80             70 	int NonHandledInterrupt ;int21 TIM3 Update/overflow
      008060 82 00 80 80             71 	int NonHandledInterrupt ;int22 TIM3 Capture/compare
      008064 00 00 00 00 00 00 00    72 	.word 0,0,0,0 ; vector 23,24 not used 
             00
      00806C 82 00 80 81             73 	int Timer4UpdateHandler	;int25 TIM4 update/overflow 
      008070 82 00 80 80             74 	int NonHandledInterrupt ;int26 SPI End of transfer
      008074 82 00 80 80             75 	int NonHandledInterrupt ;int28 USART TX completed
      008078 82 00 80 80             76 	int NonHandledInterrupt ;int28 USART RX full 
      00807C 82 00 81 1C             77 	int I2cIntHandler       ;int29 I2C 
                                     78 
                                     79 
                                     80 ;--------------------------------------
                                     81     .area DATA (ABS)
      000000                         82 	.org 0  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                                     83 ;--------------------------------------	
                                     84 ; keep the following 3 variables in this order 
      000000                         85 ticks: .blkb 2 ; milliseconds ticks counter (see Timer4UpdateHandler)
      000002                         86 timer:: .blkw 1 ;  milliseconds count down timer 
      000004                         87 seedx: .blkw 1  ; xorshift 16 seed x  used by RND() function 
      000006                         88 seedy: .blkw 1  ; xorshift 16 seed y  used by RND() funcion
      000008                         89 acc32:: .blkb 1 ; 32 bit accumalator upper-byte 
      000009                         90 acc24:: .blkb 1 ; 24 bits accumulator upper-byte 
      00000A                         91 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      00000B                         92 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      00000C                         93 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      00000D                         94 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      00000E                         95 flags:: .blkb 1 ; various boolean flags
                                     96 ; I2C peripheral 
      00000F                         97 i2c_buf: .blkw 1 ; i2c buffer address 
      000011                         98 i2c_count: .blkb 1 ; bytes to transmit 
      000012                         99 i2c_idx: .blkb 1 ; index in buffer
      000013                        100 i2c_status: .blkb 1 ; error status 
      000014                        101 i2c_devid: .blkb 1 ; device identifier  
                                    102 ;; OLED display 
      000015                        103 line: .blkb 1 ; text line cursor position 
      000016                        104 col: .blkb 1 ;  text column cursor position
      000017                        105 cpl: .blkb 1 ; characters per line 
      000018                        106 disp_lines: .blkb 1 ; text lines per display  
      000019                        107 font_width: .blkb 1 ; character width in pixels 
      00001A                        108 font_height: .blkb 1 ; character height in pixels 
      00001B                        109 to_send: .blkb 1 ; bytes to send per character 
      00001C                        110 disp_flags: .blkb 1 ; boolean flags 
                                    111 
      000100                        112 	.org 0x100
      000100                        113 co_code: .blkb 1	
      000101                        114 disp_buffer: .ds DISPLAY_BUFFER_SIZE ; oled display page buffer 
                                    115 
      000181                        116 free_ram: ; from here RAM free for BASIC text 
                                    117 
                                    118 	.area CODE 
                                    119 
                                    120 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    121 ; non handled interrupt 
                                    122 ; reset MCU
                                    123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        124 NonHandledInterrupt:
      008080 80               [11]  125 	iret 
                                    126 
                                    127 ;------------------------------
                                    128 ; TIMER 4 is used to maintain 
                                    129 ; a milliseconds 'ticks' counter
                                    130 ; and decrement 'timer' varaiable
                                    131 ; ticks range {0..65535}
                                    132 ; timer range {0..65535}
                                    133 ;--------------------------------
      008081                        134 Timer4UpdateHandler:
      008081 72 5F 52 E4      [ 1]  135 	clr TIM4_SR1 
      000005                        136 	_ldxz ticks
      008085 BE 00                    1     .byte 0xbe,ticks 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]



      008087 1C 00 01         [ 2]  137 	addw x,#1 
      00000A                        138 	_strxz ticks 
      00808A BF 00                    1     .byte 0xbf,ticks 
      00808C 72 0F 00 0E 0B   [ 2]  139 	btjf flags,#FTIMER,1$
      000011                        140 	_ldxz timer
      008091 BE 02                    1     .byte 0xbe,timer 
      008093 5A               [ 2]  141 	decw x 
      000014                        142 	_strxz timer
      008094 BF 02                    1     .byte 0xbf,timer 
      008096 26 04            [ 1]  143 	jrne 1$ 
      008098 72 1F 00 0E      [ 1]  144 	bres flags,#FTIMER  
      00809C                        145 1$:	
      00809C 80               [11]  146 	iret 
                                    147 
                                    148 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    149 ;    peripherals initialization
                                    150 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    151 
                                    152 ;----------------------------------------
                                    153 ; inialize MCU clock 
                                    154 ; input:
                                    155 ;   A       fmstr Mhz 
                                    156 ;   XL      CLK_CKDIVR , clock divisor
                                    157 ;   XH     HSI|HSE   
                                    158 ; output:
                                    159 ;   none 
                                    160 ;----------------------------------------
      00809D                        161 clock_init:	
      00809D 72 5F 50 C0      [ 1]  162 	clr CLK_CKDIVR 
      0080A1 72 16 50 C3      [ 1]  163 	bset CLK_PCKENR,#CLK_PCKENR_I2C 
      0080A5 81               [ 4]  164 	ret
                                    165 
                                    166 ;---------------------------------
                                    167 ; TIM4 is configured to generate an 
                                    168 ; interrupt every millisecond 
                                    169 ;----------------------------------
      0080A6                        170 timer4_init:
      0080A6 72 14 50 C3      [ 1]  171 	bset CLK_PCKENR,#CLK_PCKENR_TIM4
      0080AA 72 11 52 E0      [ 1]  172 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080AE 35 07 52 E7      [ 1]  173 	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
      0080B2 35 83 52 E8      [ 1]  174 	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
      0080B6 35 05 52 E0      [ 1]  175 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080BA 72 10 52 E3      [ 1]  176 	bset TIM4_IER,#TIM4_IER_UIE
      0080BE 81               [ 4]  177 	ret
                                    178 
                                    179 ;-------------------------------------
                                    180 ;  initialization entry point 
                                    181 ;-------------------------------------
      0080BF                        182 cold_start:
                                    183 ;set stack 
      0080BF AE 05 FF         [ 2]  184 	ldw x,#STACK_EMPTY
      0080C2 94               [ 1]  185 	ldw sp,x
                                    186 ; clear all ram 
      0080C3 7F               [ 1]  187 0$: clr (x)
      0080C4 5A               [ 2]  188 	decw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



      0080C5 26 FC            [ 1]  189 	jrne 0$
      0080C7 CD 81 02         [ 4]  190 call swim_probe
                                    191 ; set pull up on
                                    192 ; pin 2 -> PA2 
      0080CA 72 14 50 03      [ 1]  193 	bset PA_CR1,#2
                                    194 ; pin 5 -> PD0 
      0080CE 72 10 50 12      [ 1]  195 	bset PD_CR1,#0 
                                    196 ; pin 6 -> PB6 
      0080D2 72 1C 50 08      [ 1]  197 	bset PB_CR1,#6 
                                    198 ; if PA2 == 0 then loop until released 
                                    199 ; in case PA0 is used as GPIO by program 
                                    200 ; which forbid SWIM. 
      0080D6 72 05 50 01 FB   [ 2]  201 	btjf PA_IDR,#2,. 
                                    202 ; set user LED pin as output 
      0080DB 72 10 50 11      [ 1]  203     bset LED_PORT+GPIO_DDR,#LED_BIT ; output
      0080DF 72 10 50 12      [ 1]  204     bset LED_PORT+GPIO_CR1,#LED_BIT ; push pull 
      0080E3 72 11 50 0F      [ 1]  205 	bres LED_PORT+GPIO_ODR,#LED_BIT ; turn off user LED  
      0080E7 CD 80 9D         [ 4]  206     call clock_init 
      0080EA CD 80 A6         [ 4]  207 	call timer4_init ; msec ticks timer 
      0080ED A6 01            [ 1]  208 	ld a,#I2C_FAST 
      0080EF CD 82 3F         [ 4]  209 	call i2c_init 
      0080F2 9A               [ 1]  210 	rim ; enable interrupts 
                                    211 ; RND function seed 
                                    212 ; must be initialized 
                                    213 ; to value other than 0.
                                    214 ; take values from ROM space 
      0080F3 AE 81 1C         [ 2]  215 	ldw x,#I2cIntHandler
      0080F6 CF 00 06         [ 2]  216 	ldw seedy,x  
      0080F9 AE 88 DC         [ 2]  217 	ldw x,#main 
      0080FC CF 00 04         [ 2]  218 	ldw seedx,x  
      0080FF CC 88 DC         [ 2]  219     jp main 	
                                    220 
                                    221 
                                    222 ;---------------------
                                    223 ; probe PB6 
                                    224 ; if 0 then loop  
                                    225 ; until released 
                                    226 ; needed for SWIM 
                                    227 ; in case PA0 used 
                                    228 ; as output 
                                    229 ;---------------------
      008102                        230 swim_probe:
      008102 3B 50 08         [ 1]  231 	push PB_CR1
      008105 3B 50 07         [ 1]  232 	push PB_DDR
      008108 72 1D 50 07      [ 1]  233 	bres PB_DDR,#6 
      00810C 72 1C 50 08      [ 1]  234 	bset PB_CR1,#6 ; pull up 
      008110 72 0D 50 06 FB   [ 2]  235 	btjf PB_IDR,#6,.
      008115 32 50 07         [ 1]  236 	pop PB_DDR 
      008118 32 50 08         [ 1]  237 	pop PB_CR1
      00811B 81               [ 4]  238 	ret 
                                    239 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_i2c 
                                      4 ;
                                      5 ;     stm8_i2c is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_i2c is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_i2c.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20     .area CODE 
                                     21 ;-------------------------------------
                                     22 ;    I2C macros 
                                     23 ;-------------------------------------
                                     24     .macro _i2c_stop 
                                     25     bset I2C_CR2,#I2C_CR2_STOP
                                     26     .endm 
                                     27 
                                     28 ;--------------------------------
                                     29 ;  I2C peripheral driver 
                                     30 ;  Support only 7 bit addressing 
                                     31 ;  and master mode 
                                     32 ;--------------------------------
                                     33 
                           000007    34 I2C_STATUS_DONE=7 ; bit 7 of i2c_status indicate operation completed  
                           000006    35 I2C_STATUS_NO_STOP=6 ; don't send a stop at end of transmission
                           000005    36 I2C_STATUS_ACTIV=5 ; i2c peripheral initlialized and enabled 
                                     37 
                                     38 
                                     39 ;------------------------------
                                     40 ; i2c global interrupt handler
                                     41 ;------------------------------
      00811C                         42 I2cIntHandler:
      00811C C6 52 18         [ 1]   43     ld a, I2C_SR2 ; errors status 
      00811F 72 5F 52 18      [ 1]   44     clr I2C_SR2 
      008123 A4 0F            [ 1]   45     and a,#15 
      008125 27 0A            [ 1]   46     jreq 1$
      008127 CA 00 13         [ 1]   47     or a,i2c_status 
      0000AA                         48     _straz i2c_status 
      00812A B7 13                    1     .byte 0xb7,i2c_status 
      00812C 72 12 52 11      [ 1]   49     bset I2C_CR2,#I2C_CR2_STOP
      008130 80               [11]   50     iret 
      008131                         51 1$: ; no error detected 
      008131 72 0F 00 13 05   [ 2]   52     btjf i2c_status,#I2C_STATUS_DONE,2$
      008136 72 5F 52 1A      [ 1]   53     clr I2C_ITR 
      00813A 80               [11]   54     iret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                     55 ; handle events 
      0000BB                         56 2$: _ldxz i2c_idx  
      00813B BE 12                    1     .byte 0xbe,i2c_idx 
      00813D 72 00 52 17 1A   [ 2]   57     btjt I2C_SR1,#I2C_SR1_SB,evt_sb 
      008142 72 02 52 17 1B   [ 2]   58     btjt I2C_SR1,#I2C_SR1_ADDR,evt_addr 
      008147 72 04 52 17 31   [ 2]   59     btjt I2C_SR1,#I2C_SR1_BTF,evt_btf  
      00814C 72 0E 52 17 17   [ 2]   60     btjt I2C_SR1,#I2C_SR1_TXE,evt_txe 
      008151 72 0C 52 17 40   [ 2]   61     btjt I2C_SR1,#I2C_SR1_RXNE,evt_rxne 
      008156 72 08 52 17 56   [ 2]   62     btjt I2C_SR1,#I2C_SR1_STOPF,evt_stopf 
      00815B 80               [11]   63     iret 
                                     64 
      00815C                         65 evt_sb: ; EV5  start bit sent 
      0000DC                         66     _ldaz i2c_devid
      00815C B6 14                    1     .byte 0xb6,i2c_devid 
      00815E C7 52 16         [ 1]   67     ld I2C_DR,a ; send device address 
      008161 80               [11]   68     iret 
                                     69 
      008162                         70 evt_addr: ; EV6  address sent, send data bytes  
      008162 72 04 52 19 01   [ 2]   71     btjt I2C_SR3,#I2C_SR3_TRA,evt_txe
      008167 80               [11]   72     iret 
                                     73 
                                     74 ; master transmit mode 
      008168                         75 evt_txe: ; EV8  send data byte 
      0000E8                         76     _ldyz i2c_count 
      008168 90 BE 11                 1     .byte 0x90,0xbe,i2c_count 
      00816B 27 1C            [ 1]   77     jreq end_of_tx 
      00816D                         78 evt_txe_1:
      00816D 72 D6 00 0F      [ 4]   79     ld a,([i2c_buf],x)
      008171 C7 52 16         [ 1]   80     ld I2C_DR,a
      008174 5C               [ 1]   81     incw x 
      0000F5                         82     _strxz i2c_idx 
      008175 BF 12                    1     .byte 0xbf,i2c_idx 
      008177 90 5A            [ 2]   83     decw y  
      0000F9                         84     _stryz i2c_count  
      008179 90 BF 11                 1     .byte 0x90,0xbf,i2c_count 
      00817C 80               [11]   85 1$: iret 
                                     86 
                                     87 ; only append if no STOP send 
      00817D                         88 evt_btf: 
      00817D 72 05 52 19 14   [ 2]   89     btjf I2C_SR3,#I2C_SR3_TRA,#evt_rxne  
      000102                         90     _ldyz i2c_count 
      008182 90 BE 11                 1     .byte 0x90,0xbe,i2c_count 
      008185 26 E6            [ 1]   91     jrne evt_txe_1 
      008187 20 00            [ 2]   92     jra end_of_tx 
                                     93 
                                     94 ; end of transmission
      008189                         95 end_of_tx:
      008189 72 1E 00 13      [ 1]   96     bset i2c_status,#I2C_STATUS_DONE  
                                     97 ;    btjt i2c_status,#I2C_STATUS_NO_STOP,1$
      00818D 72 12 52 11      [ 1]   98     bset I2C_CR2,#I2C_CR2_STOP
      008191 72 5F 52 1A      [ 1]   99 1$: clr I2C_ITR
      008195 80               [11]  100     iret 
                                    101 
                                    102 ; master receive mode 
      008196                        103 evt_rxne: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



      000116                        104     _ldyz i2c_count 
      008196 90 BE 11                 1     .byte 0x90,0xbe,i2c_count 
      008199 27 16            [ 1]  105     jreq evt_stopf  
      00819B C6 52 16         [ 1]  106 1$: ld a,I2C_DR 
      00819E 72 D7 00 0F      [ 4]  107     ld ([i2c_buf],x),a  
      0081A2 5C               [ 1]  108     incw x 
      000123                        109     _strxz i2c_idx 
      0081A3 BF 12                    1     .byte 0xbf,i2c_idx 
      0081A5 90 5A            [ 2]  110     decw y 
      000127                        111     _stryz i2c_count
      0081A7 90 BF 11                 1     .byte 0x90,0xbf,i2c_count 
      0081AA 26 04            [ 1]  112     jrne 4$
      0081AC 72 15 52 11      [ 1]  113     bres I2C_CR2,#I2C_CR2_ACK
      0081B0 80               [11]  114 4$: iret 
                                    115 
      0081B1                        116 evt_stopf:
      0081B1 C6 52 16         [ 1]  117     ld a,I2C_DR 
      0081B4 72 D7 00 0F      [ 4]  118     ld ([i2c_buf],x),a 
      0081B8 72 12 52 11      [ 1]  119     bset I2C_CR2,#I2C_CR2_STOP
      0081BC 72 1E 00 13      [ 1]  120     bset i2c_status,#I2C_STATUS_DONE
      0081C0 72 5F 52 1A      [ 1]  121     clr I2C_ITR 
      0081C4 80               [11]  122     iret  
                                    123 
                                    124 ; error message 
                           000000   125 I2C_ERR_NONE=0 
                           000001   126 I2C_ERR_NO_ACK=1 ; no ack received 
                           000002   127 I2C_ERR_OVR=2 ; overrun 
                           000003   128 I2C_ERR_ARLO=3 ; arbitration lost 
                           000004   129 I2C_ERR_BERR=4 ; bus error 
                           000005   130 I2C_ERR_TIMEOUT=5 ; operation time out 
                                    131 ;---------------------------
                                    132 ; display error message 
                                    133 ; blink error code on LED
                                    134 ; in binary format 
                                    135 ; most significant bit first 
                                    136 ; 0 -> 100msec blink
                                    137 ; 1 -> 300msec blink 
                                    138 ; space -> 100msec LED off 
                                    139 ; inter code -> 500msec LED off
                                    140 ;---------------------------
      0081C5                        141 i2c_error:
      000145                        142     _ldaz i2c_status 
      0081C5 B6 13                    1     .byte 0xb6,i2c_status 
      0081C7 4E               [ 1]  143     swap a 
      0081C8 C7 00 0B         [ 1]  144     ld acc8,a 
      0081CB 4B 04            [ 1]  145     push #4 
      0081CD                        146 nibble_loop:     
      0081CD A6 0C            [ 1]  147     ld a,#12 
      0081CF CD 88 B4         [ 4]  148     call beep 
      0081D2 72 58 00 0B      [ 1]  149     sll acc8  
      0081D6 25 05            [ 1]  150     jrc blink1 
      0081D8                        151 blink0:
      0081D8 AE 00 C8         [ 2]  152     ldw x,#200
      0081DB 20 03            [ 2]  153     jra blink
      0081DD                        154 blink1: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



      0081DD AE 02 58         [ 2]  155     ldw x,#600 
      0081E0                        156 blink:
      0081E0 CD 88 D0         [ 4]  157     call pause 
      0081E3 4F               [ 1]  158     clr a 
      0081E4 CD 88 B4         [ 4]  159     call beep  
      0081E7 AE 00 C8         [ 2]  160     ldw x,#200 
      0081EA CD 88 D0         [ 4]  161     call pause 
      0081ED 0A 01            [ 1]  162     dec (1,sp)
      0081EF 26 DC            [ 1]  163     jrne nibble_loop 
      0081F1 84               [ 1]  164     pop a 
      0081F2 AE 02 BC         [ 2]  165     ldw x,#700 
      0081F5 CD 88 D0         [ 4]  166     call pause 
      0081F8 20 CB            [ 2]  167 jra i2c_error     
      0081FA 81               [ 4]  168     ret  
                                    169 
                           000000   170 .if 0
                                    171 ;----------------------------
                                    172 ; set_i2c_params(devid,count,buf_addr,no_stop)
                                    173 ; set i2c operation parameters  
                                    174 ; 
                                    175 ; devid: BYTE 
                                    176 ;     7 bit device identifier 
                                    177 ;
                                    178 ; count: BYTE 
                                    179 ;     bytes to send|receive
                                    180 ;
                                    181 ; buf_addr: WORD 
                                    182 ;     pointer to buffer 
                                    183 ;  
                                    184 ; no_stop:  BYTE 
                                    185 ;     0   set STOP bit at end 
                                    186 ;     1   don't set STOP bit 
                                    187 ;---------------------------
                                    188     ARGCOUNT=4 
                                    189 i2c_set_params: ; (stop_cond buf_addr count devid -- )
                                    190     clr i2c_status  
                                    191 1$: _get_arg 0 ; no_stop 
                                    192     jreq 2$
                                    193     bset i2c_status,#I2C_STATUS_NO_STOP
                                    194 2$: _get_arg 1 ; buf_addr 
                                    195     ldw i2c_buf,x 
                                    196     _get_arg 2 ; count 
                                    197     _strxz i2c_count 
                                    198     _get_arg 3 ; devid 
                                    199     ld a,xl 
                                    200     _straz i2c_devid 
                                    201     ret 
                                    202 .endif 
                                    203 
                                    204 ;--------------------------------
                                    205 ; write bytes to i2c device 
                                    206 ; devid:  device identifier 
                                    207 ; count: of bytes to write 
                                    208 ; buf_addr: address of bytes buffer 
                                    209 ; no_stop: dont't send a stop
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                    210 ;---------------------------------
      0081FB                        211 i2c_write:
      0081FB 72 0B 00 13 17   [ 2]  212     btjf i2c_status,#I2C_STATUS_ACTIV,9$
      008200 72 00 52 19 FB   [ 2]  213     btjt I2C_SR3,#I2C_SR3_MSL,.
      008205 5F               [ 1]  214     clrw x 
      000186                        215     _strxz i2c_idx 
      008206 BF 12                    1     .byte 0xbf,i2c_idx 
      008208 A6 07            [ 1]  216     ld a,#(1<<I2C_ITR_ITBUFEN)|(1<<I2C_ITR_ITERREN)|(1<<I2C_ITR_ITEVTEN) 
      00820A C7 52 1A         [ 1]  217     ld I2C_ITR,a 
      00820D A6 05            [ 1]  218     ld a,#(1<<I2C_CR2_START)|(1<<I2C_CR2_ACK)
      00820F C7 52 11         [ 1]  219     ld I2C_CR2,a      
      008212 72 0F 00 13 FB   [ 2]  220 1$: btjf i2c_status,#I2C_STATUS_DONE,1$ 
      008217                        221 9$:
      008217 81               [ 4]  222     ret 
                                    223 
                                    224 ;-------------------------------
                                    225 ; set I2C SCL frequency
                                    226 ; parameter:
                                    227 ;    A    {I2C_STD,I2C_FAST}
                                    228 ;-------------------------------
      008218                        229 i2c_scl_freq:
      008218 72 11 52 10      [ 1]  230 	bres I2C_CR1,#I2C_CR1_PE 
      00821C A1 00            [ 1]  231 	cp a,#I2C_STD 
      00821E 26 0E            [ 1]  232 	jrne fast
      008220                        233 std:
      008220 35 00 52 1C      [ 1]  234 	mov I2C_CCRH,#I2C_CCRH_16MHZ_STD_100 
      008224 35 50 52 1B      [ 1]  235 	mov I2C_CCRL,#I2C_CCRL_16MHZ_STD_100
      008228 35 11 52 1D      [ 1]  236 	mov I2C_TRISER,#I2C_TRISER_16MHZ_STD_100
      00822C 20 0C            [ 2]  237 	jra i2c_scl_freq_exit 
      00822E                        238 fast:
      00822E 35 80 52 1C      [ 1]  239 	mov I2C_CCRH,#I2C_CCRH_16MHZ_FAST_400 
      008232 35 0D 52 1B      [ 1]  240 	mov I2C_CCRL,#I2C_CCRL_16MHZ_FAST_400
      008236 35 05 52 1D      [ 1]  241 	mov I2C_TRISER,#I2C_TRISER_16MHZ_FAST_400
      00823A                        242 i2c_scl_freq_exit:
      00823A 72 10 52 10      [ 1]  243 	bset I2C_CR1,#I2C_CR1_PE 
      00823E 81               [ 4]  244 	ret 
                                    245 
                                    246 ;-------------------------------
                                    247 ; initialize I2C peripheral 
                                    248 ; parameter:
                                    249 ;    A    {I2C_STD,I2C_FAST}
                                    250 ;-------------------------------
      00823F                        251 i2c_init:
                                    252 ; set SDA and SCL pins as OD output 
      00823F 72 11 50 0D      [ 1]  253 	bres I2C_PORT+GPIO_CR1,#SDA_BIT 
      008243 72 13 50 0D      [ 1]  254 	bres I2C_PORT+GPIO_CR1,#SCL_BIT 
                                    255 ; set I2C peripheral 
      008247 72 16 50 C3      [ 1]  256 	bset CLK_PCKENR,#CLK_PCKENR_I2C 
      00824B 72 5F 52 10      [ 1]  257 	clr I2C_CR1 
      00824F 72 5F 52 11      [ 1]  258 	clr I2C_CR2 
      008253 35 10 52 12      [ 1]  259     mov I2C_FREQR,#FMSTR ; peripheral clock frequency 
      008257 AD BF            [ 4]  260 	callr i2c_scl_freq
      008259 72 10 52 10      [ 1]  261 	bset I2C_CR1,#I2C_CR1_PE ; enable peripheral 
      00825D 35 20 00 13      [ 1]  262 	mov i2c_status,#(1<<I2C_STATUS_ACTIV)
      008261 81               [ 4]  263     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



                                    264 
                                    265 
                                    266 ;-----------------------------
                                    267 ; send start bit and device id 
                                    268 ; paramenter:
                                    269 ;     A      device_id, 
                                    270 ; 			 b0=1 -> transmit
                                    271 ;			 b0=0 -> receive 
                                    272 ;----------------------------- 
      008262                        273 i2c_start:
      008262 72 02 52 19 FB   [ 2]  274     btjt I2C_SR3,#I2C_SR3_BUSY,.
      008267 72 10 52 11      [ 1]  275 	bset I2C_CR2,#I2C_CR2_START 
      00826B 72 01 52 17 FB   [ 2]  276 	btjf I2C_SR1,#I2C_SR1_SB,. 
      008270 C7 52 16         [ 1]  277 	ld I2C_DR,a 
      008273 72 03 52 17 FB   [ 2]  278 	btjf I2C_SR1,#I2C_SR1_ADDR,. 
      008278 81               [ 4]  279 	ret 
                                    280 
                                    281 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;------------------------------
                                     20 ; SSD1306 OLED display 128x64
                                     21 ;------------------------------
                                     22 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                     23     .include "inc/ssd1306.inc"
                                      1 ;-----------------------
                                      2 ;  SSD1306 commands set 
                                      3 ;-----------------------
                                      4 
                                      5 
                           000040     6 DISP_HEIGHT=64 ; pixels 
                           000080     7 DISP_WIDTH=128 ; pixels 
                                      8 
                                      9 ;-------------------------------
                                     10 ;  SSD1306 commands set 
                                     11 ;-------------------------------
                                     12 ; display on/off commands 
                           0000AE    13 DISP_OFF=0XAE      ; turn off display 
                           0000AF    14 DISP_ON=0XAF       ; turn on display 
                           000081    15 DISP_CONTRAST=0X81 ; adjust contrast 0..127
                           0000A4    16 DISP_RAM=0XA4     ; diplay RAM bits 
                           0000A5    17 DISP_ALL_ON=0XA5  ; all pixel on 
                           0000A6    18 DISP_NORMAL=0XA6  ; normal display, i.e. bit set oled light 
                           0000A7    19 DISP_INVERSE=0XA7 ; inverted display 
                           00008D    20 DISP_CHARGE_PUMP=0X8D ; enable charge pump 
                                     21 ; scrolling commands 
                           000026    22 SCROLL_RIGHT=0X26  ; scroll pages range right 
                           000027    23 SCROLL_LEFT=0X27   ; scroll pages range left 
                           000029    24 SCROLL_VRIGHT=0X29 ; scroll vertical and right  
                           00002A    25 SCROLL_VLEFT=0X2A ; scroll vertical and left 
                           00002E    26 SCROLL_STOP=0X2E   ; stop scrolling 
                           00002F    27 SCROLL_START=0X2F  ; start scrolling 
                           0000A3    28 VERT_SCROLL_AREA=0XA3  ; set vertical scrolling area 
                                     29 ; addressing setting commands 
                                     30 ; 0x00-0x0f set lower nibble for column start address, page mode  
                                     31 ; 0x10-0x1f set high nibble for column start address, page mode 
                           000020    32 ADR_MODE=0X20 ; 0-> horz mode, 1-> vert mode, 2->page mode 
                           000021    33 COL_WND=0X21 ; set column window for horz and vert mode 
                           000022    34 PAG_WND=0X22 ; set page window for horz and vert mode 
                                     35 ; 0xb0-0xb7 set start page for page mode 
                           000040    36 START_LINE=0X40 ; 0x40-0x7f set display start line 
                           0000A0    37 MAP_SEG0_COL0=0XA0 ; map segment 0 to column 0 
                           0000A1    38 MAP_SEG0_COL128=0XA1 ; inverse mapping segment 0 to col 127   
                           0000A8    39 MUX_RATIO=0XA8 ; reset to 64 
                           0000C0    40 SCAN_TOP_DOWN=0XC0 ; scan from COM0 to COM63 
                           0000C8    41 SCAN_REVERSE=0XC8 ; scan from COM63 to COM0 
                           0000D3    42 DISP_OFFSET=0XD3 ; display offset to COMx 
                           0000DA    43 COM_CFG=0XDA ; set COM pins hardware configuration 
                                     44 ;Timing & Driving Scheme Setting Command Table
                           0000D5    45 CLK_FREQ_DIV=0xD5 ; clock frequency and divisor 
                           0000D9    46 PRE_CHARGE=0xD9 ; set pre-charge period 
                           0000DB    47 VCOMH_DSEL=0XDB ; set Vcomh deselect level 
                           0000E3    48 OLED_NOP=0xE3 
                                     49 
                                     50 ; memory addressing mode 
                           000000    51 HORZ_MODE=0 ; At each byte write column address pointer increase by 1 
                                     52             ; when reach end rollback to 0 and page pointer is increased by 1.
                           000001    53 VERT_MODE=1 ; At each byte write page pointer is increased by 1 and 
                                     54             ; when last page is reached rollback to page 0 and column pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                     55             ; is increased by 1.
                           000002    56 PAGE_MODE=2 ; At each byte write column address pointer is increased by 1 
                                     57             ; when reach end rollback to 0 but page address pointer is not modified. 
                                     58 
                                     59 ; switch charge pump on/off 
                           000010    60 CP_OFF=0x10 
                           000014    61 CP_ON=0x14 
                                     62 
                                     63 ; co byte, first byte sent 
                                     64 ; after device address.
                           000080    65 OLED_CMD=0x80 
                           000040    66 OLED_DATA=0x40 
                                     67 
                                     68 
                                     69 ;--------------------------------
                                     70 ; command 0XDA parameter  
                                     71 ; COM pins hardware configuration
                                     72 ;--------------------------------
                           000000    73 COM_SEQUENTIAL=0 ; sequential pin scanning 0..63
                           000010    74 COM_ALTERNATE=0x10 ; alternate pin scanning 
                           000000    75 COM_DISABLE_REMAP=0  ; direct scanning 
                           000020    76 COM_ENABLE_REMAP=0x20 ; inverse scanning 
                                     77 
                                     78 ;------------------------
                                     79 ; command 0xD5 
                                     80 ; set display clock Divide
                                     81 ; and frequency 
                                     82 ;--------------------------
                           000004    83 CLK_FREQ=4; bit field 7:4 clok frequency (0..15)
                           000000    84 DISP_DIV=0 ; bit field 3:0 display clock divisor {0..15}
                                     85 
                                     86 ;--------------------------
                                     87 ; command 0xD9 
                                     88 ; set pre-charge period 
                                     89 ;-------------------------
                           000000    90 PHASE1_PERIOD=0 ; bit field 3:0 range {0..15}
                           000004    91 PHASE2_PERIOD=4 ; bit field 7:4 range {0..15}
                                     92 
                                     93 ;-------------------------
                                     94 ; command 0XDB 
                                     95 ; set Vcomh deslect level 
                                     96 ;------------------------
                           000000    97 VCOMH_DSEL_65=0
                           000020    98 VCOMH_DSEL_77=0X20 
                           000030    99 VCOMH_DSEL_83=0X30
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                     24 
                                     25 ;--------------------------------
                                     26 ; oled commands macros 
                                     27 ;----------------------------------
                                     28 
                                     29     ; initialize cmd_buffer 
                                     30     .macro _cmd_init 
                                     31         BUF_OFS=0
                                     32     .endm 
                                     33 
                                     34     ; set oled command buffer values 
                                     35     ; initialize BUF_OFS=0 
                                     36     ; before using it 
                                     37     .macro _set_cmd n
                                     38     BUF_OFS=BUF_OFS+1 
                                     39     mov cmd_buffer_BUF_OFS,#0x80
                                     40     BUF_OFS=BUF_OFS+1 
                                     41     mov cmd_buffer+BUF_OFS,#n 
                                     42     .endm 
                                     43 
                                     44     
                                     45     ; send command 
                                     46     .macro _send_cmd code 
                                     47     ld a,#code 
                                     48     call oled_cmd 
                                     49     .endm 
                                     50 
                                     51 ;----------------------------
                                     52 ; initialize OLED display
                                     53 ;----------------------------
      008279                         54 oled_init:: 
                                     55 ; multiplex ratio to default 64 
      0001F9                         56     _send_cmd MUX_RATIO 
      008279 A6 A8            [ 1]    1     ld a,#MUX_RATIO 
      00827B CD 83 33         [ 4]    2     call oled_cmd 
      0001FE                         57     _send_cmd 63
      00827E A6 3F            [ 1]    1     ld a,#63 
      008280 CD 83 33         [ 4]    2     call oled_cmd 
                                     58 ; no display offset 
      000203                         59     _send_cmd DISP_OFFSET 
      008283 A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      008285 CD 83 33         [ 4]    2     call oled_cmd 
      000208                         60     _send_cmd 0 
      008288 A6 00            [ 1]    1     ld a,#0 
      00828A CD 83 33         [ 4]    2     call oled_cmd 
                                     61 ; no segment remap SEG0 -> COM0 
      00020D                         62     _send_cmd MAP_SEG0_COL0   
      00828D A6 A0            [ 1]    1     ld a,#MAP_SEG0_COL0 
      00828F CD 83 33         [ 4]    2     call oled_cmd 
                                     63 ; COMMON scan direction top to bottom 
      000212                         64     _send_cmd SCAN_TOP_DOWN
      008292 A6 C0            [ 1]    1     ld a,#SCAN_TOP_DOWN 
      008294 CD 83 33         [ 4]    2     call oled_cmd 
                                     65 ; common pins config, bit 5=0, 4=1 
      000217                         66     _send_cmd COM_CFG 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



      008297 A6 DA            [ 1]    1     ld a,#COM_CFG 
      008299 CD 83 33         [ 4]    2     call oled_cmd 
      00021C                         67     _send_cmd COM_DISABLE_REMAP+COM_ALTERNATE
      00829C A6 10            [ 1]    1     ld a,#COM_DISABLE_REMAP+COM_ALTERNATE 
      00829E CD 83 33         [ 4]    2     call oled_cmd 
                                     68 ; constrast level 1, lowest 
      000221                         69     _send_cmd DISP_CONTRAST
      0082A1 A6 81            [ 1]    1     ld a,#DISP_CONTRAST 
      0082A3 CD 83 33         [ 4]    2     call oled_cmd 
      000226                         70     _send_cmd 1
      0082A6 A6 01            [ 1]    1     ld a,#1 
      0082A8 CD 83 33         [ 4]    2     call oled_cmd 
                                     71 ; display RAM 
      00022B                         72     _send_cmd DISP_RAM
      0082AB A6 A4            [ 1]    1     ld a,#DISP_RAM 
      0082AD CD 83 33         [ 4]    2     call oled_cmd 
                                     73 ; display normal 
      000230                         74     _send_cmd DISP_NORMAL
      0082B0 A6 A6            [ 1]    1     ld a,#DISP_NORMAL 
      0082B2 CD 83 33         [ 4]    2     call oled_cmd 
                                     75 ; clock frequency=maximum and display divisor=1 
      000235                         76     _send_cmd CLK_FREQ_DIV
      0082B5 A6 D5            [ 1]    1     ld a,#CLK_FREQ_DIV 
      0082B7 CD 83 33         [ 4]    2     call oled_cmd 
      00023A                         77     _send_cmd ((15<<CLK_FREQ)+(0<<DISP_DIV)) 
      0082BA A6 F0            [ 1]    1     ld a,#((15<<CLK_FREQ)+(0<<DISP_DIV)) 
      0082BC CD 83 33         [ 4]    2     call oled_cmd 
                                     78 ; pre-charge phase1=1 and phase2=15
                                     79 ; reducing phase2 value dim display  
      00023F                         80     _send_cmd PRE_CHARGE
      0082BF A6 D9            [ 1]    1     ld a,#PRE_CHARGE 
      0082C1 CD 83 33         [ 4]    2     call oled_cmd 
      000244                         81     _send_cmd ((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD))
      0082C4 A6 F1            [ 1]    1     ld a,#((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD)) 
      0082C6 CD 83 33         [ 4]    2     call oled_cmd 
                                     82 ; RAM addressing mode       
      000249                         83     _send_cmd ADR_MODE 
      0082C9 A6 20            [ 1]    1     ld a,#ADR_MODE 
      0082CB CD 83 33         [ 4]    2     call oled_cmd 
      00024E                         84     _send_cmd HORZ_MODE
      0082CE A6 00            [ 1]    1     ld a,#HORZ_MODE 
      0082D0 CD 83 33         [ 4]    2     call oled_cmd 
                                     85 ; Vcomh deselect level 0.83volt 
      000253                         86     _send_cmd VCOMH_DSEL 
      0082D3 A6 DB            [ 1]    1     ld a,#VCOMH_DSEL 
      0082D5 CD 83 33         [ 4]    2     call oled_cmd 
      000258                         87     _send_cmd VCOMH_DSEL_83
      0082D8 A6 30            [ 1]    1     ld a,#VCOMH_DSEL_83 
      0082DA CD 83 33         [ 4]    2     call oled_cmd 
                                     88 ; enable charge pump 
      00025D                         89     _send_cmd DISP_CHARGE_PUMP
      0082DD A6 8D            [ 1]    1     ld a,#DISP_CHARGE_PUMP 
      0082DF CD 83 33         [ 4]    2     call oled_cmd 
      000262                         90     _send_cmd CP_ON 
      0082E2 A6 14            [ 1]    1     ld a,#CP_ON 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



      0082E4 CD 83 33         [ 4]    2     call oled_cmd 
                                     91 ; disable scrolling 
      000267                         92     _send_cmd SCROLL_STOP
      0082E7 A6 2E            [ 1]    1     ld a,#SCROLL_STOP 
      0082E9 CD 83 33         [ 4]    2     call oled_cmd 
                                     93 ; diplay row from 0 
      00026C                         94     _send_cmd START_LINE 
      0082EC A6 40            [ 1]    1     ld a,#START_LINE 
      0082EE CD 83 33         [ 4]    2     call oled_cmd 
                                     95 ; activate display 
      000271                         96     _send_cmd DISP_ON 
      0082F1 A6 AF            [ 1]    1     ld a,#DISP_ON 
      0082F3 CD 83 33         [ 4]    2     call oled_cmd 
      0082F6 81               [ 4]   97     ret 
                                     98 
                                     99 ;--------------------------------
                                    100 ; set column address to 0:127 
                                    101 ; set page address to 0:7 
                                    102 ;--------------------------------
      0082F7                        103 all_display:
                                    104 ; page window 0..7
      000277                        105     _send_cmd PAG_WND 
      0082F7 A6 22            [ 1]    1     ld a,#PAG_WND 
      0082F9 CD 83 33         [ 4]    2     call oled_cmd 
      00027C                        106     _send_cmd 0  
      0082FC A6 00            [ 1]    1     ld a,#0 
      0082FE CD 83 33         [ 4]    2     call oled_cmd 
      000281                        107     _send_cmd 7 
      008301 A6 07            [ 1]    1     ld a,#7 
      008303 CD 83 33         [ 4]    2     call oled_cmd 
                                    108 ; columns windows 0..127
      000286                        109     _send_cmd COL_WND 
      008306 A6 21            [ 1]    1     ld a,#COL_WND 
      008308 CD 83 33         [ 4]    2     call oled_cmd 
      00028B                        110     _send_cmd 0 
      00830B A6 00            [ 1]    1     ld a,#0 
      00830D CD 83 33         [ 4]    2     call oled_cmd 
      000290                        111     _send_cmd 127
      008310 A6 7F            [ 1]    1     ld a,#127 
      008312 CD 83 33         [ 4]    2     call oled_cmd 
      008315 81               [ 4]  112     ret 
                                    113 
                                    114 ;-----------------------
                                    115 ; set ram write window 
                                    116 ; input:
                                    117 ;     XH  col low  
                                    118 ;     XL  col high
                                    119 ;     YH  page low 
                                    120 ;     YL  page high 
                                    121 ;-----------------------
      008316                        122 set_window:
      008316 89               [ 2]  123     pushw x 
      008317 90 89            [ 2]  124     pushw y 
      000299                        125     _send_cmd PAG_WND 
      008319 A6 22            [ 1]    1     ld a,#PAG_WND 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



      00831B CD 83 33         [ 4]    2     call oled_cmd 
      00831E 84               [ 1]  126     pop a 
      00831F CD 83 33         [ 4]  127     call oled_cmd 
      008322 84               [ 1]  128     pop a 
      008323 CD 83 33         [ 4]  129     call oled_cmd 
      0002A6                        130     _send_cmd COL_WND 
      008326 A6 21            [ 1]    1     ld a,#COL_WND 
      008328 CD 83 33         [ 4]    2     call oled_cmd 
      00832B 84               [ 1]  131     pop a 
      00832C CD 83 33         [ 4]  132     call oled_cmd 
      00832F 84               [ 1]  133     pop a 
      008330 CC 83 33         [ 2]  134     jp oled_cmd 
                                    135 
                           000000   136 .if 0
                                    137 ;------------------------
                                    138 ; scroll display left|right  
                                    139 ; input:
                                    140 ;     A   SCROLL_LEFT|SCROLL_RIGHT 
                                    141 ;     XL  speed 
                                    142 ;------------------------
                                    143 scroll:
                                    144     pushw x 
                                    145     call oled_cmd 
                                    146     _send_cmd 0 ; dummy byte  
                                    147     _send_cmd 0 ; start page 0 
                                    148     pop a ; 
                                    149     pop a ; 
                                    150     call oled_cmd ;speed  
                                    151     _send_cmd 7 ; end page 
                                    152     _send_cmd 0 ; dummy 
                                    153     _send_cmd 255 ; dummy
                                    154     _send_cmd SCROLL_START 
                                    155     ret 
                                    156 
                                    157 ;---------------------------------
                                    158 ; enable/disable charge pump 
                                    159 ; parameters:
                                    160 ;    A    CP_OFF|CP_ON 
                                    161 ;---------------------------------
                                    162 charge_pump_switch:
                                    163     push a 
                                    164     _send_cmd DISP_CHARGE_PUMP
                                    165     pop a 
                                    166     jra oled_cmd 
                                    167 
                                    168 .endif 
                                    169 
                                    170 ;---------------------------------
                                    171 ; send command to OLED 
                                    172 ; parameters:
                                    173 ;     A     command code  
                                    174 ;---------------------------------
      008333                        175 oled_cmd:
      008333 89               [ 2]  176     pushw x 
      0002B4                        177     _clrz i2c_count 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      008334 3F 11                    1     .byte 0x3f, i2c_count 
      008336 35 02 00 12      [ 1]  178     mov i2c_count+1,#2
      00833A AE 01 00         [ 2]  179     ldw x,#co_code 
      00833D E7 01            [ 1]  180     ld (1,x),a 
      00833F A6 80            [ 1]  181     ld a,#OLED_CMD 
      008341 F7               [ 1]  182     ld (x),a   
      0002C2                        183     _strxz i2c_buf 
      008342 BF 0F                    1     .byte 0xbf,i2c_buf 
      008344 35 78 00 14      [ 1]  184     mov i2c_devid,#OLED_DEVID 
      0002C8                        185     _clrz i2c_status
      008348 3F 13                    1     .byte 0x3f, i2c_status 
      00834A CD 81 FB         [ 4]  186     call i2c_write
      00834D 85               [ 2]  187     popw x 
      00834E 81               [ 4]  188     ret 
                                    189 
                                    190 ;---------------------------------
                                    191 ; send data to OLED GDDRAM
                                    192 ; parameters:
                                    193 ;     X     byte count  
                                    194 ;---------------------------------
      00834F                        195 oled_data:
      00834F 5C               [ 1]  196     incw x   
      0002D0                        197     _strxz i2c_count     
      008350 BF 11                    1     .byte 0xbf,i2c_count 
      008352 AE 01 00         [ 2]  198     ldw x,#co_code 
      008355 A6 40            [ 1]  199     ld a,#OLED_DATA 
      008357 F7               [ 1]  200     ld (x),a 
      0002D8                        201     _strxz i2c_buf
      008358 BF 0F                    1     .byte 0xbf,i2c_buf 
      00835A 35 78 00 14      [ 1]  202     mov i2c_devid,#OLED_DEVID 
      0002DE                        203     _clrz i2c_status
      00835E 3F 13                    1     .byte 0x3f, i2c_status 
      008360 CD 81 FB         [ 4]  204     call i2c_write
      008363 81               [ 4]  205     ret 
                                    206 
                                    207 
                                    208 
                                    209 
                                    210 
                                    211 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



                                      1 ; rotated 6x8 pixels font to use with ssd1306 oled display
                                      2  
                                      3 ;
                                      4 ; Copyright Jacques Deschênes 2023 
                                      5 ; This file is part of stm8_ssd1306
                                      6 ;
                                      7 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      8 ;     it under the terms of the GNU General Public License as published by
                                      9 ;     the Free Software Foundation, either version 3 of the License, or
                                     10 ;     (at your option) any later version.
                                     11 ;
                                     12 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     13 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     14 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     15 ;     GNU General Public License for more details.
                                     16 ;
                                     17 ;     You should have received a copy of the GNU General Public License
                                     18 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     19 ;;
                                     20 
                                     21 ; ASCII font 6x8 
                           000008    22 OLED_FONT_HEIGHT=8 
                           000006    23 OLED_FONT_WIDTH=6 
      008364                         24 oled_font_6x8: 
      008364 00 00 00 00 00 00       25 .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; space ASCII 32
      00836A 00 00 5F 00 00 00       26 .byte 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 ; !
      008370 00 07 00 07 00 00       27 .byte 0x00, 0x07, 0x00, 0x07, 0x00, 0x00 ; "
      008376 14 7F 14 7F 14 00       28 .byte 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 ; #
      00837C 24 2A 7F 2A 12 00       29 .byte 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 ; $
      008382 23 13 08 64 62 00       30 .byte 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 ; %
      008388 36 49 55 22 50 00       31 .byte 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 ; &
      00838E 00 05 03 00 00 00       32 .byte 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 ; '
      008394 00 1C 22 41 00 00       33 .byte 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 ; (
      00839A 00 41 22 1C 00 00       34 .byte 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 ; )
      0083A0 14 08 3E 08 14 00       35 .byte 0x14, 0x08, 0x3E, 0x08, 0x14, 0x00 ; *
      0083A6 08 08 3E 08 08 00       36 .byte 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 ; +
      0083AC 00 D8 78 38 00 00       37 .byte 0x00, 0xD8, 0x78, 0x38, 0x00, 0x00 ; ,
      0083B2 08 08 08 08 00 00       38 .byte 0x08, 0x08, 0x08, 0x08, 0x00, 0x00 ; -
      0083B8 00 60 60 60 00 00       39 .byte 0x00, 0x60, 0x60, 0x60, 0x00, 0x00 ; .
      0083BE 00 20 34 18 0C 06       40 .byte 0x00, 0x20, 0x34, 0x18, 0x0C, 0x06 ; /
      0083C4 3E 51 49 45 3E 00       41 .byte 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 ; 0
      0083CA 40 42 7F 40 40 00       42 .byte 0x40, 0x42, 0x7F, 0x40, 0x40, 0x00 ; 1
      0083D0 62 51 49 45 42 00       43 .byte 0x62, 0x51, 0x49, 0x45, 0x42, 0x00 ; 2
      0083D6 49 49 49 49 36 00       44 .byte 0x49, 0x49, 0x49, 0x49, 0x36, 0x00 ; 3
      0083DC 18 14 12 7F 10 00       45 .byte 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 ; 4
      0083E2 4F 49 49 49 31 00       46 .byte 0x4F, 0x49, 0x49, 0x49, 0x31, 0x00 ; 5
      0083E8 3C 4A 49 49 30 00       47 .byte 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 ; 6
      0083EE 01 71 09 05 03 00       48 .byte 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 ; 7
      0083F4 36 49 49 49 36 00       49 .byte 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 ; 8
      0083FA 06 49 49 49 36 00       50 .byte 0x06, 0x49, 0x49, 0x49, 0x36, 0x00 ; 9
      008400 00 36 36 36 00 00       51 .byte 0x00, 0x36, 0x36, 0x36, 0x00, 0x00 ; :
      008406 00 F6 76 36 00 00       52 .byte 0x00, 0xF6, 0x76, 0x36, 0x00, 0x00 ; ;
      00840C 08 14 22 41 00 00       53 .byte 0x08, 0x14, 0x22, 0x41, 0x00, 0x00 ; <
      008412 14 14 14 14 14 00       54 .byte 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 ; =
      008418 00 41 22 14 08 00       55 .byte 0x00, 0x41, 0x22, 0x14, 0x08, 0x00 ; >
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



      00841E 02 01 51 09 06 00       56 .byte 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 ; ?
      008424 32 49 79 41 3E 00       57 .byte 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 ; @
      00842A 7E 09 09 09 7E 00       58 .byte 0x7E, 0x09, 0x09, 0x09, 0x7E, 0x00 ; A
      008430 7F 49 49 49 36 00       59 .byte 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 ; B
      008436 3E 41 41 41 41 00       60 .byte 0x3E, 0x41, 0x41, 0x41, 0x41, 0x00 ; C
      00843C 7F 41 41 41 3E 00       61 .byte 0x7F, 0x41, 0x41, 0x41, 0x3E, 0x00 ; D
      008442 7F 49 49 49 49 00       62 .byte 0x7F, 0x49, 0x49, 0x49, 0x49, 0x00 ; E
      008448 7F 09 09 09 09 00       63 .byte 0x7F, 0x09, 0x09, 0x09, 0x09, 0x00 ; F
      00844E 3E 41 49 49 31 00       64 .byte 0x3E, 0x41, 0x49, 0x49, 0x31, 0x00 ; G
      008454 7F 08 08 08 7F 00       65 .byte 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 ; H
      00845A 00 41 7F 41 00 00       66 .byte 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 ; I
      008460 20 41 41 21 1F 00       67 .byte 0x20, 0x41, 0x41, 0x21, 0x1F, 0x00 ; J
      008466 7F 08 14 22 41 00       68 .byte 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 ; K
      00846C 7F 40 40 40 40 00       69 .byte 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 ; L
      008472 7F 02 04 02 7F 00       70 .byte 0x7F, 0x02, 0x04, 0x02, 0x7F, 0x00 ; M
      008478 7F 04 08 10 7F 00       71 .byte 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 ; N
      00847E 3E 41 41 41 3E 00       72 .byte 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 ; O
      008484 7F 09 09 09 06 00       73 .byte 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 ; P
      00848A 3E 41 51 61 7E 00       74 .byte 0x3E, 0x41, 0x51, 0x61, 0x7E, 0x00 ; Q
      008490 7F 09 19 29 46 00       75 .byte 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 ; R
      008496 46 49 49 49 31 00       76 .byte 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 ; S
      00849C 01 01 01 7F 01 01       77 .byte 0x01, 0x01, 0x01, 0x7F, 0x01, 0x01 ; T
      0084A2 3F 40 40 40 3F 00       78 .byte 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 ; U
      0084A8 1F 20 40 20 1F 00       79 .byte 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 ; V
      0084AE 7F 20 18 20 7F 00       80 .byte 0x7F, 0x20, 0x18, 0x20, 0x7F, 0x00 ; W
      0084B4 63 14 08 14 63 00       81 .byte 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 ; X
      0084BA 07 08 70 08 07 00       82 .byte 0x07, 0x08, 0x70, 0x08, 0x07, 0x00 ; Y
      0084C0 71 49 45 43 41 00       83 .byte 0x71, 0x49, 0x45, 0x43, 0x41, 0x00 ; Z
      0084C6 00 7F 41 00 00 00       84 .byte 0x00, 0x7F, 0x41, 0x00, 0x00, 0x00 ; [
      0084CC 02 04 08 10 20 00       85 .byte 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 ; '\'
      0084D2 00 00 00 41 7F 00       86 .byte 0x00, 0x00, 0x00, 0x41, 0x7F, 0x00 ; ]
      0084D8 04 02 01 02 04 00       87 .byte 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 ; ^
      0084DE 80 80 80 80 80 80       88 .byte 0x80, 0x80, 0x80, 0x80, 0x80, 0x80 ; _
      0084E4 00 01 02 04 00 00       89 .byte 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 ; `
      0084EA 20 54 54 54 78 00       90 .byte 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 ; a
      0084F0 7F 50 48 48 30 00       91 .byte 0x7F, 0x50, 0x48, 0x48, 0x30, 0x00 ; b
      0084F6 38 44 44 44 20 00       92 .byte 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 ; c
      0084FC 30 48 48 50 7F 00       93 .byte 0x30, 0x48, 0x48, 0x50, 0x7F, 0x00 ; d
      008502 38 54 54 54 18 00       94 .byte 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 ; e
      008508 08 7E 09 01 02 00       95 .byte 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 ; f
      00850E 18 A4 A4 A4 7C 00       96 .byte 0x18, 0xA4, 0xA4, 0xA4, 0x7C, 0x00 ; g
      008514 7F 08 04 04 78 00       97 .byte 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 ; h
      00851A 00 00 7A 00 00 00       98 .byte 0x00, 0x00, 0x7A, 0x00, 0x00, 0x00 ; i
      008520 20 40 44 3D 00 00       99 .byte 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 ; j
      008526 7F 10 28 44 00 00      100 .byte 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00 ; k
      00852C 00 41 7F 40 00 00      101 .byte 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 ; l
      008532 7C 04 18 04 78 00      102 .byte 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 ; m
      008538 7C 08 04 04 78 00      103 .byte 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 ; n
      00853E 38 44 44 44 38 00      104 .byte 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 ; o
      008544 FC 24 24 24 18 00      105 .byte 0xFC, 0x24, 0x24, 0x24, 0x18, 0x00 ; p
      00854A 38 44 24 F8 84 00      106 .byte 0x38, 0x44, 0x24, 0xF8, 0x84, 0x00 ; q
      008550 7C 08 04 04 08 00      107 .byte 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 ; r
      008556 48 54 54 54 20 00      108 .byte 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 ; s
      00855C 04 3F 44 40 20 00      109 .byte 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 ; t
      008562 3C 40 40 20 7C 00      110 .byte 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 ; u
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



      008568 1C 20 40 20 1C 00      111 .byte 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 ; v
      00856E 3C 40 30 40 3C 00      112 .byte 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 ; w
      008574 44 28 10 28 44 00      113 .byte 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 ; x
      00857A 1C A0 A0 A0 7C 00      114 .byte 0x1C, 0xA0, 0xA0, 0xA0, 0x7C, 0x00 ; y
      008580 44 64 54 4C 44 00      115 .byte 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 ; z
      008586 08 36 41 00 00 00      116 .byte 0x08, 0x36, 0x41, 0x00, 0x00, 0x00 ; {
      00858C 00 00 7F 00 00 00      117 .byte 0x00, 0x00, 0x7F, 0x00, 0x00, 0x00 ; |
      008592 00 41 36 08 00 00      118 .byte 0x00, 0x41, 0x36, 0x08, 0x00, 0x00 ; }
      008598 08 04 08 10 08 00      119 .byte 0x08, 0x04, 0x08, 0x10, 0x08, 0x00 ; ~  ASCII 127 
      00859E FF FF FF FF FF FF      120 .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF ; 95 block cursor  127 
      0085A4 08 49 2A 1C 08 00      121 .byte 0x08, 0x49, 0x2A, 0x1C, 0x08, 0x00 ; 96 flèche droite 128 
      0085AA 08 1C 2A 49 08 00      122 .byte 0x08, 0x1C, 0x2A, 0x49, 0x08, 0x00 ; 97 flèche gauche 129
      0085B0 04 02 3F 02 04 00      123 .byte 0x04, 0x02, 0x3F, 0x02, 0x04, 0x00 ; 98 flèche haut   130
      0085B6 10 20 7E 20 10 00      124 .byte 0x10, 0x20, 0x7E, 0x20, 0x10, 0x00 ; 99 flèche bas    131
      0085BC 1C 3E 3E 3E 1C 00      125 .byte 0x1C, 0x3E, 0x3E, 0x3E, 0x1C, 0x00 ; 100 rond         132
      0085C2 00 00 00 80 80 80      126 .byte 0x00, 0x00, 0x00, 0x80, 0x80, 0x80 ; 101 underline cursor 133
      0085C8 FF 00 00 00 00 00      127 .byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00 ; 102 insert cursor 134 
      0085CE 00 06 09 09 06 00      128 .byte 0x00, 0x06, 0x09, 0x09, 0x06, 0x00 ; 103 degree symbol 135 
      0085D4                        129 oled_font_end:
                           000087   130 DEGREE=135
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19     .area CODE 
                                     20 
                                     21 ;-------------------------------
                                     22 ;  OLED diplay functions 
                                     23 ;
                                     24 ;  display buffer is 1024 bytes 
                                     25 ;  below stack 
                                     26 ;-------------------------------
                                     27 
                                     28 ; boolean flags  in 'disp_flags' 
                           000000    29 F_SCROLL=0 ; display scroll active 
                           000001    30 F_BIG=1 ; big font selected 
                                     31 
                                     32 ; small font display specifications
                           000015    33 SMALL_CPL=21  ; character per line
                           000008    34 SMALL_LINES=8 ; display lines 
                           000008    35 SMALL_FONT_HEIGHT=OLED_FONT_HEIGHT  
                           000006    36 SMALL_FONT_WIDTH=OLED_FONT_WIDTH 
                           000006    37 SMALL_FONT_SIZE=6 ; character font bytes  
                                     38 
                                     39 ; big font display specifications 
                           00000A    40 BIG_CPL=10   ; character per line 
                           000004    41 BIG_LINES=4  ; display lines 
                           000010    42 BIG_FONT_HEIGHT=2*OLED_FONT_HEIGHT 
                           00000C    43 BIG_FONT_WIDTH=2*OLED_FONT_WIDTH 
                           000018    44 BIG_FONT_SIZE=4*SMALL_FONT_SIZE ; character font bytes
                                     45 
                                     46 ; mega font specifications 
                           000005    47 MEGA_CPL=5 
                           000002    48 MEGA_LINES=2 
                           000020    49 MEGA_FONT_HEIGHT=4*OLED_FONT_HEIGHT 
                           000018    50 MEGA_FONT_WIDTH=4*OLED_FONT_WIDTH 
                           000060    51 MEGA_FONT_SIZE=16*SMALL_FONT_SIZE 
                                     52 
                                     53 ; zoom modes 
                           000000    54 SMALL=0 ; select small font 
                           000001    55 BIG=1 ; select big font  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



                                     56 
                                     57 
                                     58 ;--------------------------
                                     59 ; select font 
                                     60 ; input:
                                     61 ;    A   {SMALL,BIG}
                                     62 ;--------------------------
      0085D4                         63 select_font:
      0085D4 4D               [ 1]   64     tnz a 
      0085D5 26 21            [ 1]   65     jrne 2$ 
                                     66 ; small font 
      0085D7 A6 15            [ 1]   67     ld a,#SMALL_CPL 
      000559                         68     _straz cpl 
      0085D9 B7 17                    1     .byte 0xb7,cpl 
      0085DB A6 08            [ 1]   69     ld a,#SMALL_LINES 
      00055D                         70     _straz disp_lines 
      0085DD B7 18                    1     .byte 0xb7,disp_lines 
      0085DF A6 08            [ 1]   71     ld a,#SMALL_FONT_HEIGHT
      000561                         72     _straz font_height
      0085E1 B7 1A                    1     .byte 0xb7,font_height 
      0085E3 A6 06            [ 1]   73     ld a,#SMALL_FONT_WIDTH
      000565                         74     _straz font_width
      0085E5 B7 19                    1     .byte 0xb7,font_width 
      0085E7 A6 06            [ 1]   75     ld a,#SMALL_FONT_SIZE
      000569                         76     _straz to_send
      0085E9 B7 1B                    1     .byte 0xb7,to_send 
      0085EB 72 58 00 15      [ 1]   77     sll line 
      0085EF 72 58 00 16      [ 1]   78     sll col
      0085F3 72 13 00 1C      [ 1]   79     bres disp_flags,#F_BIG    
      0085F7 81               [ 4]   80     ret 
      0085F8                         81 2$: ; big font
      000578                         82     _ldaz col 
      0085F8 B6 16                    1     .byte 0xb6,col 
      0085FA A1 13            [ 1]   83     cp a,#19
      0085FC 2A 30            [ 1]   84     jrpl 9$  ; request rejected 
      00057E                         85     _ldaz line 
      0085FE B6 15                    1     .byte 0xb6,line 
      008600 A1 07            [ 1]   86     cp a,#7
      008602 27 2A            [ 1]   87     jreq 9$  ; request rejected
      008604 A6 0A            [ 1]   88     ld a,#BIG_CPL 
      000586                         89     _straz cpl 
      008606 B7 17                    1     .byte 0xb7,cpl 
      008608 A6 04            [ 1]   90     ld a,#BIG_LINES 
      00058A                         91     _straz disp_lines 
      00860A B7 18                    1     .byte 0xb7,disp_lines 
      00860C A6 10            [ 1]   92     ld a,#BIG_FONT_HEIGHT
      00058E                         93     _straz font_height
      00860E B7 1A                    1     .byte 0xb7,font_height 
      008610 A6 0C            [ 1]   94     ld a,#BIG_FONT_WIDTH
      000592                         95     _straz font_width
      008612 B7 19                    1     .byte 0xb7,font_width 
      008614 A6 18            [ 1]   96     ld a,#BIG_FONT_SIZE
      000596                         97     _straz to_send
      008616 B7 1B                    1     .byte 0xb7,to_send 
      008618 72 01 00 15 02   [ 2]   98     btjf line,#0,4$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



      00059D                         99     _incz line ; big font is lock step to even line  
      00861D 3C 15                    1     .byte 0x3c, line 
      00861F                        100 4$:
      00861F 72 54 00 15      [ 1]  101     srl line 
      008623 72 01 00 16 02   [ 2]  102     btjf col,#0,6$ 
      0005A8                        103     _incz col  ; big font is lock step to even column
      008628 3C 16                    1     .byte 0x3c, col 
      00862A                        104 6$:
      00862A 72 54 00 16      [ 1]  105     srl col
      00862E                        106 9$:
      00862E 72 12 00 1C      [ 1]  107     bset disp_flags,#F_BIG    
      008632 81               [ 4]  108     ret 
                                    109 
                                    110 
                                    111 ;------------------------
                                    112 ; set RAM window for 
                                    113 ; current line 
                                    114 ;-----------------------
      008633                        115 line_window:
      008633 89               [ 2]  116     pushw x 
      008634 90 89            [ 2]  117     pushw y 
      008636 AE 00 7F         [ 2]  118     ldw x,#0x7f ; columms: 0..127
      0005B9                        119     _ldaz line 
      008639 B6 15                    1     .byte 0xb6,line 
      00863B 72 03 00 1C 06   [ 2]  120     btjf disp_flags,#F_BIG,1$ 
      008640 48               [ 1]  121     sll a 
      008641 90 95            [ 1]  122     ld yh,a 
      008643 4C               [ 1]  123     inc a 
      008644 90 97            [ 1]  124     ld yl,a 
      008646 CD 83 16         [ 4]  125 1$: call set_window 
      008649 90 85            [ 2]  126     popw y 
      00864B 85               [ 2]  127     popw x
      00864C 81               [ 4]  128     ret 
                                    129 
                                    130 
                                    131 ;---------------------------
                                    132 ;  clear current line 
                                    133 ;---------------------------
      00864D                        134 line_clear:
      00864D CD 86 33         [ 4]  135     call line_window 
      008650 CD 86 65         [ 4]  136     call clear_disp_buffer
      008653 AE 00 80         [ 2]  137     ldw x,#DISPLAY_BUFFER_SIZE 
      008656 CD 83 4F         [ 4]  138     call oled_data
      008659 72 03 00 1C 06   [ 2]  139     btjf disp_flags,#F_BIG,9$
      00865E AE 00 80         [ 2]  140     ldw x,#DISPLAY_BUFFER_SIZE
      008661 CD 83 4F         [ 4]  141     call oled_data 
      008664 81               [ 4]  142 9$: ret 
                                    143 
                                    144 ;----------------------
                                    145 ; zero's display buffer 
                                    146 ; input: 
                                    147 ;   none 
                                    148 ;----------------------
      008665                        149 clear_disp_buffer:
      008665 89               [ 2]  150     pushw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



      008666 88               [ 1]  151     push a 
      008667 AE 01 01         [ 2]  152     ldw x,#disp_buffer 
      00866A A6 80            [ 1]  153     ld a,#DISPLAY_BUFFER_SIZE
      00866C 7F               [ 1]  154 1$: clr(x)
      00866D 5C               [ 1]  155     incw x 
      00866E 4A               [ 1]  156     dec a 
      00866F 26 FB            [ 1]  157     jrne 1$
      008671 84               [ 1]  158     pop a 
      008672 85               [ 2]  159     popw x 
      008673 81               [ 4]  160     ret 
                                    161 
                                    162 ;--------------------------
                                    163 ;  zero's SSD1306 RAM 
                                    164 ;--------------------------
      008674                        165 display_clear:
      008674 88               [ 1]  166     push a 
      008675 89               [ 2]  167     pushw x 
      008676 CD 82 F7         [ 4]  168     call all_display 
      008679 CD 86 65         [ 4]  169     call clear_disp_buffer
      00867C 4B 08            [ 1]  170     push #8
      00867E AE 00 80         [ 2]  171 1$: ldw x,#DISPLAY_BUFFER_SIZE
      008681 CD 83 4F         [ 4]  172     call oled_data
      008684 0A 01            [ 1]  173     dec (1,sp)
      008686 26 F6            [ 1]  174     jrne 1$ 
      000608                        175     _drop 1 
      008688 5B 01            [ 2]    1     addw sp,#1 
      00060A                        176     _clrz line 
      00868A 3F 15                    1     .byte 0x3f, line 
      00060C                        177     _clrz col
      00868C 3F 16                    1     .byte 0x3f, col 
      00868E 72 11 00 1C      [ 1]  178     bres disp_flags,#F_SCROLL  
      008692 85               [ 2]  179     popw x
      008693 84               [ 1]  180     pop a 
      008694 81               [ 4]  181     ret 
                                    182 
                                    183 ;---------------------------
                                    184 ; set display start line 
                                    185 ;----------------------------
      008695                        186 scroll_up:
      008695 CD 86 4D         [ 4]  187     call line_clear 
      000618                        188     _ldaz line 
      008698 B6 15                    1     .byte 0xb6,line 
      00869A 97               [ 1]  189     ld xl,a 
      00869B C6 00 1A         [ 1]  190     ld a,font_height 
      00869E 42               [ 4]  191     mul x,a 
      00869F 9F               [ 1]  192     ld a,xl 
      0086A0 88               [ 1]  193     push a 
      000621                        194     _send_cmd DISP_OFFSET
      0086A1 A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      0086A3 CD 83 33         [ 4]    2     call oled_cmd 
      0086A6 84               [ 1]  195     pop a  
      0086A7 CD 83 33         [ 4]  196     call oled_cmd
      0086AA 81               [ 4]  197     ret 
                                    198 
                                    199 ;-----------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



                                    200 ; send text cursor 
                                    201 ; at next line 
                                    202 ;------------------------
      0086AB                        203 crlf:
      00062B                        204     _clrz col 
      0086AB 3F 16                    1     .byte 0x3f, col 
      0086AD 72 00 00 1C 11   [ 2]  205     btjt disp_flags,#F_SCROLL,2$
      000632                        206     _ldaz line
      0086B2 B6 15                    1     .byte 0xb6,line 
      0086B4 4C               [ 1]  207     inc a
      0086B5 C1 00 18         [ 1]  208     cp a,disp_lines 
      0086B8 2A 03            [ 1]  209     jrpl 1$
      00063A                        210     _straz line
      0086BA B7 15                    1     .byte 0xb7,line 
      0086BC 81               [ 4]  211     ret
      0086BD 72 10 00 1C      [ 1]  212 1$: bset disp_flags,#F_SCROLL
      000641                        213     _clrz line       
      0086C1 3F 15                    1     .byte 0x3f, line 
      0086C3                        214 2$:
      0086C3 CC 86 95         [ 2]  215     jp scroll_up     
                                    216  
                                    217 
                                    218 
                                    219 ;-----------------------
                                    220 ; move cursor right 
                                    221 ; 1 character position
                                    222 ; scroll up if needed 
                                    223 ;-----------------------
      0086C6                        224 cursor_right:
      000646                        225     _ldaz col 
      0086C6 B6 16                    1     .byte 0xb6,col 
      0086C8 AB 01            [ 1]  226     add a,#1  
      00064A                        227     _straz col 
      0086CA B7 16                    1     .byte 0xb7,col 
      0086CC C1 00 17         [ 1]  228     cp a,cpl  
      0086CF 2B 03            [ 1]  229     jrmi 9$
      0086D1 CD 86 AB         [ 4]  230     call crlf 
      0086D4 81               [ 4]  231 9$: ret 
                                    232 
                                    233 ;----------------------------
                                    234 ; put char using rotated font 
                                    235 ; input:
                                    236 ;    A    character 
                                    237 ;-----------------------------
      0086D5                        238 put_char:
      0086D5 89               [ 2]  239     pushw x
      0086D6 90 89            [ 2]  240     pushw y 
      0086D8 88               [ 1]  241     push a 
      000659                        242     _ldaz line
      0086D9 B6 15                    1     .byte 0xb6,line 
      0086DB 72 03 00 1C 08   [ 2]  243     btjf disp_flags,#F_BIG,0$ 
      0086E0 48               [ 1]  244     sll a
      0086E1 90 95            [ 1]  245     ld yh,a 
      0086E3 4C               [ 1]  246     inc a 
      0086E4 90 97            [ 1]  247     ld yl,a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



      0086E6 20 04            [ 2]  248     jra 1$  
      0086E8                        249 0$: 
      0086E8 90 97            [ 1]  250     ld yl,a 
      0086EA 90 95            [ 1]  251     ld yh,a 
      0086EC                        252 1$:
      00066C                        253     _ldaz col 
      0086EC B6 16                    1     .byte 0xb6,col 
      0086EE 97               [ 1]  254     ld xl,a 
      00066F                        255     _ldaz font_width
      0086EF B6 19                    1     .byte 0xb6,font_width 
      0086F1 42               [ 4]  256     mul x,a 
      0086F2 9F               [ 1]  257     ld a,xl 
      0086F3 95               [ 1]  258     ld xh,a 
      0086F4 CB 00 19         [ 1]  259     add a,font_width 
      0086F7 4A               [ 1]  260     dec a 
      0086F8 97               [ 1]  261     ld xl,a 
      0086F9 CD 83 16         [ 4]  262     call set_window
      0086FC 84               [ 1]  263     pop a 
      0086FD A0 20            [ 1]  264  	sub a,#SPACE 
      0086FF 90 97            [ 1]  265 	ld yl,a  
      008701 A6 06            [ 1]  266     ld a,#OLED_FONT_WIDTH  
      008703 90 42            [ 4]  267 	mul y,a 
      008705 72 A9 83 64      [ 2]  268 	addw y,#oled_font_6x8
      008709 72 03 00 1C 05   [ 2]  269     btjf disp_flags,#F_BIG,2$ 
      00870E CD 87 9E         [ 4]  270     call zoom_char
      008711 20 08            [ 2]  271     jra 3$  
      008713                        272 2$:
      008713 AE 01 01         [ 2]  273     ldw x,#disp_buffer
      000696                        274     _ldaz to_send  
      008716 B6 1B                    1     .byte 0xb6,to_send 
      008718 CD 87 8D         [ 4]  275     call cmove 
      00871B 5F               [ 1]  276 3$: clrw x 
      00069C                        277     _ldaz to_send  
      00871C B6 1B                    1     .byte 0xb6,to_send 
      00871E 97               [ 1]  278     ld xl,a 
      00871F CD 83 4F         [ 4]  279     call oled_data 
      008722 CD 86 C6         [ 4]  280     call cursor_right 
      008725 90 85            [ 2]  281     popw y
      008727 85               [ 2]  282     popw x 
      008728 81               [ 4]  283     ret 
                                    284 
                                    285 
                                    286 ;----------------------
                                    287 ; put string in display 
                                    288 ; buffer 
                                    289 ; input:
                                    290 ;    y  .asciz  
                                    291 ;----------------------
      008729                        292 put_string:
      008729 90 F6            [ 1]  293 1$: ld a,(y)
      00872B 27 10            [ 1]  294     jreq 9$
      00872D A1 0A            [ 1]  295     cp a,#'\n'
      00872F 26 05            [ 1]  296     jrne 2$
      008731 CD 86 AB         [ 4]  297     call crlf 
      008734 20 03            [ 2]  298     jra 4$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      008736                        299 2$:
      008736 CD 86 D5         [ 4]  300     call put_char 
      008739                        301 4$:
      008739 90 5C            [ 1]  302     incw y 
      00873B 20 EC            [ 2]  303     jra 1$
                                    304 
      00873D                        305 9$:  
      00873D 81               [ 4]  306     ret 
                                    307 
                                    308 ;-----------------------
                                    309 ; convert integer to 
                                    310 ; ASCII string 
                                    311 ; input:
                                    312 ;   X    integer 
                                    313 ; output:
                                    314 ;   Y     *string 
                                    315 ;------------------------
                           000001   316     SIGN=1
      00873E                        317 itoa:
      00873E 4B 00            [ 1]  318     push #0 
      008740 5D               [ 2]  319     tnzw x 
      008741 2A 03            [ 1]  320     jrpl 1$ 
      008743 03 01            [ 1]  321     cpl (SIGN,SP)
      008745 50               [ 2]  322     negw x 
      008746 90 AE 01 89      [ 2]  323 1$: ldw y,#free_ram+8
      00874A 90 7F            [ 1]  324     clr(y)
      00874C                        325 2$:
      00874C 90 5A            [ 2]  326     decw y 
      00874E A6 0A            [ 1]  327     ld a,#10 
      008750 62               [ 2]  328     div x,a 
      008751 AB 30            [ 1]  329     add a,#'0 
      008753 90 F7            [ 1]  330     ld (y),a 
      008755 5D               [ 2]  331     tnzw x 
      008756 26 F4            [ 1]  332     jrne 2$
      008758 0D 01            [ 1]  333     tnz (SIGN,sp)
      00875A 2A 06            [ 1]  334     jrpl 4$
      00875C 90 5A            [ 2]  335     decw y 
      00875E A6 2D            [ 1]  336     ld a,#'-
      008760 90 F7            [ 1]  337     ld (y),a 
      0006E2                        338 4$: _drop 1 
      008762 5B 01            [ 2]    1     addw sp,#1 
      008764 81               [ 4]  339     ret 
                                    340 
                                    341 ;--------------------------
                                    342 ; put integer to display
                                    343 ; input:
                                    344 ;    X   integer 
                                    345 ;------------------------
      008765                        346 put_int:
      008765 90 89            [ 2]  347     pushw y 
      008767 CD 87 3E         [ 4]  348     call itoa 
      00876A CD 87 29         [ 4]  349     call put_string 
      00876D 90 85            [ 2]  350     popw y 
      00876F 81               [ 4]  351     ret 
                                    352 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



                                    353 ;-------------------
                                    354 ; put byte in hex 
                                    355 ; input:
                                    356 ;   A 
                                    357 ;------------------
      008770                        358 put_byte:
      008770 88               [ 1]  359     push a 
      008771 4E               [ 1]  360     swap a 
      008772 CD 87 76         [ 4]  361     call put_hex 
      008775 84               [ 1]  362     pop a 
      008776                        363 put_hex:    
      008776 A4 0F            [ 1]  364     and a,#0xf 
      008778 AB 30            [ 1]  365     add a,#'0 
      00877A A1 3A            [ 1]  366     cp a,#'9+1 
      00877C 2B 02            [ 1]  367     jrmi 2$ 
      00877E AB 07            [ 1]  368     add a,#7 
      008780 CD 86 D5         [ 4]  369 2$: call put_char 
      008783 81               [ 4]  370     ret 
                                    371 
                                    372 ;----------------------------
                                    373 ; put hexadecimal integer 
                                    374 ; in display 
                                    375 ; buffer 
                                    376 ; input:
                                    377 ;    X    integer to display 
                                    378 ;---------------------------
      008784                        379 put_hex_int:
      008784 9E               [ 1]  380     ld a,xh 
      008785 CD 87 70         [ 4]  381     call put_byte 
      008788 9F               [ 1]  382     ld a,xl 
      008789 CD 87 70         [ 4]  383     call put_byte 
      00878C 81               [ 4]  384     ret 
                                    385 
                                    386 
                                    387 ;----------------------------
                                    388 ; copy bytes from (y) to (x)
                                    389 ; input:
                                    390 ;   a    count 
                                    391 ;   x    destination 
                                    392 ;   y    source 
                                    393 ;---------------------------
      00878D                        394 cmove:
      00878D 4D               [ 1]  395     tnz a  
      00878E 27 0D            [ 1]  396     jreq 9$ 
      008790 88               [ 1]  397     push a 
      008791 90 F6            [ 1]  398 1$: ld a,(y)
      008793 F7               [ 1]  399     ld (x),a 
      008794 90 5C            [ 1]  400     incw y 
      008796 5C               [ 1]  401     incw x 
      008797 0A 01            [ 1]  402     dec(1,sp)
      008799 26 F6            [ 1]  403     jrne 1$
      00071B                        404     _drop 1 
      00879B 5B 01            [ 2]    1     addw sp,#1 
      00879D                        405 9$:    
      00879D 81               [ 4]  406     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



                                    407 
                                    408 ;---------------------
                                    409 ; zoom 6x8 character 
                                    410 ; to 12x16 pixel 
                                    411 ; put data in disp_buffer 
                                    412 ; input:
                                    413 ;    Y   character font address  
                                    414 ;----------------------
                           000001   415     BIT_CNT=1 
                           000002   416     BYTE_CNT=2
                           000002   417     VAR_SIZE=2
      00879E                        418 zoom_char:
      00071E                        419     _vars VAR_SIZE 
      00879E 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      0087A0 A6 06            [ 1]  420     ld a,#OLED_FONT_WIDTH
      0087A2 6B 02            [ 1]  421     ld (BYTE_CNT,sp),a
      0087A4 AE 01 01         [ 2]  422     ldw x,#disp_buffer 
      0087A7                        423 1$: ; byte loop 
      0087A7 A6 08            [ 1]  424     ld a,#8 
      0087A9 6B 01            [ 1]  425     ld (BIT_CNT,sp),a 
      0087AB 90 F6            [ 1]  426     ld a,(y)
      0087AD 90 5C            [ 1]  427     incw y
      0087AF                        428 2$:    
      0087AF 72 54 00 0A      [ 1]  429     srl acc16 
      0087B3 72 56 00 0B      [ 1]  430     rrc acc8 
      0087B7 72 54 00 0A      [ 1]  431     srl acc16
      0087BB 72 56 00 0B      [ 1]  432     rrc acc8 
      0087BF 44               [ 1]  433     srl a 
      0087C0 90 1F 00 0A      [ 1]  434     bccm acc16,#7 
      0087C4 90 1D 00 0A      [ 1]  435     bccm acc16,#6 
      0087C8 0A 01            [ 1]  436     dec (BIT_CNT,sp)
      0087CA 26 E3            [ 1]  437     jrne 2$ 
      00074C                        438     _ldaz acc8 
      0087CC B6 0B                    1     .byte 0xb6,acc8 
      0087CE F7               [ 1]  439     ld (x),a
      0087CF E7 01            [ 1]  440     ld (1,x),a  
      000751                        441     _ldaz acc16 
      0087D1 B6 0A                    1     .byte 0xb6,acc16 
      0087D3 E7 0C            [ 1]  442     ld (2*OLED_FONT_WIDTH,x),a
      0087D5 E7 0D            [ 1]  443     ld (2*OLED_FONT_WIDTH+1,x),a 
      0087D7 1C 00 02         [ 2]  444     addw x,#2 
      0087DA 0A 02            [ 1]  445     dec (BYTE_CNT,sp)
      0087DC 26 C9            [ 1]  446     jrne 1$
      00075E                        447     _drop VAR_SIZE 
      0087DE 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      0087E0 81               [ 4]  448     ret 
                                    449 
                                    450 ;------------------------------
                                    451 ; magnify character 4X 
                                    452 ; resulting in 24x32 pixels font  
                                    453 ; font size 96 bytes 
                                    454 ; input:
                                    455 ;    A   character 
                                    456 ;    XH  page 
                                    457 ;    XL  column 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



                                    458 ;------------------------------
                           000001   459     BIT_CNT=1 
                           000002   460     BYTE_CNT=2
                           000003   461     SHIFT_CNT=3 
                           000004   462     CHAR=4
                           000005   463     BYTE=5
                           000006   464     YSAVE=6
                           000007   465     VAR_SIZE=7
      0087E1                        466 put_mega_char:
      000761                        467     _vars VAR_SIZE
      0087E1 52 07            [ 2]    1     sub sp,#VAR_SIZE 
      0087E3 17 06            [ 2]  468     ldw (YSAVE,sp),y
      0087E5 6B 04            [ 1]  469     ld (CHAR,sp),a  
                                    470 ; set character window 
      0087E7 9E               [ 1]  471     ld a,xh 
      0087E8 90 95            [ 1]  472     ld yh,a 
      0087EA AB 03            [ 1]  473     add a,#MEGA_FONT_HEIGHT/8-1
      0087EC 90 97            [ 1]  474     ld yl,a 
      0087EE 5E               [ 1]  475     swapw x 
      0087EF 9E               [ 1]  476     ld a,xh 
      0087F0 AB 17            [ 1]  477     add a,#MEGA_FONT_WIDTH-1
      0087F2 97               [ 1]  478     ld xl,a 
      0087F3 CD 83 16         [ 4]  479     call set_window 
      0087F6 7B 04            [ 1]  480     ld a,(CHAR,sp)
      0087F8 A0 20            [ 1]  481     sub a,#SPACE 
      0087FA 90 97            [ 1]  482     ld yl,a 
      0087FC A6 06            [ 1]  483     ld a,#OLED_FONT_WIDTH
      0087FE 6B 02            [ 1]  484     ld (BYTE_CNT,sp),a 
      008800 90 42            [ 4]  485     mul y,a 
      008802 72 A9 83 64      [ 2]  486     addw y,#oled_font_6x8
      008806 AE 01 01         [ 2]  487     ldw x,#disp_buffer 
      008809                        488 1$: ; byte loop 
      008809 A6 08            [ 1]  489     ld a,#8 
      00880B 6B 01            [ 1]  490     ld (BIT_CNT,sp),a 
      00880D 90 F6            [ 1]  491     ld a,(y)
      00880F 6B 05            [ 1]  492     ld (BYTE,sp),a 
      008811 90 5C            [ 1]  493     incw y
      008813                        494 2$: ; bit loop 
      008813 A6 03            [ 1]  495     ld a,#3 
      008815 6B 03            [ 1]  496     ld (SHIFT_CNT,sp),a
      008817 04 05            [ 1]  497     srl (BYTE,sp)
      008819 66 48            [ 1]  498     rrc (72,x)  
      00881B 66 30            [ 1]  499     rrc (48,x)
      00881D 66 18            [ 1]  500     rrc (24,x)
      00881F 76               [ 1]  501     rrc (x)
      008820                        502 3$: ; shift loop     
      008820 67 48            [ 1]  503     sra (72,x) 
      008822 66 30            [ 1]  504     rrc (48,x)
      008824 66 18            [ 1]  505     rrc (24,x)
      008826 76               [ 1]  506     rrc (x)
      008827 0A 03            [ 1]  507     dec (SHIFT_CNT,sp)
      008829 26 F5            [ 1]  508     jrne 3$ 
      00882B 0A 01            [ 1]  509     dec (BIT_CNT,sp)
      00882D 26 E4            [ 1]  510     jrne 2$ 
      00882F A6 03            [ 1]  511     ld a,#3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



      008831 6B 03            [ 1]  512     ld (SHIFT_CNT,sp),a 
      008833                        513 4$: ; copy bytes in width 
      008833 F6               [ 1]  514     ld a,(x)
      008834 E7 01            [ 1]  515     ld (1,x),a 
      008836 E6 18            [ 1]  516     ld a,(24,x)
      008838 E7 19            [ 1]  517     ld (25,x),a 
      00883A E6 30            [ 1]  518     ld a,(48,x)
      00883C E7 31            [ 1]  519     ld (49,x),a 
      00883E E6 48            [ 1]  520     ld a,(72,x)
      008840 E7 49            [ 1]  521     ld (73,x),a 
      008842 5C               [ 1]  522     incw x 
      008843 0A 03            [ 1]  523     dec (SHIFT_CNT,sp)
      008845 26 EC            [ 1]  524     jrne 4$ 
      008847 0A 02            [ 1]  525     dec (BYTE_CNT,sp)
      008849 26 BE            [ 1]  526     jrne 1$
      00884B AE 00 60         [ 2]  527     ldw x,#MEGA_FONT_SIZE
      00884E CD 83 4F         [ 4]  528     call oled_data 
      008851 16 06            [ 2]  529     ldw y,(YSAVE,sp)
      0007D3                        530     _drop VAR_SIZE 
      008853 5B 07            [ 2]    1     addw sp,#VAR_SIZE 
      008855 81               [ 4]  531     ret 
                                    532 
                                    533 ;--------------------
                                    534 ; put mega character 
                                    535 ; string 
                                    536 ;     XH   top page   
                                    537 ;     XL   left column  
                                    538 ;     Y    *string 
                                    539 ;--------------------
                           000001   540     PAGE=1 
                           000002   541     COL=2 
                           000002   542     VAR_SIZE=2 
      008856                        543 put_mega_string:
      0007D6                        544     _vars VAR_SIZE 
      008856 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      008858 1F 01            [ 2]  545     ldw (PAGE,sp),x 
      00885A                        546 1$:
      00885A 90 7D            [ 1]  547     tnz (y)
      00885C 27 11            [ 1]  548     jreq 9$ 
      00885E 1E 01            [ 2]  549     ldw x,(PAGE,sp)
      008860 90 F6            [ 1]  550     ld a,(y)
      008862 90 5C            [ 1]  551     incw y 
      008864 CD 87 E1         [ 4]  552     call put_mega_char
      008867 7B 02            [ 1]  553     ld a,(COL,sp)
      008869 AB 18            [ 1]  554     add a,#MEGA_FONT_WIDTH
      00886B 6B 02            [ 1]  555     LD (COL,sp),a 
      00886D 20 EB            [ 2]  556     jra 1$
      00886F                        557 9$:
      0007EF                        558     _drop VAR_SIZE 
      00886F 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008871 81               [ 4]  559     ret 
                                    560 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022,2023  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           000000    19 SEPARATE=0
                                     20 
                           000000    21 .if SEPARATE 
                                     22     .module I2C   
                                     23     .include "config.inc"
                                     24 
                                     25     .area CODE 
                                     26 .endif 
                                     27 	
                                     28 ;---------------------------------------
                                     29 ; move memory block 
                                     30 ; input:
                                     31 ;   X 		destination 
                                     32 ;   Y 	    source 
                                     33 ;   acc16	bytes count 
                                     34 ; output:
                                     35 ;   none 
                                     36 ;--------------------------------------
                           000001    37 	INCR=1 ; incrament high byte 
                           000002    38 	LB=2 ; increment low byte 
                           000002    39 	VSIZE=2
      008872                         40 move::
      008872 88               [ 1]   41 	push a 
      0007F3                         42 	_vars VSIZE 
      008873 52 02            [ 2]    1     sub sp,#VSIZE 
      008875 0F 01            [ 1]   43 	clr (INCR,sp)
      008877 0F 02            [ 1]   44 	clr (LB,sp)
      008879 90 89            [ 2]   45 	pushw y 
      00887B 13 01            [ 2]   46 	cpw x,(1,sp) ; compare DEST to SRC 
      00887D 90 85            [ 2]   47 	popw y 
      00887F 27 2F            [ 1]   48 	jreq move_exit ; x==y 
      008881 2B 0E            [ 1]   49 	jrmi move_down
      008883                         50 move_up: ; start from top address with incr=-1
      008883 72 BB 00 0A      [ 2]   51 	addw x,acc16
      008887 72 B9 00 0A      [ 2]   52 	addw y,acc16
      00888B 03 01            [ 1]   53 	cpl (INCR,sp)
      00888D 03 02            [ 1]   54 	cpl (LB,sp)   ; increment = -1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      00888F 20 05            [ 2]   55 	jra move_loop  
      008891                         56 move_down: ; start from bottom address with incr=1 
      008891 5A               [ 2]   57     decw x 
      008892 90 5A            [ 2]   58 	decw y
      008894 0C 02            [ 1]   59 	inc (LB,sp) ; incr=1 
      008896                         60 move_loop:	
      000816                         61     _ldaz acc16 
      008896 B6 0A                    1     .byte 0xb6,acc16 
      008898 CA 00 0B         [ 1]   62 	or a, acc8
      00889B 27 13            [ 1]   63 	jreq move_exit 
      00889D 72 FB 01         [ 2]   64 	addw x,(INCR,sp)
      0088A0 72 F9 01         [ 2]   65 	addw y,(INCR,sp) 
      0088A3 90 F6            [ 1]   66 	ld a,(y)
      0088A5 F7               [ 1]   67 	ld (x),a 
      0088A6 89               [ 2]   68 	pushw x 
      000827                         69 	_ldxz acc16 
      0088A7 BE 0A                    1     .byte 0xbe,acc16 
      0088A9 5A               [ 2]   70 	decw x 
      0088AA CF 00 0A         [ 2]   71 	ldw acc16,x 
      0088AD 85               [ 2]   72 	popw x 
      0088AE 20 E6            [ 2]   73 	jra move_loop
      0088B0                         74 move_exit:
      000830                         75 	_drop VSIZE
      0088B0 5B 02            [ 2]    1     addw sp,#VSIZE 
      0088B2 84               [ 1]   76 	pop a 
      0088B3 81               [ 4]   77 	ret 	
                                     78 
                                     79 ;--------------------
                                     80 ; input:
                                     81 ;   X   duration msec 
                                     82 ;--------------------
      0088B4                         83 beep:
      0088B4 72 1C 50 C3      [ 1]   84 	bset CLK_PCKENR,#CLK_PCKENR_AWU_BEEP
      0088B8 72 10 50 02      [ 1]   85 	bset BEEP_PORT+GPIO_DDR,#BEEP_BIT 
      0088BC 35 30 50 F3      [ 1]   86 	mov BEEP_CSR,#0x30
      0088C0 CD 88 D0         [ 4]   87 	call pause 
      0088C3 35 1F 50 F3      [ 1]   88 	mov BEEP_CSR,#0X1F 
      0088C7 72 1D 50 C3      [ 1]   89 	bres CLK_PCKENR,#CLK_PCKENR_AWU_BEEP
      0088CB 72 11 50 02      [ 1]   90 	bres BEEP_PORT+GPIO_DDR,#BEEP_BIT 
      0088CF 81               [ 4]   91 	ret 
                                     92 
                                     93 ;------------------------
                                     94 ; suspend execution 
                                     95 ; parameter:
                                     96 ;   X     milliseconds 
                                     97 ;-------------------------
      0088D0                         98 pause:
      000850                         99 	_strxz timer 
      0088D0 BF 02                    1     .byte 0xbf,timer 
      0088D2 72 1E 00 0E      [ 1]  100 	bset flags,#FTIMER 
      0088D6 72 0E 00 0E FB   [ 2]  101 	btjt flags,#FTIMER,. 
      0088DB 81               [ 4]  102 	ret 
                                    103 
                                    104 
      0088DC                        105 main:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



      00085C                        106 	_led_on 
      0088DC 72 10 50 0F      [ 1]    1         bset LED_PORT,#LED_BIT 
      0088E0 AE 00 C8         [ 2]  107 	ldw x,#200
      0088E3 CD 88 B4         [ 4]  108 	call beep 
      0088E6 CD 82 79         [ 4]  109     call oled_init 
      0088E9 20 FE            [ 2]  110 jra .
      0088EB CD 86 74         [ 4]  111     call display_clear 
      0088EE A6 00            [ 1]  112     ld a,#SMALL  
      0088F0 CD 85 D4         [ 4]  113     call select_font 
      0088F3 90 AE 89 00      [ 2]  114     ldw y,#hello
      0088F7 CD 87 29         [ 4]  115     call put_string 
      00087A                        116 	_led_off
      0088FA 72 11 50 0F      [ 1]    1         bres LED_PORT,#LED_BIT 
      0088FE 20 FE            [ 2]  117 	jra . 
                                    118 
      008900 48 45 4C 4C 4F 20 57   119 hello: .asciz "HELLO WORLD!"
             4F 52 4C 44 21 00
                                    120 
                                    121 
                                    122 
                                    123 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ACK     =  000006     |     ADC1_AWC=  00540E 
    ADC1_AWC=  00540F     |     ADC1_AWS=  00540C     |     ADC1_AWS=  00540D 
    ADC1_CR1=  005401     |     ADC1_CR1=  000000     |     ADC1_CR1=  000001 
    ADC1_CR1=  000004     |     ADC1_CR1=  000005     |     ADC1_CR1=  000006 
    ADC1_CR2=  005402     |     ADC1_CR2=  000003     |     ADC1_CR2=  000004 
    ADC1_CR2=  000005     |     ADC1_CR2=  000006     |     ADC1_CR2=  000001 
    ADC1_CR3=  005403     |     ADC1_CR3=  000007     |     ADC1_CR3=  000006 
    ADC1_CSR=  005400     |     ADC1_CSR=  000006     |     ADC1_CSR=  000004 
    ADC1_CSR=  000000     |     ADC1_CSR=  000001     |     ADC1_CSR=  000002 
    ADC1_CSR=  000003     |     ADC1_CSR=  000007     |     ADC1_CSR=  000005 
    ADC1_DB0=  0053E0     |     ADC1_DB0=  0053E1     |     ADC1_DB1=  0053E2 
    ADC1_DB1=  0053E3     |     ADC1_DB2=  0053E4     |     ADC1_DB2=  0053E5 
    ADC1_DB3=  0053E6     |     ADC1_DB3=  0053E7     |     ADC1_DB4=  0053E8 
    ADC1_DB4=  0053E9     |     ADC1_DB5=  0053EA     |     ADC1_DB5=  0053EB 
    ADC1_DB6=  0053EC     |     ADC1_DB6=  0053ED     |     ADC1_DB7=  0053EE 
    ADC1_DB7=  0053EF     |     ADC1_DB8=  0053F0     |     ADC1_DB8=  0053F1 
    ADC1_DB9=  0053F2     |     ADC1_DB9=  0053F3     |     ADC1_DRH=  005404 
    ADC1_DRL=  005405     |     ADC1_HTR=  005408     |     ADC1_HTR=  005409 
    ADC1_LTR=  00540A     |     ADC1_LTR=  00540B     |     ADC1_TDR=  005406 
    ADC1_TDR=  005407     |     ADR_MODE=  000020     |     AWU_APR =  0050F1 
    AWU_CSR1=  0050F0     |     AWU_TBR =  0050F2     |     B115200 =  000006 
    B19200  =  000003     |     B230400 =  000007     |     B2400   =  000000 
    B38400  =  000004     |     B460800 =  000008     |     B4800   =  000001 
    B57600  =  000005     |     B921600 =  000009     |     B9600   =  000002 
    BEEP_BIT=  000000     |     BEEP_CSR=  0050F3     |     BEEP_POR=  005000 
    BELL    =  000007     |     BIG     =  000001     |     BIG_CPL =  00000A 
    BIG_FONT=  000010     |     BIG_FONT=  000018     |     BIG_FONT=  00000C 
    BIG_LINE=  000004     |     BIT_CNT =  000001     |     BS      =  000008 
    BYTE    =  000005     |     BYTE_CNT=  000002     |     CAN     =  000018 
    CFG_GCR =  007F60     |     CFG_GCR_=  000001     |     CFG_GCR_=  000000 
    CHAR    =  000004     |     CLK_CCOR=  0050C5     |     CLK_CKDI=  0050C0 
    CLK_FREQ=  000004     |     CLK_FREQ=  0000D5     |     CLK_PCKE=  0050C3 
    CLK_PCKE=  000006     |     CLK_PCKE=  000003     |     CLK_PCKE=  000004 
    CLK_PCKE=  000000     |     CLK_PCKE=  000001     |     CLK_PCKE=  000002 
    CLK_PCKE=  000005     |     COL     =  000002     |     COLON   =  00003A 
    COL_WND =  000021     |     COMMA   =  00002C     |     COM_ALTE=  000010 
    COM_CFG =  0000DA     |     COM_DISA=  000000     |     COM_ENAB=  000020 
    COM_SEQU=  000000     |     CPU_A   =  007F00     |     CPU_CCR =  007F0A 
    CPU_PCE =  007F01     |     CPU_PCH =  007F02     |     CPU_PCL =  007F03 
    CPU_SPH =  007F08     |     CPU_SPL =  007F09     |     CPU_XH  =  007F04 
    CPU_XL  =  007F05     |     CPU_YH  =  007F06     |     CPU_YL  =  007F07 
    CP_OFF  =  000010     |     CP_ON   =  000014     |     CR      =  00000D 
    CTRL_A  =  000001     |     CTRL_B  =  000002     |     CTRL_C  =  000003 
    CTRL_D  =  000004     |     CTRL_E  =  000005     |     CTRL_F  =  000006 
    CTRL_G  =  000007     |     CTRL_H  =  000008     |     CTRL_I  =  000009 
    CTRL_J  =  00000A     |     CTRL_K  =  00000B     |     CTRL_L  =  00000C 
    CTRL_M  =  00000D     |     CTRL_N  =  00000E     |     CTRL_O  =  00000F 
    CTRL_P  =  000010     |     CTRL_Q  =  000011     |     CTRL_R  =  000012 
    CTRL_S  =  000013     |     CTRL_T  =  000014     |     CTRL_U  =  000015 
    CTRL_V  =  000016     |     CTRL_W  =  000017     |     CTRL_X  =  000018 
    CTRL_Y  =  000019     |     CTRL_Z  =  00001A     |     DATASIZE=  004803 
    DC1     =  000011     |     DC2     =  000012     |     DC3     =  000013 
    DC4     =  000014     |     DEGREE  =  000087     |     DISPLAY_=  000080 
    DISP_ALL=  0000A5     |     DISP_CHA=  00008D     |     DISP_CON=  000081 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]

Symbol Table

    DISP_DIV=  000000     |     DISP_HEI=  000040     |     DISP_INV=  0000A7 
    DISP_NOR=  0000A6     |     DISP_OFF=  0000AE     |     DISP_OFF=  0000D3 
    DISP_ON =  0000AF     |     DISP_RAM=  0000A4     |     DISP_WID=  000080 
    DLE     =  000010     |     DM_BK1RE=  007F90     |     DM_BK1RH=  007F91 
    DM_BK1RL=  007F92     |     DM_BK2RE=  007F93     |     DM_BK2RH=  007F94 
    DM_BK2RL=  007F95     |     DM_CR1  =  007F96     |     DM_CR2  =  007F97 
    DM_CSR1 =  007F98     |     DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A 
    EEPROM_B=  009800     |     EEPROM_E=  009FFF     |     EEPROM_S=  000800 
    EM      =  000019     |     ENQ     =  000005     |     EOF     =  00001A 
    EOT     =  000004     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CON=  0050A5     |     EXTI_CR1=  0050A0 
    EXTI_CR2=  0050A1     |     EXTI_CR3=  0050A2     |     EXTI_SR1=  0050A3 
    EXTI_SR2=  0050A4     |     FF      =  00000C     |     FLASH_BA=  008000 
    FLASH_CR=  005050     |     FLASH_CR=  000002     |     FLASH_CR=  000000 
    FLASH_CR=  000003     |     FLASH_CR=  000001     |     FLASH_CR=  005051 
    FLASH_CR=  000005     |     FLASH_CR=  000004     |     FLASH_CR=  000007 
    FLASH_CR=  000000     |     FLASH_CR=  000006     |     FLASH_DU=  005053 
    FLASH_DU=  0000AE     |     FLASH_DU=  000056     |     FLASH_EN=  009FFF 
    FLASH_FP=  000000     |     FLASH_FP=  000001     |     FLASH_FP=  000002 
    FLASH_FP=  000003     |     FLASH_FP=  000004     |     FLASH_FP=  000005 
    FLASH_IA=  005054     |     FLASH_IA=  000003     |     FLASH_IA=  000002 
    FLASH_IA=  000006     |     FLASH_IA=  000001     |     FLASH_IA=  000000 
    FLASH_NF=  000000     |     FLASH_NF=  000001     |     FLASH_NF=  000002 
    FLASH_NF=  000003     |     FLASH_NF=  000004     |     FLASH_NF=  000005 
    FLASH_PU=  005052     |     FLASH_PU=  000056     |     FLASH_PU=  0000AE 
    FLASH_SI=  002000     |     FMSTR   =  000010     |     FS      =  00001C 
    FTIMER  =  000007     |     F_BIG   =  000001     |     F_SCROLL=  000000 
    Fmaster =  F42400     |     GPIO_BAS=  005000     |     GPIO_CR1=  000003 
    GPIO_CR2=  000004     |     GPIO_DDR=  000002     |     GPIO_IDR=  000001 
    GPIO_ODR=  000000     |     GPIO_SIZ=  000005     |     GS      =  00001D 
    HORZ_MOD=  000000     |     I2C_CCRH=  00521C     |     I2C_CCRH=  000080 
    I2C_CCRH=  0000C0     |     I2C_CCRH=  000080     |     I2C_CCRH=  000000 
    I2C_CCRH=  000001     |     I2C_CCRH=  000000     |     I2C_CCRL=  00521B 
    I2C_CCRL=  00001A     |     I2C_CCRL=  000002     |     I2C_CCRL=  00000D 
    I2C_CCRL=  000050     |     I2C_CCRL=  000090     |     I2C_CCRL=  0000A0 
    I2C_CR1 =  005210     |     I2C_CR1_=  000006     |     I2C_CR1_=  000007 
    I2C_CR1_=  000000     |     I2C_CR2 =  005211     |     I2C_CR2_=  000002 
    I2C_CR2_=  000003     |     I2C_CR2_=  000000     |     I2C_CR2_=  000001 
    I2C_CR2_=  000007     |     I2C_DR  =  005216     |     I2C_ERR_=  000003 
    I2C_ERR_=  000004     |     I2C_ERR_=  000000     |     I2C_ERR_=  000001 
    I2C_ERR_=  000002     |     I2C_ERR_=  000005     |     I2C_FAST=  000001 
    I2C_FREQ=  005212     |     I2C_ITR =  00521A     |     I2C_ITR_=  000002 
    I2C_ITR_=  000000     |     I2C_ITR_=  000001     |     I2C_OARH=  005214 
    I2C_OARH=  000001     |     I2C_OARH=  000002     |     I2C_OARH=  000006 
    I2C_OARH=  000007     |     I2C_OARL=  005213     |     I2C_OARL=  000000 
    I2C_OAR_=  000813     |     I2C_OAR_=  000009     |     I2C_PORT=  00500A 
    I2C_READ=  000001     |     I2C_SR1 =  005217     |     I2C_SR1_=  000003 
    I2C_SR1_=  000001     |     I2C_SR1_=  000002     |     I2C_SR1_=  000006 
    I2C_SR1_=  000000     |     I2C_SR1_=  000004     |     I2C_SR1_=  000007 
    I2C_SR2 =  005218     |     I2C_SR2_=  000002     |     I2C_SR2_=  000001 
    I2C_SR2_=  000000     |     I2C_SR2_=  000003     |     I2C_SR2_=  000005 
    I2C_SR3 =  005219     |     I2C_SR3_=  000001     |     I2C_SR3_=  000007 
    I2C_SR3_=  000004     |     I2C_SR3_=  000000     |     I2C_SR3_=  000002 
    I2C_STAT=  000005     |     I2C_STAT=  000007     |     I2C_STAT=  000006 
    I2C_STD =  000000     |     I2C_TRIS=  00521D     |     I2C_TRIS=  000005 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]

Symbol Table

    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000011 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_WRIT=  000000 
  7 I2cIntHa   00009C R   |     INCR    =  000001     |     INPUT_DI=  000000 
    INPUT_EI=  000001     |     INPUT_FL=  000000     |     INPUT_PU=  000001 
    INT_AWU =  000004     |     INT_COMP=  000012     |     INT_EXTI=  000008 
    INT_EXTI=  000009     |     INT_EXTI=  00000A     |     INT_EXTI=  00000B 
    INT_EXTI=  00000C     |     INT_EXTI=  00000D     |     INT_EXTI=  00000E 
    INT_EXTI=  00000F     |     INT_EXTI=  000006     |     INT_EXTI=  000007 
    INT_FLAS=  000001     |     INT_I2C =  00001D     |     INT_SPI =  00001A 
    INT_TIM2=  000014     |     INT_TIM2=  000013     |     INT_TIM3=  000016 
    INT_TIM3=  000015     |     INT_TIM4=  000019     |     INT_USAR=  00001C 
    INT_USAR=  00001B     |     INT_VECT=  008018     |     INT_VECT=  008050 
    INT_VECT=  008028     |     INT_VECT=  00802C     |     INT_VECT=  008030 
    INT_VECT=  008034     |     INT_VECT=  008038     |     INT_VECT=  00803C 
    INT_VECT=  008040     |     INT_VECT=  008044     |     INT_VECT=  008020 
    INT_VECT=  008024     |     INT_VECT=  00800C     |     INT_VECT=  00807C 
    INT_VECT=  008000     |     INT_VECT=  008070     |     INT_VECT=  008058 
    INT_VECT=  008054     |     INT_VECT=  008060     |     INT_VECT=  00805C 
    INT_VECT=  00806C     |     INT_VECT=  008004     |     INT_VECT=  008078 
    INT_VECT=  008074     |     ITC_SPR1=  007F70     |     ITC_SPR2=  007F71 
    ITC_SPR3=  007F72     |     ITC_SPR4=  007F73     |     ITC_SPR5=  007F74 
    ITC_SPR6=  007F75     |     ITC_SPR7=  007F76     |     ITC_SPR8=  007F77 
    ITC_SPR_=  000001     |     ITC_SPR_=  000000     |     ITC_SPR_=  000003 
    IWDGOPT =  004808     |     IWDGOPT_=  000001     |     IWDGOPT_=  000000 
    IWDG_KR =  0050E0     |     IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2 
    LB      =  000002     |     LED_BIT =  000000     |     LED_PORT=  00500F 
    LF      =  00000A     |     MAJOR   =  000001     |     MAP_SEG0=  0000A0 
    MAP_SEG0=  0000A1     |     MEGA_CPL=  000005     |     MEGA_FON=  000020 
    MEGA_FON=  000060     |     MEGA_FON=  000018     |     MEGA_LIN=  000002 
    MINOR   =  000000     |     MUX_RATI=  0000A8     |     NAK     =  000015 
  7 NonHandl   000000 R   |     OLED_CMD=  000080     |     OLED_DAT=  000040 
    OLED_DEV=  000078     |     OLED_FON=  000008     |     OLED_FON=  000006 
    OLED_NOP=  0000E3     |     OPT1    =  004800     |     OPT2    =  004802 
    OPT3    =  004803     |     OPT4    =  004808     |     OPTION_B=  004800 
    OPTION_E=  00483F     |     OUTPUT_F=  000001     |     OUTPUT_O=  000000 
    OUTPUT_P=  000001     |     OUTPUT_S=  000000     |     PA      =  005000 
    PAGE    =  000001     |     PAGE_MOD=  000002     |     PAGE_SIZ=  000040 
    PAG_WND =  000022     |     PA_CR1  =  005003     |     PA_CR2  =  005004 
    PA_DDR  =  005002     |     PA_IDR  =  005001     |     PA_ODR  =  005000 
    PB      =  005005     |     PB_CR1  =  005008     |     PB_CR2  =  005009 
    PB_DDR  =  005007     |     PB_IDR  =  005006     |     PB_ODR  =  005005 
    PC      =  00500A     |     PC_CR1  =  00500D     |     PC_CR2  =  00500E 
    PC_DDR  =  00500C     |     PC_IDR  =  00500B     |     PC_ODR  =  00500A 
    PD      =  00500F     |     PD_CR1  =  005012     |     PD_CR2  =  005013 
    PD_DDR  =  005011     |     PD_IDR  =  005010     |     PD_ODR  =  00500F 
    PHASE1_P=  000000     |     PHASE2_P=  000004     |     PIN0    =  000000 
    PIN1    =  000001     |     PIN2    =  000002     |     PIN3    =  000003 
    PIN4    =  000004     |     PIN5    =  000005     |     PIN6    =  000006 
    PIN7    =  000007     |     PRE_CHAR=  0000D9     |     RAM_BASE=  000000 
    RAM_END =  0005FF     |     RAM_SIZE=  000600     |     REV     =  000000 
    ROP     =  004800     |     RS      =  00001E     |     RST_CR  =  0050B0 
    RST_SR  =  0050B1     |     SCAN_REV=  0000C8     |     SCAN_TOP=  0000C0 
    SCL_BIT =  000001     |     SCROLL_L=  000027     |     SCROLL_R=  000026 
    SCROLL_S=  00002F     |     SCROLL_S=  00002E     |     SCROLL_V=  00002A 
    SCROLL_V=  000029     |     SDA_BIT =  000000     |     SEMIC   =  00003B 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]

Symbol Table

    SEPARATE=  000000     |     SFR_BASE=  005000     |     SFR_END =  0057FF 
    SHARP   =  000023     |     SHIFT_CN=  000003     |     SI      =  00000F 
    SIGN    =  000001     |     SMALL   =  000000     |     SMALL_CP=  000015 
    SMALL_FO=  000008     |     SMALL_FO=  000006     |     SMALL_FO=  000006 
    SMALL_LI=  000008     |     SO      =  00000E     |     SOH     =  000001 
    SPACE   =  000020     |     SPI_CR1 =  005200     |     SPI_CR2 =  005201 
    SPI_DR  =  005204     |     SPI_ICR =  005202     |     SPI_SR  =  005203 
    STACK_EM=  0005FF     |     STACK_SI=  000080     |     START_LI=  000040 
    STX     =  000002     |     SUB     =  00001A     |     SWIM_CSR=  007F80 
    SYN     =  000016     |     TAB     =  000009     |     TICK    =  000027 
    TIM2_ARR=  00525E     |     TIM2_ARR=  00525F     |     TIM2_BKR=  005264 
    TIM2_CCE=  00525A     |     TIM2_CCM=  005258     |     TIM2_CCM=  005259 
    TIM2_CCR=  005260     |     TIM2_CCR=  005261     |     TIM2_CCR=  005262 
    TIM2_CCR=  005263     |     TIM2_CLK=  00F424     |     TIM2_CNT=  00525B 
    TIM2_CNT=  00525C     |     TIM2_CR1=  005250     |     TIM2_CR2=  005251 
    TIM2_EGR=  005257     |     TIM2_ETR=  005253     |     TIM2_IER=  005254 
    TIM2_OIS=  005265     |     TIM2_PSC=  00525D     |     TIM2_SMC=  005252 
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
    TIM4_PSC=  000002     |     TIM4_SMC=  0052E2     |     TIM4_SR1=  0052E4 
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
    TIM_SR2_=  000001     |     TIM_SR2_=  000002     |   7 Timer4Up   000001 R
    UBC     =  004802     |     US      =  00001F     |     USART_BR=  005232 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]

Symbol Table

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
    VAR_SIZE=  000002     |     VCOMH_DS=  0000DB     |     VCOMH_DS=  000000 
    VCOMH_DS=  000020     |     VCOMH_DS=  000030     |     VERT_MOD=  000001 
    VERT_SCR=  0000A3     |     VSIZE   =  000002     |     VT      =  00000B 
    WFE_CR1 =  0050A6     |     WFE_CR2 =  0050A7     |     XOFF    =  000013 
    XON     =  000011     |     YSAVE   =  000006     |   5 acc16      00000A GR
  5 acc24      000009 GR  |   5 acc32      000008 GR  |   5 acc8       00000B GR
  7 all_disp   000277 R   |   7 beep       000834 R   |   7 blink      000160 R
  7 blink0     000158 R   |   7 blink1     00015D R   |   7 clear_di   0005E5 R
  7 clock_in   00001D R   |   7 cmove      00070D R   |   6 co_code    000100 R
  5 col        000016 R   |   7 cold_sta   00003F R   |   5 cpl        000017 R
  7 crlf       00062B R   |   7 cursor_r   000646 R   |   6 disp_buf   000101 R
  5 disp_fla   00001C R   |   5 disp_lin   000018 R   |   7 display_   0005F4 R
  7 end_of_t   000109 R   |   7 evt_addr   0000E2 R   |   7 evt_btf    0000FD R
  7 evt_rxne   000116 R   |   7 evt_sb     0000DC R   |   7 evt_stop   000131 R
  7 evt_txe    0000E8 R   |   7 evt_txe_   0000ED R   |   7 fast       0001AE R
  5 flags      00000E GR  |   5 font_hei   00001A R   |   5 font_wid   000019 R
  6 free_ram   000181 R   |   7 hello      000880 R   |   5 i2c_buf    00000F R
  5 i2c_coun   000011 R   |   5 i2c_devi   000014 R   |   7 i2c_erro   000145 R
  5 i2c_idx    000012 R   |   7 i2c_init   0001BF R   |   7 i2c_scl_   000198 R
  7 i2c_scl_   0001BA R   |   7 i2c_star   0001E2 R   |   5 i2c_stat   000013 R
  7 i2c_writ   00017B R   |   7 itoa       0006BE R   |   5 line       000015 R
  7 line_cle   0005CD R   |   7 line_win   0005B3 R   |   7 main       00085C R
  7 move       0007F2 GR  |   7 move_dow   000811 R   |   7 move_exi   000830 R
  7 move_loo   000816 R   |   7 move_up    000803 R   |   7 nibble_l   00014D R
  7 oled_cmd   0002B3 R   |   7 oled_dat   0002CF R   |   7 oled_fon   0002E4 R
  7 oled_fon   000554 R   |   7 oled_ini   0001F9 GR  |   7 pause      000850 R
  5 ptr16      00000C GR  |   5 ptr8       00000D R   |   7 put_byte   0006F0 R
  7 put_char   000655 R   |   7 put_hex    0006F6 R   |   7 put_hex_   000704 R
  7 put_int    0006E5 R   |   7 put_mega   000761 R   |   7 put_mega   0007D6 R
  7 put_stri   0006A9 R   |   7 scroll_u   000615 R   |   5 seedx      000004 R
  5 seedy      000006 R   |   7 select_f   000554 R   |   7 set_wind   000296 R
  2 stack_fu   00057F GR  |   2 stack_un   0005FF R   |   7 std        0001A0 R
  7 swim_pro   000082 R   |   5 ticks      000000 R   |   5 timer      000002 GR
  7 timer4_i   000026 R   |   5 to_send    00001B R   |   7 zoom_cha   00071E R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     1D   flags    8
   6 DATA2      size     81   flags    8
   7 CODE       size    88D   flags    0

