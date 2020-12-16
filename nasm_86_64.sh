#!/bin/sh

nasm -f elf64 $1.asm
ld -m elf_x86_64 -s -o $1 $1.o
