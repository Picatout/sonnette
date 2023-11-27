;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;-----------------------
;  version  
;  information 
;-----------------------
	MAJOR=1
	MINOR=0
	REV=0

; master clock frequency in Mhz 
	FMSTR=16 

; LED ON pin 5 
; LED port 
	LED_PORT =PD 
	LED_BIT = PIN0  

; beep on pin 1 
	BEEP_PORT = PA 
	BEEP_BIT = PIN0 

; I2C port on pin 7,8 
	I2C_PORT=PC 
	SDA_BIT=0
	SCL_BIT=1

; OLED display buffer size 
DISPLAY_BUFFER_SIZE=128 ; horz pixels   
; OLED i2c device ID 
OLED_DEVID=0x78

	.include "inc/ascii.inc" 
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 
    .include "inc/stm8l001j3.inc"
	.include "inc/ssd1306.inc" 



