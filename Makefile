# Makefile for c program
TARGET = main

all:
	./mk_asm.sh $(TARGET)
	./gen_coe.sh $(TARGET)
clean:
	rm $(TARGET).o $(TARGET).bin $(TARGET).asm