
.386
.model flat, c

switch_jmp_32to64 PROTO

.code

ctx_switch_jmpf proc
;; 32-bit mode
	nop 
	db 0eah ;jmp far
	;dd 10000000h
	db 00h, 00, 00, 10h; address
	db 033h, 00
	;address
	ret
ctx_switch_jmpf endp

ctx_switch_retf proc
;; 32-bit mode
	push 033h
	call n1
n1:
	add dword ptr[esp], 5
	retf

;; 64-bit mode
	db 48h, 8Bh, 0C0h

    nop
    nop
    nop
    push 23h
	call n2
n2:
	; add dword ptr[rsp], Dh
	db 83h, 04h, 24h, 0Dh
	mov dword ptr[esp+4], 23h
    retf

;; 32-bit mode
	xor eax, eax
	mov edi, edi
	nop

    ret
ctx_switch_retf endp

ctx_switch_iretf proc
	mov edx, esp

;; 32-bit mode
	push 2Bh ; ss
	push esp ; stack
	push 46h ; eflag
	push 33h ; cs
	call n1
n1:
	add dword ptr[esp], 5 ; eip
	iretd

;; 64-bit mode
	db 48h, 8Bh, 0C0h
	nop
	nop

	;sub rsp, 20h
	db 48h, 83h, 0ECh, 20h

	; --> mov dword ptr[rsp+*], val
	mov dword ptr[esp+8], 02Bh
	mov dword ptr[esp+4], edx
	mov dword ptr[esp], 0046h
	call n2 
n2:
	; add dword ptr[rsp], Dh
	db 83h, 04h, 24h, 0Dh
	mov dword ptr[esp+4], 23h
	iretd

;; 32-bit mode
	xor eax, eax
	mov edi, edi
	nop
ctx_switch_iretf endp


end