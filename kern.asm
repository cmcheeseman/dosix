%include "defs.asm"
[org 0x7e00]
[bits 16]

; determine which function to execute
cmp ah, 0xff
je init
cmp ah, 0x01
je printffunc
cmp ah, 0x02
je printfsfunc
cmp ah, 0x03
je strcmpfunc

; backup diskid and start userspace
init:
  call loadinit
  jmp userloc

loadinit:
  mov si, initstr
  mov bx, fdt
loadinitloop:
  mov [bxbuff], bx
  add bx, 4
  mov ch, 4
  call strcmpfunc
  mov bx, [bxbuff]
  cmp ah, 0
  je loadinitend
  mov si, initstr
  add bx, 9
  jmp loadinitloop
loadinitend:
  mov ah, 2
  mov al, [bx + 3]
  mov ch, 0
  mov cl, [bx + 8]
  mov dh, 0
  mov dl, 0x80
  mov bx, userloc
  int 0x13
  ret

; print string
printffunc:
  mov ah, 0x0e
printfloop:
  mov al, [bx]
  cmp al, 0
  je printfend
  cmp al, '%'
  je printfformat
  cmp al, 10
  je printfnewline
  int 10h
printfdone:
  inc bx
  jmp printfloop

;return from printf
printfend:
  ret

;print a newline
printfnewline:
  mov al, 0xA
  int 10h
  mov al, 0xD
  int 10h
  je printfdone

; process formatters
printfformat:
  inc bx
  mov al, [bx]
  cmp al, 'c'
  je printchar
  cmp al, 'd'
  je printint
  jmp printfdone

; print a charachter in ch
printchar:
  mov al, ch
  int 10h
  je printfdone

; print an integer

; set up loop
printint:
  cmp ch, 10
  jl printintsmall
  mov cl, 0
printintloop:
  cmp ch, 10
  mov al, '1'
  je printintend
  cmp ch, 20
  mov al, '2'
  je printintend
  cmp ch, 30
  mov al, '3'
  je printintend
  cmp ch, 40
  mov al, '4'
  je printintend
  cmp ch, 50
  mov al, '5'
  je printintend
  cmp ch, 60
  mov al, '6'
  je printintend
  cmp ch, 70
  mov al, '7'
  je printintend
  cmp ch, 80
  mov al, '8'
  je printintend
  cmp ch, 90
  mov al, '9'
  je printintend
  dec ch
  inc cl
  jmp printintloop
printintend:
; print final result
  mov ah, 0x0e
  int 10h
  mov al, cl
  add al, '0'
  int 10h
  mov ah, 0x0e
  jmp printfdone
printintsmall:
  mov al, ch
  mov ah, 0x0e
  add al, '0'
  int 10h
  jmp printfdone

; prints a string with a fixed size
printfsfunc:
  mov ah, 0x0e
printfsloop:
  cmp ch, 0
  je printfsend
  mov al, [bx]
  cmp al, 0
  je printfsend
  int 10h
  dec ch
  inc bx
  jmp printfsloop
printfsend:
  ret

; compares 2 strings, uses dx
strcmpfunc:
  cmp ch, 0
  je strcmpsame
  mov dh, [bx]
  mov dl, [si]
  cmp dh, dl
  jne strcmpnotsame
  inc bx
  inc si
  dec ch
  jmp strcmpfunc
strcmpsame:
  mov ah, 0
  ret
strcmpnotsame:
  mov ah, 1
  ret

bxbuff: dw 0
sibuff: dw 0
fmt: db "%d", 10, 0
initstr: db "init"
times 1024-($-$$) db 0
  

