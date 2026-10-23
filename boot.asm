[org 0x7c00]

mov ah, 0x0e
mov bx, version

print_version:
    mov al, [bx]
    cmp al, 0
    je input
    int 0x10
    inc bx
    jmp print_version


input:
    mov ah, 0x0e
    mov bx, username
insert:
    mov al, [bx]
    cmp al, 0
    je exec
    int 0x10
    inc bx
    jmp insert

exec:
    jmp end

end:
    jmp $

version:
    db "Zirconium OS version 0.1", 0x0d, 0x0a, 0

username:
    db "@", "user", '>', ' ' , 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa
