.model small
.stack
.data 
    
    msgIF db " la edad es mayor o igual a 18 anios $"
    msgELSE db " la edad es menor a 18 anios$"
    msgEQUAL db " la edad es igual a 18 anios$"
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
   
   cmp decena,10
   ja verificar 
   jb else 
       
verificar:
   cmp unidad,8
   ja if
   jb else
   
if:
   lea dx,msgIF
   mov ah,9h     
   int 21h
   jmp salir
   
   
else:
   lea dx,msgELSE
   mov ah,9h     
   int 21h
   jmp salir 
   
equals:
   lea dx,msgELSE
   mov ah,9h     
   int 21h
   jmp salir
   

salir:
  .exit
   end
   
   
.exit
end