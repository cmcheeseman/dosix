


; memory locations
kloc: equ 0x7e00
userloc: equ 0x8a00
fdt: equ 0x8200

; kernel functions

; it's printf
printf: equ 0x01

; prints a string with a fixed size. does not have formaterss
printfs: equ 0x02

; compare strings in bx and si, size is stored in ch, returns 0 in al if strings are the same
strcmp: equ 0x03
