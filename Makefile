TOOLCHAIN_PREFIX = riscv32-unknown-elf
CC = $(TOOLCHAIN_PREFIX)-gcc
OBJDUMP = $(TOOLCHAIN_PREFIX)-objdump
OBJCOPY = $(TOOLCHAIN_PREFIX)-objcopy

CFLAGS = -Wall -O2
ASFLAGS = $(CFLAGS)

OBJECTS = boot.o trap.o syscalls.o interrupts.o exceptions.o main.o

all: main.ihex main.bin

main.elf: $(OBJECTS)
	$(CC) $(CFLAGS) -T link.ld -o $@ $^

%.ihex: %.elf
	$(OBJCOPY) -O ihex $^ $@

%.bin: %.elf
	$(OBJCOPY) -O binary $^ $@

dump: main.elf
	$(OBJDUMP) -d $<

clean:
	rm -f $(OBJECTS) main.elf main.ihex main.bin
