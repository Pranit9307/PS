section .data

array dq -1h, 74h, 23h, -5h, 20h
n equ 5

pmsg db 10, " +ve count:"
pmsg_len equ $ - pmsg

nmsg db 10, " -ve count:"
nmsg_len equ $ - nmsg

section .bss
p_count resb 8  
n_count resb 8
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
    mov rsi, array
    mov rcx, n

    mov rbx, 0      
    mov rdx, 0           

back_loop:
    mov rax, [rsi]
    bt rax, 63  ; to get msb
    jc negative   
                
positive:
    inc rbx
    jmp next

negative:
    inc rdx

next:
    add rsi, 8
    dec rcx
    jnz back_loop   

    mov [p_count], rbx
    mov [n_count], rdx


    print pmsg, pmsg_len

    mov rax, [p_count]
    call display


    print nmsg, nmsg_len
 
    mov rax, [n_count]
    call display


    exit

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
