.model small
.stack
.data 

    msg db 13,10,'La edad es: $'
    decena db ?,"$"
    unidad db ?,"$"

.code
.startup
   
   mov ah,8h
   int 21h  
   mov decena,al
         
   mov ah,8h
   int 21h
   mov unidad,al  
   
   mov ax,@data
   mov ds,ax
           
   lea dx,msg
   mov ah,9h     
   int 21h
   
   lea dx,decena
   mov ah,9h     
   int 21h
   
   mov ax,0
   mov dx,0
      
   lea dx,unidad
   mov ah,9h     
   int 21h
   
   
.exit
end