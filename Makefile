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

clean:
	rm boot kern fs prog os.bin
