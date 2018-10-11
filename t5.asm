; Autor: Cesar Darinel Ortiz
; Tarea: 3 laboratorio
; Fecha Entrega: 11/10/2018
.model small
.stack 256
.data
; ========================Variables declaradas aquí===============
letrero DB 'INSERTE un numero maximo 4 digitos -->: $'; Cadena a desplegar
text2 DB ' No es par $'             ; Cadena a desplegar
text DB ' Es par $'                 ; Cadena a desplegar
text3 DB ' No es Primo $'           ; Cadena a desplegar
text4 DB ' Es Primo $'              ; Cadena a desplegar
ceros DB ' El numero 0 es un numero neutro y no está considerado como numero primo. $'
unos DB ' El numero 1 no está considerado como numero primo. $'
count dw ?                           ; arreglo de lectura de cadena
primov dw ?                          ; arreglo de lectura de cadena
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
        mul a                        ;  multiplico para agregar los ceros
        mov num,AX                   ;  muevo el valor a la variable num
            
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        mul b                        ;  multiplico para agregar los ceros
        mov num,AX                   ;  muevo el valor a la variable num
            
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        mul c                        ;  multiplico para agregar los ceros
        mov num,AX                   ;  muevo el valor a la variable num
        
        mov AH,1                     ;  para lectura de teclado.
        int 21H                      ;  llamada al SO
        mov num,AX                   ;  muevo el valor a la variable num
es_par:
        mov count,1                  ; iniciar la variable en 1   
        mov primov,0h                ; iniciar la variable en 1               
        call init                    ; iniciar en cero 
        mov ax, num                  ; muevo el valor numerando 
        mov bx, 2                    ; muevo el divisor
        div bx                       ; realizo la división 
        cmp dx,0h                    ; comparo el residuo con cero
        jne nopar                    ; si no es cero salto a nopar
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text          ; posición de la cadena a montar
        int 21h                      ; llama al SO
        mov ah,02                    ; para mostrar carácter
        mov dl,10                    ; imprimió el carácter de salto de línea
        int 21h                      ; llamada sistema
        jmp valida                   ; salto a buscar el numero primo      
nopar:        
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text2         ; posición de la cadena a montar
        int 21h                      ; Llamada al sistema  
        mov ah,02                    ; para mostrar carácter
        mov dl,10                    ; imprimió el carácter de salto de línea
        int 21h                      ; llamada sistema
        jmp valida                   ; salto a buscar el numero primo      
init:
        mov dx, 0h                   ; inicializo en cero 
        mov ax, 0h                   ; inicializo en cero 
        mov bx, 0h                   ; inicializo en cero
        mov cl, 0h                   ; inicializo en cero 
        ret                          ; retorno 

valida:
        call init                    ; limpio datos
        mov ax, num                  ; muevo los valores digitados  
        cmp ax,0h                    ; comparo con cero
        je es_cero                   ; pantalla cuando es cero 
        cmp ax,1h                    ; comparo con uno
        je es_uno                    ; pantalla cunado es uno 
        jmp primo                    ; salto a primo 
es_cero:
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset ceros         ; posición de la cadena a montar
        int 21h                      ; Llamada al sistema  
        mov ah,02                    ; para mostrar carácter
        mov dl,10                    ; imprimió el carácter de salto de línea
        int 21h                      ; llamada sistema
        jmp primo                    ; salto a primo 
es_uno:
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset unos          ; posición de la cadena a montar
        int 21h                      ; Llamada al sistema  
        mov ah,02                    ; para mostrar carácter
        mov dl,10                    ; imprimió el carácter de salto de línea
        int 21h                      ; llamada sistema
        jmp primo                    ; salto a primo 
primo:
        call init                    ; limpio datos
        mov ax, count                ; muevo el contador a AX
        mov bx, num                  ; muevo el numero a bx
        cmp ax, bx                   ; comparo los números
        je print                     ; son iguales salgo del ciclo
        call init                    ; limpio datos
        mov ax, num                  ; muevo el valor a ax
        mov bx, count                ; muevo el contador a bx
        div bx                       ; divido 
        cmp dx,0h                    ; comparo el resultado  
        jne continuociclo            ; si no son iguales continuo
        inc primov                   ; si son iguales aumento
continuociclo:                            
        inc count                    ; incremento contador 
        jmp primo                    ; continuo ciclo
        
print:
        call init                    ; limpió datos
        mov ax, primov               ; muevo el valor a ax
        cmp ax,2h                    ; comparo el valor con 2
        jne noprimo                  ; si no es igual 
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text4         ; posición de la cadena a montar
        int 21h                      ; llamada al SO
        mov ah,02                    ; para mostrar carácter
        mov dl,10                    ; imprimió el carácter de salto de línea
        int 21h                      ; llamada sistema
        jmp Salida                   ; Llamada al sistema        
 noprimo:        
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text3         ; posición de la cadena a montar
        int 21h                      ; llamada al SO  
        mov ah,02                    ; para mostrar carácter
        mov dl,10                    ; imprimió el carácter de salto de línea
        int 21h                      ; llamada sistema
; ********************************************************************
Salida: 
; ========================================================
.exit
end inicio
