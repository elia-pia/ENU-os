[org 0x7c00]

start:
    xor ax, ax
    mov ds, ax

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
dis_name:
    mov al, [bx]
    cmp al, 0
    je insert
    int 0x10
    inc bx
    jmp dis_name
insert:
    xor ah, ah
    int 0x16
    mov [command], al
    mov ah, 0x0e
    int 0x10
    jmp exec

exec:
    jmp end

end:
    jmp $

version:  db "Zirconium OS version 0.1", 0x0d, 0x0a, 0
username: db "@", "sys", '>', ' ' , 0
command:  db 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa
