#
# Makefile
#

.SUFFIXES: .asm .p .hex .sr .com

all:	VGM2203.hex m1.hex VGMCPM.com

.p.com:
	p2bin $*.p $*.com

.p.hex:
	p2hex -F Intel $*.p $*.hex

.p.sr:
	p2hex -F Moto $*.p $*.sr

.asm.p:	
	asl -L $*.asm

clean:
	rm -f *.p *.hex *.sr *.lst