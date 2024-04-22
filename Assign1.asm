section .data
af dQ 10, "------------Enter Student  Details---------------", 10
af_len equ $-af
ano db 10, "Enter name ",10
ano_len  equ $-ano
msg db 10,"Enter Address",10
msg_len equ $-msg
ark dw 10,"Enter ROLL NUMBER",10
ark_len equ $-ark
ngk dD 10,"Enter mobile Number",10
ngk_len equ  $-ngk
ak dQ 10, "Enter  PRN", 10
ak_len equ $-ak
as dQ 10, "---------------Student  Details----------------", 10
as_len equ $-as

ano1 db 10, "Student name :  "
ano1_len  equ $-ano1
msg1 db 10,"Student Address :"
msg1_len equ $-msg1
ark1 dw 10,"Student ROLL NUMBER : "
ark1_len equ $-ark1
ngk1 dD 10,"Student mobile Number : "
ngk1_len equ  $-ngk1
ak1 dQ 10, "Student  PRN : "
ak1_len equ $-ak1

 


section .bss
  buffer resb 100
  buffer_len equ $-buffer

   buffer1 resb 100
  buffer1_len equ $-buffer1
  
   buffer2 resb 100
  buffer2_len equ $-buffer2

   buffer3 resb 100
  buffer3_len equ $-buffer3
  
   buffer4 resb 100
  buffer4_len equ $-buffer4
  
  
  
%macro read 2
   mov rax,0
   mov rdi,0
   mov rsi,%1
   mov rdx,%2
   syscall
%endmacro

%macro print 2       ; definition of print fuction 
	mov rax , 1
	mov rdi , 1
	mov rsi , %1
	mov rdx , %2
	syscall
%endmacro 


%macro exit 0        ; definition of exit 
	mov rax , 60
	mov rdi , 0
	syscall
%endmacro
	


section .text
	Global _start
	
_start: 

    print af,af_len
    print ano, ano_len
    read buffer,buffer_len
    print msg, msg_len
    read buffer1,buffer1_len
    print ark , ark_len
    read buffer2,buffer2_len
    print ngk, ngk_len
    read buffer3,buffer3_len
    print ak, ak_len 
    read buffer4,buffer4_len


    

   
   

    print as,as_len
    print ano1, ano1_len
    print buffer ,buffer_len
    print msg1, msg1_len
    print buffer1 ,buffer1_len
    print ark1 , ark1_len
    print buffer2 ,buffer2_len
    print ngk1, ngk1_len
    print buffer3 ,buffer3_len
    print ak1, ak1_len 
    print buffer4 ,buffer4_len
   
  

   exit               ; call to exit function 
