;;
; Copyright Jacques Deschênes 2024 
; This file is part of doorbell.asm
;
;     doorbell.asm is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     doorbell.asm is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with doorbell.asm.  If not, see <http://www.gnu.org/licenses/>.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialisation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

    .module HW_INIT 

	.include "app_macros.inc" 


;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_END - STACK_SIZE 
stack_full:: .ds STACK_SIZE   ; control stack 
stack_unf:: ; stack underflow ; control_stack bottom 

;;--------------------------------------
    .area HOME 
;; interrupt vector table at 0x8000
;;--------------------------------------

    int reset   			; RESET vector 
	int NonHandledInterrupt ; TRAP instruction 
	.word 0,0               ; not used  
	int NonHandledInterrupt ; int1 FLASH   
	.word 0,0,0,0           ; 2,3 not used
	int NonHandledInterrupt ; int4 AWU 
	.word 0,0               ; 5 not used 
	int NonHandledInterrupt ; int6 EXTIB
	int NonHandledInterrupt ; int7 EXITD  
	int NonHandledInterrupt ; int8 EXTI0
	int BtnExtiHandler      ; int9 EXIT1  
	int NonHandledInterrupt ; int10 EXTI2 
	int NonHandledInterrupt ; int11 EXTI3 
	int NonHandledInterrupt ; int12 EXTI4 
	int NonHandledInterrupt ; int13 EXTI5 
	int NonHandledInterrupt ; int14 EXTI6 
	int NonHandledInterrupt ; int15 EXTI7 
	.word 0,0,0,0           ; 16,17 not used 
	int NonHandledInterrupt ; int18 COMP 
	int NonHandledInterrupt ;int19 TIM2 update /overflow
	int NonHandledInterrupt ;int20 TIM2 capture/compare
	int NonHandledInterrupt ;int21 TIM3 Update/overflow
	int NonHandledInterrupt ;int22 TIM3 Capture/compare
	.word 0,0				; int23 not used 
	.word 0,0               ; int24 not used 
	int Timer4UpdateHandler ; int25 TIMER4 overflow
	int Timer4UpdateHandler ; int26 SPI 
	int NonHandledInterrupt ;int27 USART TX completed
	int NonHandledInterrupt ;int28 USART RX full 
	int NonHandledInterrupt ;int29 I2C 

;--------------------------------------
    .area DATA (ABS)
	.org 1 
;--------------------------------------	
; keep the following 3 variables in this order 
ticks:: .blkw 1 ; milliseconds ticks counter (see Timer4UpdateHandler)
timer:: .blkw 1 ;  milliseconds count down timer 
flags:: .blkb 1 ; various boolean flags
ptr:: .blkw 1 ; score pointer 

	.org 0x100
free_ram:: ; from here RAM free for BASIC text 

	.area CODE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	iret 

;;;;;;;;;;;;;;;;;;;;;;;
; doorbell button 
; interrupt handler 
;;;;;;;;;;;;;;;;;;;;;;;
BtnExtiHandler:
	_disable_button
	bset EXTI_SR1,#BTN_BIT ; clear interrupt
	iret 
	
;------------------------------
; TIMER 4 is used to maintain 
; a milliseconds 'ticks' counter
; and decrement 'timer' varaiable
; ticks range {0..65535}
; timer range {0..65535}
;--------------------------------
Timer4UpdateHandler:
0$:
	clr TIM4_SR 
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
; keep it at default 2Mhz 
;----------------------------------------
clock_init:	
;	clr CLK_CKDIVR ; 16Mhz HSI oscillator 
	ret

;---------------------------------
; TIM4 is configured to generate an 
; interrupt every millisecond 
;----------------------------------
timer4_init:
	bset CLK_PCKENR,#CLK_PCKENR_TIM4
	bres TIM4_CR1,#TIM4_CR1_CEN 
	mov TIM4_PSCR,#4 ; FMSTR/16=125000 hertz  
	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
	bset TIM4_IER,#TIM4_IER_UIE
	ret

;---------------------------------------
; confirugre TIMER3 in PWM mode 
; for sound generation
; output TIMER3:CH2 on mcu pin 5 
;---------------------------------------
timer3_init:
	bset CLK_PCKENR,#CLK_PCKENR_TIM3 ; enable TIMER3 clock 
 	mov TIM3_CCMR2,#(6<<TIM_CCMR2_OC2M) ; PWM mode 1 
;	mov TIM3_PSCR,#3 ; FMSTR/8
	bres TIM3_CCER1,#TIM_CCER1_CC2E
	bset TIM3_BKR,#TIM_BKR_MOE
	ret 

;---------------------------------------
; configure external interrupt on 
; doorbell button. This wakeup mcu from 
; halt state 
; exti on PC:1, mcu pin 8 
;---------------------------------------
config_exti:
	mov EXTI_CR1,#(2<<(2*BTN_BIT)) ; falling edge trigger  
	ret 


;---------------------
; delay_msec 
; input:
;    X  delay in msec 
; output:
;    none 
;---------------------
delay_msec: 
	_strxz timer 
	bset flags,#FTIMER 
1$: btjt flags,#FTIMER,1$
	ret 

;---------------------
; tone generator 
; use TIMER3 channel 2
; input:
;   Y   frequency (arr value) 
;   x   duration (msec)
;---------------------
	DIVR=1  ; divisor 
	DLY_MS=3
	VSIZE=4 
FR_TIM3=FMSTR 
tone:: 
	_led_on 
	ld a,yh 
	ld TIM3_ARRH,a 
	ld a,yl 
	ld TIM3_ARRL,a 
; 25% duty cycle 
	srlw y  
	ld a,yh 
	ld TIM3_CCR2H,a 
	ld a,yl
	ld TIM3_CCR2L,a
	bset TIM3_CCER1,#TIM_CCER1_CC2E
	bset TIM3_CR1,#TIM_CR1_CEN
	bset TIM3_EGR,#TIM_EGR_UG 	
;	ldw x,(DLY_MS,sp)
	_led_on 
	_tone_on
	subw x,#60 
	call delay_msec
	_led_off 
	ldw x,#60
tone_off: 
	_tone_off 
	call delay_msec
	ret 

score: ; frenquency (ARR value), duration (msec) 
	.word 2551,300 ; sol4 
	.word 2273,300 ; la4 
	.word 2863,300 ; fa4 
	.word 5727,300 ; fa3 
	.word 3822,300 ; do4 
	.word 0,0 ; end marker 

;-----------------------------
; doorbell play a short tune 
;-----------------------------

play_tune:
	ldw x,#score 
	_strxz ptr 
1$:
	ldw y,[ptr]
	jreq 3$
	_ldxz ptr 
	addw x,#4
	_strxz ptr 
	decw x 
	decw x 
	ldw x,(x)
	call tone
	jra 1$ 
3$: 
; end test code 
	ret 

	
;-------------------------------------
;  initialization entry point 
;-------------------------------------
reset:
;set stack 
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
; set user BELL sound pin as output 
    bset BELL_PORT+GPIO_DDR,#BELL_BIT ; output
    bset BELL_PORT+GPIO_CR1,#BELL_BIT ; push pull 
; set LED port as output open drain 
	bset LED_PORT+GPIO_DDR,#LED_BIT
	_led_off 
; init TIMER4 to interrupt at every millisecond
	call timer4_init
; init TIMER3, for sound generation 
	call timer3_init
; configure EXTI on button 
	call config_exti
; enable interrupts	
	rim
	ldw y,#2000
	ldw x,#150
	call tone 
1$:
	_enable_button
    halt  	
	call play_tune 
	jra 1$ 
