.model small
.stack
.data 

 msg db 'La edad es: ',0AH,0DH,'$'
 ;var1 dw 20

.code
.startup
    ;lectura de primer numero
    mov ah,1h
    int 21h  
    sub al,30h   
    mov ah,10
    mul ah
    mov bh,al
          
    ;lectura de segundo numero
    mov ah,1h
    int 21h
    sub al,30h
    mov bl,al
    
    ;sumamos el valor y lo almacenamos
    add bl,bh
    mov bh,0
    mov ah,0
    mov al,0
            
    ;;mov dx, offset msg
    
    mov ah, 2  
    mov dl, bl 
    int 21h  

.exit
end