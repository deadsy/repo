
# cross compilation tools
XTOOLS_DIR = /opt/gcc-arm-none-eabi-5_4-2016q2
X_LIBC_DIR = $(XTOOLS_DIR)/arm-none-eabi/lib/armv7e-m/fpu
X_LIBGCC_DIR = $(XTOOLS_DIR)/lib/gcc/arm-none-eabi/5.4.1/armv7e-m/fpu
X_CC = $(XTOOLS_DIR)/bin/arm-none-eabi-gcc
X_OBJCOPY = $(XTOOLS_DIR)/bin/arm-none-eabi-objcopy
X_AR = $(XTOOLS_DIR)/bin/arm-none-eabi-ar
X_LD = $(XTOOLS_DIR)/bin/arm-none-eabi-ld
X_GDB = $(XTOOLS_DIR)/bin/arm-none-eabi-gdb

OUTPUT = poos

# source

SRC = ./sdk/src/startup_efm32lg.c \
      ./sdk/src/system_efm32lg.c \
      ./src/main.c \
      ./src/lcd.c \

OBJ = $(patsubst %.c, %.o, $(SRC))

# include files
INC = ./cmsis/inc
INC += ./sdk/inc
INC += ./src

INCLUDE = $(addprefix -I,$(INC))

# compiler flags
CFLAGS = -Wall -Wstrict-prototypes -Werror
CFLAGS += -O
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3 -mthumb-interwork
#CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

# linker flags
LDSCRIPT = efm32lg.ld
LDFLAGS = -T$(LDSCRIPT) -Wl,-Map,$(OUTPUT).map -Wl,--gc-sections

# defines
DEFINES = -DEFM32LG890F128
#DEFINES += -DTARGET_rhythm
#DEFINES += -DTARGET_sub
#DEFINES += -DTARGET_factory
DEFINES += -DTARGET_arcade
#DEFINES += -DTARGET_office
#DEFINES += -DTARGET_robot

.S.o:
	$(X_CC) $(INCLUDE) $(DEFINES) $(CFLAGS) -c $< -o $@
.c.o:
	$(X_CC) $(INCLUDE) $(DEFINES) $(CFLAGS) -c $< -o $@

.PHONY: all program clean

all: $(OBJ)
	$(X_CC) $(CFLAGS) $(LDFLAGS) $(OBJ) -lm -o $(OUTPUT)
	$(X_OBJCOPY) -O binary $(OUTPUT) $(OUTPUT).bin

program: 
	st-flash write $(OUTPUT).bin 0x08000000

clean:
	-rm $(OBJ)	
	-rm $(OUTPUT)
	-rm $(OUTPUT).map	
	-rm $(OUTPUT).bin	
