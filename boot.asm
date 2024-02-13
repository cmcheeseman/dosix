%include "defs.asm"
[org 0x7c00]


start:
xor bx, bx
mov es, bx


mov ah, 2
mov al, 6
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0x80
mov bx, kloc
int 0x13

mov ah, 0xff
jmp kloc

times 510-($-$$) db 0

dw 0xaa55
