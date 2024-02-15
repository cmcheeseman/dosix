%include "defs.asm"
[org 0x8a00]
[bits 16]

jmp start
str1: db "hello!", 10, 0
str2: db "pleas login > ", 0
buff: times 5 db 0
str3: db "hello"
start:

mov ah, printf
mov bx, str1
call kloc

mov ah, printf
mov bx, str2
call kloc

mov ah, readstr
mov bx, buff
mov cx, 5
call kloc

mov ah, strcmp
mov bx, buff
mov ch, 5
mov si, str3
call kloc

cmp ah, 0
je end
jmp start
end:
jmp $
times 512-($-$$) db 0
