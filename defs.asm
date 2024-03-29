


; memory locations
kloc: equ 0x7e00
userloc: equ 0x8a00
fdt: equ 0x8200
fileloc: equ 0x9a00

; kernel functions

; it's printf
printf: equ 0x01

; prints a string with a fixed size. does not have formaterss
printfs: equ 0x02

; compare strings in bx and si, size is stored in ch, returns 0 in al if strings are the same
strcmp: equ 0x03

; read string from keyboard
readstr: equ 0x04

; load program from disk
loadprog: equ 0x05

; clears the screen
clearscreen: equ 0x06

; sets all bytes in a buffer to zero
zerobuffer: equ 0x07

; lists all items in the fdt
listfs: equ 0x08

; sets default program to return to
setmainprog: equ 0x09

; returns to main program
retmain: equ 0x0A
