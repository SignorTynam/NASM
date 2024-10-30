section .data
  msg db "Hello, World!", 0

section .text
global _start
_start:
  mov eax, 4          ; syscall per sys_write
  mov ebx, 1          ; file descriptor per stdout
  mov ecx, msg        ; messaggio da stampare
  mov edx, 13         ; lunghezza del messaggio
  int 0x80            ; chiamata al kernel
  
  mov eax, 1          ; syscall per sys_exit
  xor ebx, ebx        ; codice di uscita
  int 0x80 