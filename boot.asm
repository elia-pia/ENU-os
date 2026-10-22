[org 0x7c00]

mov ah, 0x0e
mov bx, version

print_version:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp print_version

end:
    jmp $

version:
    db "Zirconium OS version 0.1", 0x0d, 0x0a, 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa
