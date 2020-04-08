#include <stdio.h>

#include "kernel/mtimer.h"

int main()
{
    printf("Hello, world! It took %llu cycles to boot\n", MTIME);
}
