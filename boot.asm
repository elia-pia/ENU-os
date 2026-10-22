mov ah, 0x0e
mov al, 'A'
label:
int 0x10
cmp al, 'Z'
inc al
jb label

jmp $

times 510 - ($ - $$) db 0
db 0x55, 0xaa
