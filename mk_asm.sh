#!/bin/bash
echo "--- gcc ---"
echo "--- main ---"
riscv32-unknown-elf-gcc -O $1.c -c
riscv32-unknown-elf-gcc -O serial_lib.c -c
echo "--- ld --- "
riscv32-unknown-elf-ld $1.o -nostdlib -Triscy.ld -o $1.bin serial_lib.o
echo "--- objdump ---"
riscv32-unknown-elf-objdump -Mnumeric -d $1.bin > $1.asm
echo "FINISH"