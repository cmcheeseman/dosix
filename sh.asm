%include "defs.asm"
[org 0x8a00]

mov ah, setmainprog
mov bx, shstr
call kloc

mov ah, zerobuffer
mov bx, buff
mov ch, 75
call kloc

loop:
  mov ah, 0x0e
  mov al, 0xA
  int 10h
  mov al, 0xD
  int 10h

  mov ah, printf
  mov bx, prompt
  call kloc

  mov ah, readstr
  mov bx, buff
  mov cx, 75
  call kloc

  mov ah, strcmp
  mov bx, buff
  mov ch, 75
  mov si, clearstr
  call kloc

  cmp ah, 0
  je clear

  mov ah, strcmp
  mov bx, buff
  mov ch, 75
  mov si, lsstr
  call kloc

  cmp ah, 0
  je ls

  mov bx, buff
  mov ah, BYTE [bx]
  cmp ah, 0
  je end

  mov ah, loadprog
  mov si, buff
  jmp kloc

end:
  mov ah, zerobuffer
  mov bx, buff
  mov ch, 75
  call kloc
  mov ah, 0x0e
  mov al, 0xA
  int 10h
  mov al, 0xD
  int 10h
  jmp loop

jmp $

clear:
  mov ah, clearscreen
  call kloc
  jmp clearbuff

ls:
  mov ah, listfs
  call kloc
  jmp clearbuff

clearbuff:
  mov ah, zerobuffer
  mov bx, buff
  mov ch, 75
  call kloc
  jmp loop


prompt: db "$ ", 0
clearstr: db "clear", 0
lsstr: db "ls", 0
shstr: db "sh", 0, 0
buff: times 75 db 0
times 512-($-$$) db 0
