section .data
msg db "Assignment 02",10
msg_len equ $-msg
msg1 db "Enter the string: "
msg1_len equ $-msg1
msg2 db 10,"Length of string is: "
msg2_len equ $-msg2

section .bss
buf resb 20
buf_len equ $-buf
count resb 2
char_ans resb 2

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
_start:
print msg,msg_len
print msg1,msg1_len
read buf,buf_len
mov [count],rax
print msg2,msg2_len
mov rax,[count]
call disp64_proc
exit

disp64_proc:
      mov rbx,16
      mov rcx,2
      mov rsi,char_ans+1

      cnt:
      mov rdx,0
      div rbx
      cmp dl,09h
      jbe add30
      add dl,07h

      add30:
      add dl,30h
      mov [rsi],dl
      dec rsi
      dec rcx
      jnz cnt
      print char_ans,2
      ret
