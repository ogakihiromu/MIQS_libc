.section .text
.global _start

_start:
    lui  x2,0x1FFF0
    call main
