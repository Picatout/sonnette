;;
; Copyright Jacques Deschênes 2019,2022,2023  
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

SEPARATE=0

.if SEPARATE 
    .module I2C   
    .include "config.inc"

    .area CODE 
.endif 
	
.if 0
;---------------------------------------
; move memory block 
; input:
;   X 		destination 
;   Y 	    source 
;   acc16	bytes count 
; output:
;   none 
;--------------------------------------
	INCR=1 ; incrament high byte 
	LB=2 ; increment low byte 
	VSIZE=2
move::
	push a 
	_vars VSIZE 
	clr (INCR,sp)
	clr (LB,sp)
	pushw y 
	cpw x,(1,sp) ; compare DEST to SRC 
	popw y 
	jreq move_exit ; x==y 
	jrmi move_down
move_up: ; start from top address with incr=-1
	addw x,acc16
	addw y,acc16
	cpl (INCR,sp)
	cpl (LB,sp)   ; increment = -1 
	jra move_loop  
move_down: ; start from bottom address with incr=1 
    decw x 
	decw y
	inc (LB,sp) ; incr=1 
move_loop:	
    _ldaz acc16 
	or a, acc8
	jreq move_exit 
	addw x,(INCR,sp)
	addw y,(INCR,sp) 
	ld a,(y)
	ld (x),a 
	pushw x 
	_ldxz acc16 
	decw x 
	ldw acc16,x 
	popw x 
	jra move_loop
move_exit:
	_drop VSIZE
	pop a 
	ret 	
.endif 

;--------------------
; input:
;   X   duration msec 
;--------------------
beep:
	bset CLK_PCKENR,#CLK_PCKENR_AWU_BEEP
	bset BEEP_PORT+GPIO_DDR,#BEEP_BIT 
	mov BEEP_CSR,#0x30
	call pause 
	mov BEEP_CSR,#0X1F 
	bres CLK_PCKENR,#CLK_PCKENR_AWU_BEEP
	bres BEEP_PORT+GPIO_DDR,#BEEP_BIT 
	ret 

;------------------------
; suspend execution 
; parameter:
;   X     milliseconds 
;-------------------------
pause:
	bres flags,#FTIMER 
	_strxz timer 
	bset flags,#FTIMER 
	btjt flags,#FTIMER,. 
	ret 


main:
	ldw x,#200 
	call beep
    call oled_init 
    ld a,#SMALL  
    call select_font 
;    call display_clear 
jp blink_led 
1$: 
    ldw y,#hello
    call put_string 
	ld a,#10 
	call pause 
	jra 1$ 

hello: .asciz "HELLO WORLD!\n"



blink_led:
	_Led_toggle 
	ldw x,#100
	call pause 
	jra blink_led  
