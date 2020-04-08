TOOLCHAIN_PREFIX = riscv32-unknown-elf
CC = $(TOOLCHAIN_PREFIX)-gcc
OBJDUMP = $(TOOLCHAIN_PREFIX)-objdump
OBJCOPY = $(TOOLCHAIN_PREFIX)-objcopy
AR = $(TOOLCHAIN_PREFIX)-ar

CFLAGS = -Wall -O2
ASFLAGS = $(CFLAGS)

KERNEL_OBJECTS = kernel/boot.o kernel/trap.o kernel/syscalls.o kernel/interrupts.o kernel/exceptions.o
KERNEL_LIB = kernel.a

MAIN_OBJECTS = main.o
MAIN_EXE = main.elf

all: main.ihex main.bin

$(KERNEL_LIB): $(KERNEL_OBJECTS)
	$(AR) rcs $@ $^

%.elf: %.o $(KERNEL_LIB)
	$(CC) $(CFLAGS) -T link.ld -o $@ $^

%.ihex: %.elf
	$(OBJCOPY) -O ihex $^ $@

%.bin: %.elf
	$(OBJCOPY) -O binary $^ $@

dump: main.elf
	$(OBJDUMP) -d $<

clean:
	rm -f $(KERNEL_OBJECTS) $(KERNEL_LIB) $(MAIN_OBJECTS) $(MAIN_EXE) main.ihex main.bin
