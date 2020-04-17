.MODEL SMALL
.STACK
.DATA
    dato db 10 dup(?)
    msg1 db 'El promedio es: $'
    msg2 db ' El arreglo es: $'

.CODE 
   .startup
   
   lea si,data
   mov cx,10
   
   ;llenado
   Ciclo:
   mov ah,08h
   int 21h
   mov [si],al
   sub al,30h
   add bl,al ;suma el promedio
   inc si
   LOOP Ciclo
   
   ;print msg1
   mov ax,@data
   mov ds,ax
   lea dx,msg1
   mov ah,9h     
   int 21h 
   mov ax,0h
   mov dx,0h
   
   ;imprime el entero
   mov ax,bx
   mov bx,10
   div bl 
   mov dl,al
   add dl,30h
   mov ah,02h
   int 21h

   mov si,0
   lea si,data
   mov cx,10
   
   ;print segundo mensaje
   lea dx,msg2
   mov ah,9h     
   int 21h 
   mov ax,0h
   mov dx,0h  
   
   ;print arreglo
   Ciclo2:
   mov dl,[si]
   inc si
   mov ah,2h
   int 21h
   LOOP Ciclo2
   
   .exit
END