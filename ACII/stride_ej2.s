; Esqueleto del programa de la práctica DLXV-2
;
;
           .data
x:
           .double  1,  0,  0,  0
           .double  0,  2,  0,  0
           .double  0,  0,  0,  1
           .double  0,  0,  1,  0

y:         .double  0,  1,  2,  3
	   .double  4,  5,  6,  7
	   .double  8,  9, 10, 11
	   .double 12, 13, 14, 15
temp:      .space 32
z:         .space 128   ;Vector o matriz Z

a:         .double 1    ;Escalar a
eltosGuardados:         .double 8    ;Escalar con el numero de elementos a guardar 


           .text
main:      addi r1,r0,x     ;r1 contiene la dirección de x
           addi r2,r0,y     ;r2 contiene la dirección de y
           addi r3,r0,z     ;r3 contiene la dirección de z
           addi r9,r0,temp  ;r9 contiene la direccion del espacio temporal donde sumamos las multiplicaciones de filas por columnas
	   addi r4,r0,4 ;Tamaño Columnas

	   movi2s vlr, r4   ;indicamos que el vlr es de tamaño de r4

           addi r7, r0, 4   ;Recorre filas
           
loopFilas:   
	  
	   addi r5,r0,8  ;Desp para coger una fila
	   lvws v1,r1,r5   ;Cogemos la fila de x    
	
	   addi r8, r0, 4   ;Recorre columnas

loopColumnas:
   
	   addi r6, r0, 4*8 ;Desp para coger una columna
	   lvws v2,r2,r6   ;Cogemos la columna de y

	   multv v3, v2, v1 ; Multiplicamos elemento a elemento,cada fila por todas las columnas
	   sv 0(r9), v3 ;Guardamos la solucion en un temporal

           addi r13, r0, 4 ;Numero de elementos a sumar
	   addi r12, r0, 0 ; Inicializamos el acumulador de suma
loopSuma:
          
          ld r14, 0(r9) ;Guardamos el primer elemento en el registro 14
	  addi r12,r14,r12 ;y lo vamos sumando en el acumulado
	  addi r9,r9,8 ;apuntamos al siguiente elemento temporal
           
          subi r13, r13, 1 ;Vamos recorriendo todos los elementos a sumar
	  bnez r13, loopSuma ;Si terminamos entonces se acabó la suma
	  nop

	  sf 0(r3), r12 ;Guardamos el elemento PETA!!!!!
	  addi r3, r3, 8 ;Ya hemos metido un elemento de z y vamos a por otro!!

          addi r9, r0, temp ;R9 debe volver a la posicion inicial tras la suma para en la siguiente iteracion empezar en el primer elemento

	  addi r2, r2, 8 ;Paso a la siguiente columna
	  subi r8, r8, 1 ;e indicamos que hemos recorrido ya una columna
          bnez r8, loopColumnas
	  nop

          addi r1, r1, 4*8   ; Paso a la siguiente Fila
          addi r2, r0, y     ; Las columnas de Y se reinician y empezamos por la primera
          subi r7, r7, 1     ; indicamos que ya hemos recorrido una fila
	  bnez r7, loopFilas
	  nop

   	  trap 6           ;Fin del programa
	    
