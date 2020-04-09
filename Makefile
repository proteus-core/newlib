TOOLCHAIN_PREFIX = riscv32-unknown-elf
CC = $(TOOLCHAIN_PREFIX)-gcc
AS = $(TOOLCHAIN_PREFIX)-as
OBJDUMP = $(TOOLCHAIN_PREFIX)-objdump
OBJCOPY = $(TOOLCHAIN_PREFIX)-objcopy
AR = $(TOOLCHAIN_PREFIX)-ar

CFLAGS = -Wall -O2

KERNEL_DIR ?= .
KERNEL_OBJECTS = $(KERNEL_DIR)/boot.o $(KERNEL_DIR)/trap.o $(KERNEL_DIR)/syscalls.o $(KERNEL_DIR)/interrupts.o $(KERNEL_DIR)/exceptions.o
KERNEL_LIB_NAME = kernel.a
KERNEL_LIB = $(KERNEL_DIR)/$(KERNEL_LIB_NAME)
KERNEL_GENERATED_FILES = $(KERNEL_OBJECTS) $(KERNEL_LIB)

$(KERNEL_LIB_NAME): $(KERNEL_LIB)

$(KERNEL_LIB): $(KERNEL_OBJECTS)
	$(AR) rcs $@ $^

%.elf: %.o $(KERNEL_LIB)
	$(CC) $(CFLAGS) -T $(KERNEL_DIR)/link.ld -o $@ $^

%.ihex: %.elf
	$(OBJCOPY) -O ihex $^ $@

%.bin: %.elf
	$(OBJCOPY) -O binary $^ $@
