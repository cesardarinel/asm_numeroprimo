; Autor: Cesar Darinel Ortiz
; Tarea: 3 laboratorio
; Fecha Entrega: 11/10/2018
.model small
.stack 256
.data
; ========================Variables declaradas aquí===============
letrero DB 'INSERTE un numero maximo 4 digitos -->: $'; Cadena a desplegar
text2 DB 'No es par : $'             ; Cadena a desplegar
text DB 'Es par : $'                 ; Cadena a desplegar
text3 DB 'No es Primo : $'           ; Cadena a desplegar
text4 DB 'Es Primo : $'              ; Cadena a desplegar
count dw ?                           ; arreglo de lectura de cadena
primov dw ?                           ; arreglo de lectura de cadena
num dw ?                             ; arreglo de lectura de cadena
a dw 1000                            ; valor para conseguir los miles
b db 100                             ; valor para conseguir los centenas
c db 10                              ; valor para conseguir los decimales
.code
; ========================================================
inicio:
        mov ax,@data
        mov ds,ax
        mov es,ax                    ; set segment register
        and sp,not 3                 ; align stack to avoid AC fault
; ==================Código==================================
reinicio:
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset letrero       ; posición de la cadena a montar
        int 21h                      ; llamó al sistema
        mov bx,00                    ; inicializar en cero
ciclodelectura:
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        sub AL,48                    ;  resto 48 para tenerlo en ASCII
        mul a                        ;  multiplico para agregar los ceros
        mov num,AX                   ;  muevo el valor a la variable num
            
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        sub AL,48                    ;  resto 48 para tenerlo en ASCII
        mul b                        ;  multiplico para agregar los ceros
        mov num,AX                   ;  muevo el valor a la variable num
            
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        sub AL,48                    ;  resto 48 para tenerlo en ASCII
        mul c                        ;  multiplico para agregar los ceros
        mov num,AX                   ;  muevo el valor a la variable num
        
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        sub AL,48                    ;  resto 48 para tenerlo en ASCII
        mov num,AX                   ;  muevo el valor a la variable num
es_par:
        mov count,1                  ; seteo la variable en 1   
        mov primov,0h                 ; seteo la variable en 1               
        call init                    ; seteo en cero 
        mov ax, num                  ; muevo el valor numerando 
        mov bx, 2                    ; muevo el divisor
        div bx                       ; realizo la division 
        cmp dx,0h                    ; comparo el residuo con cero
        jne nopar                    ; si no es cero salto a nopar
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text          ; posición de la cadena a montar
        int 21h                      ; llama al SO
        jmp primo                    ; salto a buscar el numero primo      
nopar:        
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text2         ; posición de la cadena a montar
        int 21h                      ; Llamada al sistema       
init:
        mov dx, 0h                   ;inicializo en cero 
        mov ax, 0h                   ;inicializo en cero 
        mov bx, 0h                   ;inicializo en cero
        mov cl, 0h                   ;inicializo en cero 
        ret
primo:
        call init                    ; seteo en cero 
        mov ax, count                ;
        mov bx, num                  ;
        cmp ax, bx                   ;
        je print                     ;
        call init                    ; seteo en cero 
        mov ax, num                  ;
        mov bx, count                ;
        div bx                       ;
        cmp dx,0h                    ;
        jne continuociclo            ;
        inc primov                   ;
continuociclo:   
        inc count                    ;
        jmp primo                    ;
        
print:
        call init    
        mov ax, primov
        cmp ax,2                    ;
        jne noprimo                 ;
        mov ah,09                   ; Para mostrar en pantalla una cadena
        mov dx, offset text4        ; posición de la cadena a montar
        int 21h                     ;
        jmp Salida                  ; Llamada al sistema        
 noprimo:        
        mov ah,09                   ; Para mostrar en pantalla una cadena
        mov dx, offset text3        ; posición de la cadena a montar
        int 21h                     ; Llamada al sistema  
; ********************************************************************
Salida:
    
; ========================================================
.exit
end inicio
