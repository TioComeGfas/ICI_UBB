.model small
.stack
.data 

    msg db ' || La edad es: $' 
    msg2 db 'Ingrese la edad: $'
    decena db ?,"$"
    unidad db ?,"$"

.code
.startup
   
   jmp setmsg1
   
   setmsg1:
   mov ax,@data
   mov ds,ax
   lea dx,msg2
   mov ah,9h     
   int 21h
   jmp limpiar
   
   limpiar:
   mov ax,0
   mov dx,0
   jmp leer1
           
   leer1:           
   mov ah,1h
   int 21h  
   mov decena,al
   jmp leer2
            
   leer2:
   mov ah,1h
   int 21h
   mov unidad,al
   jmp setmsg2
            
   setmsg2:         
   lea dx,msg
   mov ah,9h     
   int 21h   
   jmp setval1
   
   setval1:
   lea dx,decena
   mov ah,9h     
   int 21h
   mov ax,0
   mov dx,0
   jmp setval2
   
   setval2:      
   lea dx,unidad
   mov ah,9h     
   int 21h
   jmp salir
   
   salir:
    .exit
    end
   
   
