#!/bin/bash
echo "--- gcc ---"
echo "--- main ---"
riscv32-unknown-elf-gcc $1.c -c
echo "--- serial_lib ---"
riscv32-unknown-elf-gcc serial_lib.c -c
echo "--- start_up ---"
riscv32-unknown-elf-gcc startup.s -c
echo "--- ld --- "
riscv32-unknown-elf-ld $1.o serial_lib.o -nostdlib -Triscy.ld -o $1.bin
echo "--- objdump ---"
riscv32-unknown-elf-objdump -Mnumeric -d $1.bin > $1.asm
echo "FINISH"