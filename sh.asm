%include "defs.asm"
[org 0x8a00]

mov ah, clearscreen
call kloc

mov ah, printf
mov bx, welcome
call kloc

jmp $

welcome: db "login succesful!", 10, 10, 0
times 512-($-$$) db 0
