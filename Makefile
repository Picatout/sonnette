#############################
# stm8s001j3m experiment
#############################
MCU=stm8l001j3
PROGRAMMER=stlinkv2
FLASH_SIZE=8192
BUILD_DIR=build/
MCU_INC=inc/stm8l001j3.inc
NAME=doorbell
AS=sdasstm8
CC=sdcc
SDAR=sdar
LINK=sdld
OBJCPY=objcpy 
CFLAGS=-mstm8 -lstm8 -L$(LIB_PATH) -I../inc
INC=inc/
INCLUDES=$(MCU_INC) $(INC)gen_macros.inc $(INC)app_macros.inc
SRC=$(NAME).asm
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

flash: $(LIB)
	#
	# "******************"
	# "flashing $(MCU) "
	# "******************"
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -w $(BUILD_DIR)$(NAME).bin  

# read flash memory 
read: 
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -b 8192 -r flash.dat 

# erase flash memory
erase:
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -w zero.bin 

