all: boot kern prog fs sh testprog
	cat boot kern fs prog sh testprog > os.bin

boot: boot.asm
	nasm -fbin boot.asm

kern: kern.asm
	nasm -fbin kern.asm

fs: fs.asm
	nasm -fbin fs.asm

prog: prog.asm
	nasm -fbin prog.asm

sh: sh.asm
	nasm -fbin sh.asm

testprog: testprog.asm
	nasm -fbin testprog.asm

test: all
	qemu-system-x86_64 -drive format=raw,file=os.bin

clean:
	rm boot kern fs prog sh os.bin
