.section .text
.global _start

_start:
    lui  x2,0x00050
    call main

loop:
    jal x0,loop
