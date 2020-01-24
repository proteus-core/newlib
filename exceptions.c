#include <stdio.h>

void exception(long cause)
{
    long mtval;
    asm("csrr %0, mtval" : "=r"(mtval));

    printf("Exception: %li %lx\n", cause, mtval);
}
