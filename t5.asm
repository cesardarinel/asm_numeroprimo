; Autor: Cesar Darinel Ortiz
; Tarea: 3 laboratorio
; Fecha Entrega: 11/10/2018

.model small
.stack 256
.data
; ========================Variables declaradas aquí===============
letrero DB 'INSERTE un numero maximo 4 digitos -->: $'
text2 DB 'No es par : $'              ; Cadena a desplegar
text DB 'Es par : $'              ; Cadena a desplegar
text3 DB 'No es Primo : $'              ; Cadena a desplegar
text4 DB 'Es Primo : $'              ; Cadena a desplegar
count dw ?            ; buffer de lectura de cadena
num dw ?
a dw 1000
b db 100
c db 10
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
           mov AH,1
           INT 21H  
           SUB AL,48
           MUL a                     
           mov num,AX
            
            mov AH,1
            INT 21H  
            SUB AL,48
            MUL b                       
            add num,AX
            
            mov AH,1
            INT 21H  
            SUB AL,30H
            MUL c                     
            ADD num,AX
            
            mov AH,1
            INT 21H                     
            SUB AL,30H
            ADD num,AX


es_par:               
           mov dx, 0h
           mov ax, num
           mov bx, 2
           div bx
           cmp dx,0h                    ; verificar si se pulsa el Enter.
           jne nopar
           mov ah,09                    ; Para mostrar en pantalla una cadena
           mov dx, offset text        ; posición de la cadena a montar
           int 21h
           jmp init                      ; Llamada al sistema        
 nopar:        
        mov ah,09                    ; Para mostrar en pantalla una cadena
           mov dx, offset text2        ; posición de la cadena a montar
           int 21h                      ; Llamada al sistema       
init:
    mov count,1
    mov cl,0
    mov dx,0
 primo:
    mov ax, count
    mov bx,num
    cmp ax, bx
    je print
    mov ax, num
    mov bx, count
    div bx
    cmp dx,0h   
    jne continuociclo
    inc cl  
continuociclo:   
    inc count
    jmp primo

print:
    cmp cl,50d
    jne noprimo
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text4        ; posición de la cadena a montar
        int 21h
        jmp Salida                      ; Llamada al sistema        
 noprimo:        
        mov ah,09                    ; Para mostrar en pantalla una cadena
        mov dx, offset text3        ; posición de la cadena a montar
        int 21h                      ; Llamada al sistema  

; ********************************************************************
Salida:
    
       

; ========================================================
.exit
end inicio
