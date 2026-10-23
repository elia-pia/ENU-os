[org 0x7c00]

start:
    mov ax, 0x0600  ;this clears the window
    mov bh, 0x07
    xor cx, cx
    mov dx, 0x184f
    int 0x10
    mov ah, 0x02
    xor bh, bh
    xor dx, dx
    int 0x10

    xor ax, ax   ;preparation to print
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


input:                  ;give the user the a char input
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
    mov ah, 0x0e
    int 0x10
    jmp exec

boot:
    jmp end

dis_options:            ;displays the commands
    mov ah, 0x0e
    mov bx, options
options_print:
    mov al, [bx]
    cmp al, 0
    je input
    inc bx
    int 0x10
    jmp options_print

exec:
    cmp al, 'c'
    je dis_options
    cmp al, 'b'
    je boot
    jmp input

end:
    jmp $

version:
    db "ENU-OS bootloader version 0.1", 0x0d, 0x0a, "press c to display options", 0x0d, 0x0a, 0x0d, 0x0a, 0

options: db  0x0d, 0x0a, "press c to display this message", 0x0d, 0x0a, "press b to boot", 0
username: db 0x0d, 0x0a, "@", "sys", '>', ' ' , 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa
