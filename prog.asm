%include "defs.asm"
[org 0x8a00]
[bits 16]

mov ah, clearscreen
call kloc


jmp start
str1: db "welcome to DOSIX", 10, 0
str2: db 10, "please login > ", 0
buff: times 5 db 0
pass: db "hello"
gudjob: db 10, "you did it! :)", 0
sh: db "sh", 0, 0
start:

mov ah, printf
mov bx, str1
call kloc

loop:

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
mov si, pass
call kloc

cmp ah, 0
je end
jmp loop
end:
mov ah, loadprog
mov si, sh
jmp kloc
jmp $
times 512-($-$$) db 0
