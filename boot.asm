[org 0x7c00]

    call sclear

start:
    xor ax, ax   ;preparation to print name and version
    mov ds, ax
    mov ah, 0x0e
    mov bx, version
    call print

input:                  ;give the user the a char input
    mov ah, 0x0e
    mov bx, username
    call print
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
    call print
    jmp input

dis_error:            ;displays the command not found error
    mov ah, 0x0e
    mov bx, cmd_error
    call print
    jmp input

exec:
    cmp al, 'o'
    je dis_options
    cmp al, 'b'
    je boot
    cmp al, 'c'
    je sclear
    jne dis_error

end:
    jmp $

print:
    mov al, [bx]
    cmp al, 0
    je out
    inc bx
    int 0x10
    jmp print
    out:
        ret

sclear:
    mov ax, 0x0600  ;this clears the window
    mov bh, 0x07
    xor cx, cx
    mov dx, 0x184f
    int 0x10
    mov ah, 0x02
    xor bh, bh
    xor dx, dx
    int 0x10
    jmp start

version:
    db "ENU-OS bootloader version 0.1", 0x0d, 0x0a, "press o to display options", 0x0d, 0x0a, 0x0d, 0x0a, 0

options:   db 0x0d, 0x0a, "press o to display this message", 0x0d, 0x0a, "press b to boot", 0x0d, 0x0a, "press c to clear the screen", 0
cmd_error: db 0x0d, 0x0a, "command not found", 0
username:  db 0x0d, 0x0a, "@boot> ", 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa
