
main.bin:     file format elf32-littleriscv


Disassembly of section .startup:

00010000 <_start>:
   10000:	1fff0137          	lui	x2,0x1fff0
   10004:	088000ef          	jal	x1,1008c <main>

Disassembly of section .text:

00010008 <Uart_tx_enable>:
   10008:	fe010113          	addi	x2,x2,-32 # 1ffeffe0 <__global_pointer$+0x1ffdf728>
   1000c:	00812e23          	sw	x8,28(x2)
   10010:	02010413          	addi	x8,x2,32
   10014:	ffff07b7          	lui	x15,0xffff0
   10018:	00278793          	addi	x15,x15,2 # ffff0002 <__global_pointer$+0xfffdf74a>
   1001c:	fef42623          	sw	x15,-20(x8)
   10020:	fec42783          	lw	x15,-20(x8)
   10024:	0007a783          	lw	x15,0(x15)
   10028:	0087f793          	andi	x15,x15,8
   1002c:	00078513          	mv	x10,x15
   10030:	01c12403          	lw	x8,28(x2)
   10034:	02010113          	addi	x2,x2,32
   10038:	00008067          	ret

0001003c <Uart_putChar>:
   1003c:	fd010113          	addi	x2,x2,-48
   10040:	02112623          	sw	x1,44(x2)
   10044:	02812423          	sw	x8,40(x2)
   10048:	03010413          	addi	x8,x2,48
   1004c:	00050793          	mv	x15,x10
   10050:	fcf40fa3          	sb	x15,-33(x8)
   10054:	ffff07b7          	lui	x15,0xffff0
   10058:	fef42623          	sw	x15,-20(x8)
   1005c:	00000013          	nop
   10060:	fa9ff0ef          	jal	x1,10008 <Uart_tx_enable>
   10064:	00050793          	mv	x15,x10
   10068:	fe078ce3          	beqz	x15,10060 <Uart_putChar+0x24>
   1006c:	fec42783          	lw	x15,-20(x8)
   10070:	fdf44703          	lbu	x14,-33(x8)
   10074:	00e78023          	sb	x14,0(x15) # ffff0000 <__global_pointer$+0xfffdf748>
   10078:	00000013          	nop
   1007c:	02c12083          	lw	x1,44(x2)
   10080:	02812403          	lw	x8,40(x2)
   10084:	03010113          	addi	x2,x2,48
   10088:	00008067          	ret

0001008c <main>:
   1008c:	ff010113          	addi	x2,x2,-16
   10090:	00112623          	sw	x1,12(x2)
   10094:	00812423          	sw	x8,8(x2)
   10098:	01010413          	addi	x8,x2,16
   1009c:	04800513          	li	x10,72
   100a0:	f9dff0ef          	jal	x1,1003c <Uart_putChar>
   100a4:	00000013          	nop
   100a8:	00c12083          	lw	x1,12(x2)
   100ac:	00812403          	lw	x8,8(x2)
   100b0:	01010113          	addi	x2,x2,16
   100b4:	00008067          	ret
