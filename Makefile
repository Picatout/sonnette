#############################
# TinyBasic make file
#############################
NAME=oled_test
AS=sdasstm8
CC=sdcc
SDAR=sdar
LINK=sdld
OBJCPY=objcpy 
CFLAGS=-mstm8 -lstm8 -L$(LIB_PATH) -I../inc
INC=inc/
INCLUDES=$(MCU_INC) $(INC)gen_macros.inc $(INC)app_macros.inc $(INC)/ssd1306.inc config.inc 
SRC=hardware_init.asm i2c.asm oled_128_64.asm oled-font.asm display.asm xor_prng.asm $(NAME).asm
OBJECT=$(BUILD_DIR)$(NAME).rel
OBJECTS=$(BUILD_DIR)$(SRC:.asm=.rel)
LIST=$(BUILD_DIR)$(NAME).lst
FLASH=stm8flash


.PHONY: all

all: clean 
	#
	# "*************************************"
	# "compiling $(NAME)  for $(MCU)      "
	# "*************************************"
	$(AS) -g -l -o $(BUILD_DIR)$(NAME).rel $(SRC) 
	$(CC) $(CFLAGS) -Wl-u -o $(BUILD_DIR)$(NAME).ihx $(OBJECT) 
	objcopy -Iihex -Obinary  $(BUILD_DIR)$(NAME).ihx $(BUILD_DIR)$(NAME).bin 
	# 
	@ls -l  $(BUILD_DIR)$(NAME).bin 
	# 


.PHONY: clean 
clean:
	#
	# "***************"
	# "cleaning files"
	# "***************"
	-rm -f $(BUILD_DIR)*

separate: clean $(SRC)
	$(AS) -g -l -o $(BUILD_DIR)hardware_init.rel hardware_init.asm  
	$(AS) -g -l -o $(BUILD_DIR)$(NAME).rel $(NAME).asm  
	$(AS) -g -l -o $(BUILD_DIR)i2c.rel i2c.asm  

flash: $(LIB)
	#
	# "******************"
	# "flashing $(MCU) "
	# "******************"
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -w $(BUILD_DIR)$(NAME).ihx 

# read flash memory 
read: 
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -b 16384 -r flash.dat 

 
