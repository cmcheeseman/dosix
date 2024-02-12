%include "defs.asm"
[org 0x8a00]
[bits 16]

jmp start
str1: db "testing!", 0
str2: db "testing!", 0
str3: db "testing ", 0
start:

mov ah, strcmp
mov bx, str1
mov ch, 8
mov si, str2
call kloc

cmp ah, 0
je cool
jmp $
cool:
mov ah, strcmp
mov bx, str1
mov ch, 8
mov si, str3
call kloc
cmp ah, 1
je cool2
jmp $

cool2:
  mov ah, printf
  mov bx, str1
  call kloc
  mov ah, printfs
  mov bx, str1
  mov ch, 4
  call kloc

jmp $
times 512-($-$$) db 0
