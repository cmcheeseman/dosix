%include "defs.asm"
[org 0x8a00]
[bits 16]

jmp start
str: db 10, "hello dork!", 10, "have a number: %d", 10, 0
str2: db "abcdef", 0
start:

mov ah, printf
mov bx, str
mov ch, 43
call kloc

mov ah, printfs
mov bx, str2
mov ch, 4
call kloc

mov ah, printf
mov bx, str
mov ch, 57
call kloc

jmp $


times 512-($-$$) db 0
