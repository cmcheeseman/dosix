all: boot kern prog fs
	cat boot kern fs prog > os.bin

boot: boot.asm
	nasm -fbin boot.asm

kern: kern.asm
	nasm -fbin kern.asm

fs: fs.asm
	nasm -fbin fs.asm

prog: prog.asm
	nasm -fbin prog.asm

test: all
	qemu-system-x86_64 -drive format=raw,file=os.bin

clean:
	rm boot kern fs prog os.bin
