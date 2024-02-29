[org 0x8a00]
%include "defs.asm"

mov ah, printf
mov bx, teststr
call kloc

mov ah, retmain
jmp kloc

teststr: db 10, "hello dork! :)", 10, 0
times 512-($-$$) db 0
