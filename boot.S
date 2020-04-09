#include "chardev.h"

    .section .boot
    .globl _boot
_boot:
    .option push
    .option norelax
    la sp, _stack_start
    .option pop

    jal _init_traps
    jal _start

    .globl _halt
_halt:
    li x1, CHARDEV_ADDR
    li x2, CHARDEV_EOT
    sb x2, 0(x1)
1:
    j 1b

    .data
_stack_end:
    .zero 10240
_stack_start:
