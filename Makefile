#############################
# TinyBasic make file
#############################
NAME=oled_test
SDAS=sdasstm8
SDCC=sdcc
SDAR=sdar
OBJCPY=objcpy 
CFLAGS=-mstm8 -lstm8 -L$(LIB_PATH) -I../inc
INC=inc/
INCLUDES=$(MCU_INC) $(INC)gen_macros.inc $(INC)app_macros.inc $(INC)/ssd1306.inc config.inc 
BUILD=build/
SRC=hardware_init.asm i2c.asm oled_128_64.asm oled-font.asm display.asm $(NAME).asm
OBJECT=$(BUILD)$(NAME).rel
OBJECTS=$(BUILD)$(SRC:.asm=.rel)
LIST=$(BUILD)$(NAME).lst
FLASH=stm8flash


.PHONY: all

all: clean 
	#
	# "*************************************"
	# "compiling $(NAME)  for $(MCU)      "
	# "*************************************"
	$(SDAS) -g -l -o $(BUILD)$(NAME).rel $(SRC) 
	$(SDCC) $(CFLAGS) -Wl-u -o $(BUILD)$(NAME).ihx $(OBJECT) 
	objcopy -Iihex -Obinary  $(BUILD)$(NAME).ihx $(BUILD)$(NAME).bin 
	# 
	@ls -l  $(BUILD)$(NAME).bin 
	# 


.PHONY: clean 
clean:
	#
	# "***************"
	# "cleaning files"
	# "***************"
	rm -f $(BUILD)*

separate: clean $(SRC)
	$(SDAS) -g -l -o $(BUILD)hardware_init.rel hardware_init.asm  
	$(SDAS) -g -l -o $(BUILD)$(NAME).rel $(NAME).asm  
	$(SDAS) -g -l -o $(BUILD)i2c.rel i2c.asm  

flash: $(LIB)
	#
	# "******************"
	# "flashing $(MCU) "
	# "******************"
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -w $(BUILD)$(NAME).ihx 

# read flash memory 
read: 
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -b 16384 -r flash.dat 

 
