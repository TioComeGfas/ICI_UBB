.model small
.stack
.data 

    msg db 13,10,'La edad es: $'
    edad db '20 $'

.code
.startup
   
   mov ax,@data
   mov ds,ax
           
   lea dx,msg
   mov ah,9h     
   int 21h
            
   mov dx,0
   mov ax,0
   
   lea dx,edad
   mov ah,9h
   int 21h    
   
.exit
end