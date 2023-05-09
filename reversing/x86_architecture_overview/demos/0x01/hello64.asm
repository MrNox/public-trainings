; nasm -f elf64 hello64.asm -o hello64.o
; ld hello64.o -o hello64

	section .data
	msg db "Hello, World!", 0xa
	len equ $ - msg

	section .text
	global _start

_start:
	mov rdi, 1
	mov rsi, msg
	mov rdx, len
	mov rax, 1
	syscall

	xor rdx, rdx
	mov rax, 0x3C
	syscall
