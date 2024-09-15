#ifndef clox_compiler_h
#define clox_compiler_h

#include "object.h"
/* TODO: Vm was included here in the string chapter, but I don't remember when */
#include "vm.h"
#include "chunk.h"

bool compile(const char* source, Chunk* chunk);

#endif /* clox_compiler_h */
