;;
; Copyright Jacques Deschênes 2023  
; This file is part of stm8_i2c 
;
;     stm8_i2c is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8_i2c is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with stm8_i2c.  If not, see <http://www.gnu.org/licenses/>.
;;


    .area CODE 
;-------------------------------------
;    I2C macros 
;-------------------------------------
    .macro _i2c_stop 
    bset I2C_CR2,#I2C_CR2_STOP
    .endm 

;--------------------------------
;  I2C peripheral driver 
;  Support only 7 bit addressing 
;  and master mode 
;--------------------------------

I2C_STATUS_DONE=7 ; bit 7 of i2c_status indicate operation completed  
I2C_STATUS_NO_STOP=6 ; don't send a stop at end of transmission


;------------------------------
; i2c global interrupt handler
;------------------------------
I2cIntHandler:
    ld a, I2C_SR2 ; errors status 
    clr I2C_SR2 
    and a,#15 
    jreq 1$
    ld (2,sp),a 
    ldw x,#i2c_error 
    ldw (8,sp),x ; change return addr for i2c_error
    iret 
1$: ; no error detected 
    btjf i2c_status,#I2C_STATUS_DONE,2$
    clr I2C_ITR 
    iret 
; handle events 
2$: 
    clrw x 
    _ldaz i2c_idx  
    ld xl,a 
    btjt I2C_SR1,#I2C_SR1_SB,evt_sb 
    btjt I2C_SR1,#I2C_SR1_ADDR,evt_addr 
    btjt I2C_SR1,#I2C_SR1_BTF,evt_btf  
    btjt I2C_SR1,#I2C_SR1_TXE,evt_txe 
    btjt I2C_SR1,#I2C_SR1_RXNE,evt_rxne 
    btjt I2C_SR1,#I2C_SR1_STOPF,evt_stopf 
    iret 

evt_sb: ; EV5  start bit sent 
    _ldaz i2c_devid
    ld I2C_DR,a ; send device address 
    iret 

evt_addr: ; EV6  address sent, send data bytes  
    btjt I2C_SR3,#I2C_SR3_TRA,evt_txe
    iret 

; master transmit mode 
evt_txe: ; EV8  send data byte 
    tnz i2c_count 
    jreq end_of_tx 
evt_txe_1:
    ld a,([i2c_buf],x)
    ld I2C_DR,a
    inc i2c_idx  
    dec i2c_count  
1$: iret 

; only append if no STOP send 
evt_btf: 
    btjf I2C_SR3,#I2C_SR3_TRA,#evt_rxne  
    tnz i2c_count 
    jrne evt_txe_1 

; end of transmission
end_of_tx:
    bset i2c_status,#I2C_STATUS_DONE  
    btjt i2c_status,#I2C_STATUS_NO_STOP,1$
    bset I2C_CR2,#I2C_CR2_STOP
1$: clr I2C_ITR
    iret 

; master receive mode 
evt_rxne: 
    tnz i2c_count 
    jreq evt_stopf  
1$: ld a,I2C_DR 
    ld ([i2c_buf],x),a  
    inc i2c_idx  
    dec i2c_count 
    jrne 4$
    bres I2C_CR2,#I2C_CR2_ACK
4$: iret 

evt_stopf:
    ld a,I2C_DR 
    ld ([i2c_buf],x),a 
    bset I2C_CR2,#I2C_CR2_STOP
    bset i2c_status,#I2C_STATUS_DONE
    clr I2C_ITR 
    iret  


; error message 
I2C_ERR_NONE=0 
I2C_ERR_NO_ACK=1 ; no ack received 
I2C_ERR_OVR=2 ; overrun 
I2C_ERR_ARLO=3 ; arbitration lost 
I2C_ERR_BERR=4 ; bus error 
I2C_ERR_TIMEOUT=5 ; operation time out 
;--------------------------- 
; blink error code {0..15} 
; on LED in binary format 
; most significant bit first 
; 0 -> SHORT_BLINK, LED on 
; 1 -> 3xSHORT_BLINK, LED on 
; space -> SHORT_BLINK LED off 
; inter code -> 5xSHORT_BLINK LED off
;---------------------------
SHORT_BLINK=150

    CODE=1
    SHIFT=2
    CNT=3
    VAR_SIZE=3
i2c_error:
    _vars VAR_SIZE 
    swap a
    ld (CODE,sp),a 
code_loop: 
    ld a,(CODE,sp)
    ld (SHIFT,sp),a 
    ld a,#4 
    ld (CNT,sp),a
nibble_loop:     
    sll (SHIFT,sp)  
    jrc blink1 
blink0:
    ldw x,#SHORT_BLINK 
    jra blink
blink1: 
    ldw x,#3*SHORT_BLINK 
blink:
    _led_on 
    call pause 
    _led_off
    ldw x,#SHORT_BLINK
    call pause  
    dec (CNT,sp)
    jrne nibble_loop 
    ldw x,#6*SHORT_BLINK
    call pause 
    jra code_loop
    _drop VAR_SIZE    
    ret  

;-------------------------------
; set I2C SCL frequency
; parameter:
;    A    {I2C_STD,I2C_FAST}
;-------------------------------
i2c_scl_freq:
	bres I2C_CR1,#I2C_CR1_PE 
	cp a,#I2C_STD 
	jrne fast
std:
	mov I2C_CCRH,#I2C_CCRH_16MHZ_STD_100 
	mov I2C_CCRL,#I2C_CCRL_16MHZ_STD_100
	mov I2C_TRISER,#I2C_TRISER_16MHZ_STD_100
	jra i2c_scl_freq_exit 
fast:
	mov I2C_CCRH,#I2C_CCRH_16MHZ_FAST_400 
	mov I2C_CCRL,#I2C_CCRL_16MHZ_FAST_400
	mov I2C_TRISER,#I2C_TRISER_16MHZ_FAST_400
i2c_scl_freq_exit:
	ret 

;-------------------------------
; initialize I2C peripheral 
; parameter:
;    A    {I2C_STD,I2C_FAST}
;-------------------------------
i2c_init:
; set SDA and SCL pins as OD output 
	bres I2C_PORT+GPIO_CR1,#SDA_BIT 
	bres I2C_PORT+GPIO_CR1,#SCL_BIT
    bres I2C_PORT+GPIO_DDR,#SDA_BIT 
    bres I2C_PORT+GPIO_DDR,#SCL_BIT 
; set I2C peripheral 
	bset CLK_PCKENR,#CLK_PCKENR_I2C 
	clr I2C_CR1 
	clr I2C_CR2 
    mov I2C_FREQR,#FMSTR ; peripheral clock frequency 
	callr i2c_scl_freq
	bset I2C_CR1,#I2C_CR1_PE ; enable peripheral 
	_clrz i2c_status 
    ret 


;-----------------------------
; send start bit and device id 
; paramenter:
;     A      device_id, 
; 			 b0=1 -> transmit
;			 b0=0 -> receive 
;----------------------------- 
i2c_start:
    btjt I2C_SR3,#I2C_SR3_BUSY,.
	bset I2C_CR2,#I2C_CR2_START 
	btjf I2C_SR1,#I2C_SR1_SB,. 
	ld I2C_DR,a 
	btjf I2C_SR1,#I2C_SR1_ADDR,. 
	ret 


;--------------------------------
; write bytes to i2c device 
; devid:  device identifier 
; count: of bytes to write 
; buf_addr: address of bytes buffer 
; no_stop: dont't send a stop
;---------------------------------
i2c_write:
    btjt I2C_SR3,#I2C_SR3_MSL,. 
    _clrz i2c_idx 
    ld a,#(1<<I2C_ITR_ITBUFEN)|(1<<I2C_ITR_ITERREN)|(1<<I2C_ITR_ITEVTEN) 
    ld I2C_ITR,a 
    ldw x,#100
    _strxz timer 
    bset flags,#FTIMER 
    ld a,#(1<<I2C_CR2_START)|(1<<I2C_CR2_ACK)
    ld I2C_CR2,a 
1$:
    btjt flags,#FTIMER,2$ 
    ld a,#I2C_ERR_TIMEOUT 
    jp i2c_error 
2$: btjf i2c_status,#I2C_STATUS_DONE,1$
    _clrz i2c_status  
9$:
    ret 

