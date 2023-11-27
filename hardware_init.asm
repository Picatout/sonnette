;;
; Copyright Jacques Deschênes 2019,2022  
; This file is part of stm8_tbi 
;
;     stm8_tbi is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8_tbi is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialisation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;------------------------
; if unified compilation 
; must be first in list 
;-----------------------

    .module HW_INIT 

    .include "config.inc"


STACK_SIZE=128
STACK_EMPTY=RAM_SIZE-1 

;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_END - STACK_SIZE 
stack_full:: .ds STACK_SIZE   ; control stack 
stack_unf: ; stack underflow ; control_stack bottom 

;;--------------------------------------
    .area HOME 
;; interrupt vector table at 0x8000
;;--------------------------------------

    int cold_start			; RESET vector 
	int NonHandledInterrupt ; trap instruction 
	.word 0,0  ; vector 0 not used 
	int NonHandledInterrupt ;int0 FLASH programming  
	.word 0,0,0,0  ; vector 2,3 not used 
	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
	.word 0,0 ; vector 5 not used 
	int NonHandledInterrupt ;int6 EXITB 
	int NonHandledInterrupt ;int7 EXTID 
	int NonHandledInterrupt ;int8 EXTI0
	int NonHandledInterrupt ;int9 EXIT1  
	int NonHandledInterrupt ;int10 EXTI2 gpio C external interrupts
	int NonHandledInterrupt ;int11 EXTI3 gpio D external interrupts
	int NonHandledInterrupt ;int12 EXTI4 
	int NonHandledInterrupt ;int13 EXTI5  
	int NonHandledInterrupt ;int14 EXTI6 
	int NonHandledInterrupt ;int15 EXTI7 
	.word 0,0,0,0 ; vector 16,17 not used 
	int NonHandledInterrupt ;int18 comparators
	int NonHandledInterrupt ;int19 TIM2 update /overflow
	int NonHandledInterrupt ;int20 TIM2 capture/compare
	int NonHandledInterrupt ;int21 TIM3 Update/overflow
	int NonHandledInterrupt ;int22 TIM3 Capture/compare
	.word 0,0,0,0 ; vector 23,24 not used 
	int Timer4UpdateHandler	;int25 TIM4 update/overflow 
	int NonHandledInterrupt ;int26 SPI End of transfer
	int NonHandledInterrupt ;int28 USART TX completed
	int NonHandledInterrupt ;int28 USART RX full 
	int I2cIntHandler       ;int29 I2C 


;--------------------------------------
    .area DATA (ABS)
	.org 0  
;--------------------------------------	
; keep the following 3 variables in this order 
ticks: .blkb 2 ; milliseconds ticks counter (see Timer4UpdateHandler)
timer:: .blkw 1 ;  milliseconds count down timer 
seedx: .blkw 1  ; xorshift 16 seed x  used by RND() function 
seedy: .blkw 1  ; xorshift 16 seed y  used by RND() funcion
acc32:: .blkb 1 ; 32 bit accumalator upper-byte 
acc24:: .blkb 1 ; 24 bits accumulator upper-byte 
acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
flags:: .blkb 1 ; various boolean flags
; I2C peripheral 
i2c_buf: .blkw 1 ; i2c buffer address 
i2c_count: .blkb 1 ; bytes to transmit 
i2c_idx: .blkb 1 ; index in buffer
i2c_status: .blkb 1 ; error status 
i2c_devid: .blkb 1 ; device identifier  
;; OLED display 
line: .blkb 1 ; text line cursor position 
col: .blkb 1 ;  text column cursor position
cpl: .blkb 1 ; characters per line 
disp_lines: .blkb 1 ; text lines per display  
font_width: .blkb 1 ; character width in pixels 
font_height: .blkb 1 ; character height in pixels 
to_send: .blkb 1 ; bytes to send per character 
disp_flags: .blkb 1 ; boolean flags 

	.org 0x100
co_code: .blkb 1	
disp_buffer: .ds DISPLAY_BUFFER_SIZE ; oled display page buffer 

free_ram: ; from here RAM free for BASIC text 

	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	iret 

;------------------------------
; TIMER 4 is used to maintain 
; a milliseconds 'ticks' counter
; and decrement 'timer' varaiable
; ticks range {0..65535}
; timer range {0..65535}
;--------------------------------
Timer4UpdateHandler:
	clr TIM4_SR1 
	_ldxz ticks
	addw x,#1 
	_strxz ticks 
	btjf flags,#FTIMER,1$
	_ldxz timer
	decw x 
	_strxz timer
	jrne 1$ 
	bres flags,#FTIMER  
1$:	
	iret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    peripherals initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;----------------------------------------
; inialize MCU clock 
; input:
;   A       fmstr Mhz 
;   XL      CLK_CKDIVR , clock divisor
;   XH     HSI|HSE   
; output:
;   none 
;----------------------------------------
clock_init:	
	clr CLK_CKDIVR 
	bset CLK_PCKENR,#CLK_PCKENR_I2C 
	ret

;---------------------------------
; TIM4 is configured to generate an 
; interrupt every millisecond 
;----------------------------------
timer4_init:
	bset CLK_PCKENR,#CLK_PCKENR_TIM4
	bres TIM4_CR1,#TIM4_CR1_CEN 
	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
	bset TIM4_IER,#TIM4_IER_UIE
	ret

;-------------------------------------
;  initialization entry point 
;-------------------------------------
cold_start:
;set stack 
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
call swim_probe
; set pull up on
; pin 2 -> PA2 
	bset PA_CR1,#2
; pin 5 -> PD0 
	bset PD_CR1,#0 
; pin 6 -> PB6 
	bset PB_CR1,#6 
; if PA2 == 0 then loop until released 
; in case PA0 is used as GPIO by program 
; which forbid SWIM. 
	btjf PA_IDR,#2,. 
; set user LED pin as output 
    bset LED_PORT+GPIO_DDR,#LED_BIT ; output
    bset LED_PORT+GPIO_CR1,#LED_BIT ; push pull 
	bres LED_PORT+GPIO_ODR,#LED_BIT ; turn off user LED  
    call clock_init 
	call timer4_init ; msec ticks timer 
	ld a,#I2C_FAST 
	call i2c_init 
	rim ; enable interrupts 
; RND function seed 
; must be initialized 
; to value other than 0.
; take values from ROM space 
	ldw x,#I2cIntHandler
	ldw seedy,x  
	ldw x,#main 
	ldw seedx,x  
    jp main 	


;---------------------
; probe PB6 
; if 0 then loop  
; until released 
; needed for SWIM 
; in case PA0 used 
; as output 
;---------------------
swim_probe:
	push PB_CR1
	push PB_DDR
	bres PB_DDR,#6 
	bset PB_CR1,#6 ; pull up 
	btjf PB_IDR,#6,.
	pop PB_DDR 
	pop PB_CR1
	ret 

