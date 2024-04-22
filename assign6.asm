section .data
 ; non overlapped data transfer
 sblock db 10h,20h,30h,40h,50h,60h,70h
 dblock times 7 db 0

msg db 10,"Source Block is: "
msg_len equ $-msg

msg1 db 10,"Destination Block is: "
msg1_len equ $-msg1

msg2 db 10,"After transfer "
msg2_len equ $-msg2

space db " "


section .bss
    char_ans resb 2


%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro exit 0      
    mov rax, 60
    xor rdi, rdi
    syscall
%endmacro

section .text
    global _start

_start:

print msg,msg_len
mov rsi,sblock
call block_display

print msg1,msg1_len
mov rsi,dblock
call block_display

call block_transfer
print msg2,msg2_len

print msg,msg_len
mov rsi,sblock
call block_display

print msg1,msg1_len
mov rsi,dblock
call block_display

exit

block_transfer:
    mov rsi, sblock    ; Source pointer
    mov rdi, dblock    ; Destination pointer
    mov rcx, 7         ; Number of bytes to transfer

    back:
        mov al, [rsi]  ; Move byte from source to AL
        mov [rdi], al  ; Move byte from AL to destination

        inc rsi        ; Move source pointer forward
        inc rdi        ; Move destination pointer forward

        dec rcx        ; Decrement counter
        jnz back       ; Continue until all bytes are transferred

    ret

;---------------------------------
;to display each element 
;use stack to resolve conflicts inn registers
block_display:
    mov rbp,7

    next_digit:
        mov al,[rsi]
        push rsi
        call display
        print space,1
        pop rsi
        inc rsi

        dec rbp
        jnz next_digit
    ret

;---------------------------------------
display:
    mov rbx, 16                  
    mov rcx, 2                   
    mov rsi, char_ans + 1      
                              

    display_back:               
        mov rdx, 0
        div rbx                  
        cmp dl, 09h                
        jbe add30
        add dl, 07h                 

    add30:
        add dl, 30h  
        mov [rsi], dl  
        dec rsi      
        dec rcx      
        jnz display_back  


    print char_ans, 2
    ret
