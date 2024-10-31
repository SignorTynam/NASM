section .data
    num db 42                ; The number to print
    result db 'Number: ', 0  ; Message string

section .bss
    num_str resb 4           ; Buffer to hold the converted number as a string, including null terminator

section .text
global _start
_start:
    ; Print the message "Number: "
    mov eax, 4               ; syscall sys_write
    mov ebx, 1               ; stdout
    mov ecx, result          ; message
    mov edx, 8               ; length of "Number: "
    int 0x80                 ; syscall

    ; Convert `num` (42) to ASCII string in `num_str`
    mov al, [num]            ; Load the number 42 into al
    mov ecx, num_str         ; Pointer to store converted digits

    ; Extract the tens place
    mov ah, 0
    mov bl, 10               ; Divisor for base-10 conversion
    div bl                   ; Divide ax by 10; quotient in al, remainder in ah
    add al, '0'              ; Convert quotient to ASCII
    mov [ecx], al            ; Store tens digit as ASCII
    inc ecx                  ; Move to the next position

    ; Extract the ones place
    mov al, ah               ; Move remainder to al (ones place)
    add al, '0'              ; Convert to ASCII
    mov [ecx], al            ; Store ones digit as ASCII
    inc ecx
    mov byte [ecx], 0        ; Null terminator for string

    ; Print the converted number
    mov eax, 4               ; syscall sys_write
    mov ebx, 1               ; stdout
    mov ecx, num_str         ; Pointer to ASCII string
    mov edx, 2               ; Length of "42" (2 characters)
    int 0x80                 ; syscall

    ; Terminate the program
    mov eax, 1               ; syscall sys_exit
    xor ebx, ebx             ; return 0
    int 0x80
