# This file was automagically generated by mbed.org. For more information,
# see http://mbed.org/handbook/Exporting-to-GCC-ARM-Embedded

GCC_BIN =
PROJECT = bootloader
CMSIS_PATH = CDL/CMSIS
SYS_OBJECTS =
INCLUDE_PATHS = -I. -I$(CMSIS_PATH)/include -I$(CMSIS_PATH)
LIBRARY_PATHS =
LIBRARIES =
CMSIS_PATH = ./CDL/CMSISv2p00_LPC17xx
DRIVER_PATH = ./CDL/LPC17xxLib
INCLUDE_PATHS = -I. -I./usbstack/include -I$(DRIVER_PATH)/inc -I$(CMSIS_PATH)/inc
LINKER_SCRIPT = LPC1768.ld

LOCAL_C_SRCS = $(CMSIS_PATH)/src/core_cm3.c $(CMSIS_PATH)/src/system_LPC17xx.c \
			   $(wildcard $(CMSIS_PATH)/source/*.c) $(wildcard *.c) \
			   $(wildcard usbstack/src/*.c)
OBJECTS = $(LOCAL_C_SRCS:.c=.o)

###############################################################################
CC = $(GCC_BIN)arm-none-eabi-gcc
CPP = $(GCC_BIN)arm-none-eabi-g++
CC_FLAGS = -g -ggdb -c -Os -fno-common -fmessage-length=0 -Wall -fno-exceptions -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections
ONLY_C_FLAGS = -std=gnu99
ONLY_CPP_FLAGS = -std=gnu++98
CC_SYMBOLS = -DTARGET_LPC1768 -DTOOLCHAIN_GCC_ARM \
			 -DUSB_DEVICE_ONLY -D__LPC17XX__ -DBOARD=9


AS = $(GCC_BIN)arm-none-eabi-as

LD = $(GCC_BIN)arm-none-eabi-gcc
LD_FLAGS = -mcpu=cortex-m3 -mthumb -Wl,--gc-sections
LD_SYS_LIBS = -lstdc++ -lsupc++ -lm -lc -lgcc

OBJCOPY = $(GCC_BIN)arm-none-eabi-objcopy

all: $(PROJECT).bin

clean:
	rm -f $(PROJECT).bin $(PROJECT).elf $(OBJECTS) *.o

.s.o:
	$(AS)  $(CC_FLAGS) $(CC_SYMBOLS) -o $@ $<

.c.o:
	$(CC)  $(CC_FLAGS) $(CC_SYMBOLS) $(ONLY_C_FLAGS)   $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	$(CPP) $(CC_FLAGS) $(CC_SYMBOLS) $(ONLY_CPP_FLAGS) $(INCLUDE_PATHS) -o $@ $<


$(PROJECT).elf: $(OBJECTS) $(SYS_OBJECTS)
	$(LD) $(LD_FLAGS) -T$(LINKER_SCRIPT) $(LIBRARY_PATHS) -o $@ $^ $(LIBRARIES) $(LD_SYS_LIBS) $(LIBRARIES) $(LD_SYS_LIBS)

$(PROJECT).bin: $(PROJECT).elf
	$(OBJCOPY) -O binary $< $@

flash: all
	@openocd -f flash.cfg

gdb: all
	@openocd -f gdb.cfg
