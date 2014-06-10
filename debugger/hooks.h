#ifndef DEBUGGER_HOOKS_H
#define DEBUGGER_HOOKS_H

#include <stdint.h>

#include "asic.h"
#include "cpu.h"

void init_hooks();

typedef struct {
	uint16_t memory_location;
	uint8_t read_byte;
} read_memory_struct_t;

typedef int (*read_memory_hook)(asic_t *, read_memory_struct_t *);
void register_hook_read_memory(read_memory_hook);
void call_read_memory_hooks(asic_t *, read_memory_struct_t *);

typedef struct {
	uint16_t memory_location;
	uint8_t write_byte;
} write_memory_struct_t;

typedef int (*write_memory_hook)(asic_t *, write_memory_struct_t *);
void register_hook_write_memory(write_memory_hook);
void call_write_memory_hooks(asic_t *, write_memory_struct_t *);

enum {
	A, F, AF, _AF,
	B, C, BC, _BC,
	D, E, DE, _DE,
	H, L, HL, _HL,
	PC, SP, I, R,
	IXH, IXL, IX,
	IYH, IYL, IY,
};

typedef struct register_hook_struct {
	uint8_t register_id;
	uint16_t contents;
} register_hook_struct_t;

typedef int (*register_hook)(z80cpu_t *, register_hook_struct_t *);

void register_hook_read_register(register_hook);
void call_read_register_hooks(z80cpu_t *, register_hook_struct_t *);

void register_hook_write_register(register_hook);
void call_write_register_hooks(z80cpu_t *, register_hook_struct_t *);

#endif
