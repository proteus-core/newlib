#ifndef MTIMER_H
#define MTIMER_H

#include <stdint.h>

#define MTIME    *(volatile uint64_t*)0xf0001000
#define MTIMECMP *(volatile uint64_t*)0xf0001008

#endif
