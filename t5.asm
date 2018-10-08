; Autor: Cesar Darinel Ortiz
; Tarea: 3 laboratorio
; Fecha Entrega: 11/10/2018

.model small
.stack 256
.data
; ========================Variables declaradas aquí===============
letrero DB 'INSERTE un numero maximo 4 digitos -->: $'
arregloConDatos db 5 dup (0)           ; buffer de lectura de cadena
.code
; ========================================================
inicio:
           mov ax,@data
           mov ds,ax
           mov es,ax                    ; set segment register
           and sp,not 3                 ; align stack to avoid AC fault
; ==================Código==================================
           mov ah,09                    ; Para mostrar en pantalla una cadena
           mov dx, offset letrero       ; posición de la cadena a montar
           int 21h                      ; llamó al sistema

           mov bx,00                    ; inicializar en cero
ciclodelectura:
           mov ah,01                    ; para lectura de teclado.
           int 21h                      ; llamada al SO
           cmp al,13                    ; verificar si se pulsa el Enter.
           je Salida                    ; saltamos a solicitar el caracter si presiona enter
           mov arregloConDatos[bx],al   ; copiar el carácter tomado en el buffer.
           cmp bx,4                     ; verificó si debo de salir.
           je Salida                    ; si escribimos más de 50 caracteres dejo de leer
           inc bx                       ; apuntó a la sgte. posición del buffer.
           jmp ciclodelectura           ; continuó leyendo
; ********************************************************************
Salida:
; ========================================================
.exit
end inicio
