section .data
 ;  overlapped data transfer
 sblock db 11h,12h,13h,14h,15h
 dblock times 5 db 0

msg db 10,"Source Block is: "
msg_len equ $-msg

msg1 db 10,"Destination Block is: "
msg1_len equ $-msg1

msg2 db 10,"After transfer "
msg2_len equ $-msg2

space db " "

;---------------------------------------------
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
;---------------------------------------------------------
section .text
    global _start

_start:

print msg,msg_len
mov rsi,sblock
call block_display

print msg1,msg1_len
mov rsi,dblock-2
call block_display

call block_transfer
print msg2,msg2_len

print msg,msg_len
mov rsi,sblock
call block_display

print msg1,msg1_len
mov rsi,dblock-2
call block_display

exit
;-----------------------------------------------------
block_transfer:
    mov rsi, sblock+4    ; Source pointer
    mov rdi, dblock+2    ; Destination pointer
    mov rcx, 5        ; Number of bytes to transfer

    back:
       std        ;set df and dec rsi and rdi
       rep movsb
    ret

;-----------------------------------------------------
;to display each element 
;use stack to resolve conflicts inn registers
block_display:
    mov rbp,5

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

;-----------------------------------------------------
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
