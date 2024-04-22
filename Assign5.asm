section .data
 nline db 10,10
nline_len equ $-nline
 ano db 10, "Assignment no :4",
db 10,"---",
db 10, "Assignment Name: Conversion  and BCD to HEX N",
db 10,"----"
 ano_len equ $-ano

 bmsg db 10, "Enter 5 digit BCD Number::"
 bmsg_len equ $-bmsg
 ehmsg db 10, "The Equivalent Hex Number is::"
 ehmsg_len equ $-ehmsg

 section .bss
 buf resb 6
 char_ans resb 4
 ans resw 1


%macro Print 2

 MOV RAX, 1
 MOV RDI, 1

MOV RSI, %1
MOV RDX, %2
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
Print nline,nline_len     
    mov RAX, 60
    xor RDI ,0
    syscall
%endmacro

section .text
global _start

_start:

 Print ano, ano_len

 BCD_HEX:

  Print bmsg, bmsg_len
  read buf,6 
  mov rsi, buf 
  xor ax, ax 
  mov rbp, 5
  mov rbx, 10 
next: 
  xor cx,cx 
  mul bx 
  mov cl, [rsi]
  sub cl, 30h
  add ax, cx

  inc rsi 
  dec rbp
  jnz next
  mov [ans], ax 

  Print ehmsg, ehmsg_len

  mov  ax,[ans]
  call Disp_16

  exit
  

Disp_16:


MOV RBX, 16
MOV RCX, 4
MOV RSI, char_ans+3

 next_digit:
  XOR RDX,RDX
  DIV RBX
  CMP DL, 9
  JBE add30
  ADD DL, 07H

 add30:
 ADD DL, 30H
 MOV [RSI], DL
 DEC RSI
 DEC RCX
 JNZ next_digit


Print char_ans,4
ret

