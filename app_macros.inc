;;
; Copyright Jacques Deschênes 2019 
; This file is part of STM8_NUCLEO 
;
;     STM8_NUCLEO is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     STM8_NUCLEO is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
;;
;--------------------------------------

    TIM2_CLK_FREQ=62500

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


;------------------------------------
;  board user LED control macros 
;------------------------------------

    .macro _led_on 
        bset LED_PORT,#LED_BIT 
    .endm 

    .macro _led_off 
        bres LED_PORT,#LED_BIT 
    .endm 

    .macro _led_toggle
        bcpl LED_PORT,#LED_BIT  
    .endm 

