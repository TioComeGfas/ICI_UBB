.model small
.stack
.data
cadena db '$'

.code
.startup

;limpiar pantalla
 mov ah,00h
 mov al,03h
 int 10h
;leo un caracter sin eco
 mov cx,10
 mov si,0
 leer:
 mov ah,07h
 int 21h

 
;lee 10 caracteres y los gurda el cadena

 mov dl,al
 mov ah,02h
 int 21h
 mov cadena[si],al
 inc si
 loop leer
 
;simulando el gotoxy

mov ah,02h
mov dh,10h
mov dl,10h
mov bx,00h
int 10h


mov ah,09h
mov dx,offset[cadena]
int 21h

.exit
end