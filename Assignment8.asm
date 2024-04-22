section .data
    
    msg db 10,"The Value in the GDTR is :  "
    msg_len equ $-msg
    msg2 db 10,"The value in IDTR is :  "
    msg2_len equ $-msg2
    
    msg3 db 10,"The Value in the LDTR is:  "
    msg3_len equ $-msg3
    msg4 db 10,"The value in TR is :  "
    msg4_len equ $-msg4
    msg5 db 10,"The value in MSW is :  "
    msg5_len equ $-msg5
    protected db 10,"The Protected mode is ON"
    protected_len equ $-protected
    noProtect db 10,"The Protected mode is OFF"
    noProtect_len equ $-noProtect

    space db " "
    

;--------------------------------------------------
section .bss
    
    LDTR resw 1
    GDTR resw 3
    IDTR resw 3
    MSW resw 1
    TR resw 1
    char_ans resb 16
    

;--------------------------------------------------

%macro Read 2
    mov rax,0
    mov rdi,0
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro Print 2
    mov rax,1
    mov rdi,1
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro


%macro Exit 0
    mov rax,60
    mov rdi,0
    syscall
%endmacro


;--------------------------------------------------

section .text
global _start
_start:
	

	SMSW [MSW]
	SGDT [GDTR]
	SIDT [IDTR]
	SLDT [LDTR]
	STR [TR]	

	Print msg,msg_len
	mov ax,[GDTR+4]
	call display
	mov ax,[GDTR+2]
	call display
	mov ax,[GDTR]
	call display

	Print msg2,msg2_len
	mov ax,[IDTR+4]
	call display
	mov ax,[IDTR+2]
	call display
	mov ax,[IDTR]
	call display

	Print msg3,msg3_len
	mov ax,[LDTR]
	call display

	Print msg4,msg4_len
	mov ax,[TR]
	call display

	Print msg5,msg5_len
	mov ax,[MSW]
	call display

	mov ax,[MSW]
	shr ax,1
	jc protectedOn

	Print noProtect,noProtect_len
	jmp end

protectedOn:
	Print protected,protected_len

end:
  	Exit
   	

;--------------------------------------------------

display:
    mov rbx,16
    mov rcx,16
    mov rsi,char_ans + 15
    
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
    
    Print char_ans,16
    ret
