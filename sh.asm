%include "defs.asm"
[org 0x8a00]

mov ah, clearscreen
call kloc

mov ah, printf
mov bx, welcome
call kloc
loop:
  mov ah, printf
  mov bx, prompt
  call kloc

  mov ah, readstr
  mov bx, buff
  mov ch, 75
  call kloc

  mov ah, strcmp
  mov bx, buff
  mov ch, 75
  mov si, clearstr
  call kloc

  cmp ah, 0
  je clear
  mov ah, zerobuffer
  mov bx, buff
  mov ch, 75
  call kloc
  jmp loop

jmp $

clear:
  mov ah, clearscreen
  call kloc
  mov ah, zerobuffer
  mov bx, buff
  mov ch, 75
  call kloc
  jmp loop

welcome: db "login succesful!", 10, 0
prompt: db 10, "$ ", 0
clearstr: db "clear", 0
buff: times 75 db 0
times 512-($-$$) db 0
