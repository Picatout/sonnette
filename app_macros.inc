;;
; Copyright Jacques Deschênes 2019 
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
;--------------------------------------

	.include "inc/stm8l001j3.inc" 

    FMSTR = 2000000 ; 2Mhz

; sound output 
    BELL_PORT=PD
    BELL_BIT=0

    .macro _tone_on
    bset TIM3_CR1,#TIM_CR1_CEN 
    .endm

    .macro _tone_off 
	bres TIM3_CR1,#TIM_CR1_CEN 
    .endm 

; bell button input 
    BTN_PORT=PC 
    BTN_BIT=1 

    ; enable exti on ring button 
    .macro _enable_button
    bset BTN_PORT+GPIO_CR2,#BTN_BIT 
    .endm 

    ; disable exti on ring button 
    .macro _disable_button
    bres BTN_PORT+GPIO_CR2,#BTN_BIT 
    .endm 

; LED port 
    LED_PORT=PB 
    LED_BIT=7

    .macro _led_on 
    bres LED_PORT,#LED_BIT 
    .endm 

    .macro _led_off 
    bset LED_PORT,#LED_BIT 
    .endm 

    .macro _led_toggle 
    bcpl LED_PORT,#LED_BIT 
    .endm 


	.include "inc/gen_macros.inc"

    STACK_SIZE=128
    STACK_EMPTY=RAM_SIZE-1 

; boolean flags 
    FTIMER=7 

;--------------------------------------
;   assembler flags 
;-------------------------------------

    ; assume 16 Mhz Fcpu 
     .macro _usec_dly n 
    ldw x,#(16*n-2)/4 ; 2 cy 
    decw x  ; 1 cy 
    nop     ; 1 cy 
    jrne .-2 ; 2 cy 
    .endm 

;----------------------------------
; functions arguments access 
; from stack 
; caller push arguments before call
; and drop them after call  
;----------------------------------    
    ; get argument in X 
    .macro _get_arg n 
    ldw x,(2*(n+1),sp)
    .endm 

    ; store X in argument n 
    .macro _store_arg n 
    ldw (2*(n+1),sp),x 
    .endm 

    ; drop function arguments 
    .macro _drop_args n 
    addw sp,#2*n
    .endm 

