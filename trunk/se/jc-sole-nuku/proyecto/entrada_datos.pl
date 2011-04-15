principal(ArchivoEntrada,ArchivoSalida):- see(ArchivoEntrada),tell(ArchivoSalida),procesar_fichero,seen,told.

procesar_fichero:-get0(X),X\== -1,leer_datos(X),get0(Punto),put(Punto),get0(_),get0(SaltoLinea),put(SaltoLinea),procesar_fichero,!.
procesar_fichero:-!.

leer_datos(C):- leer_nombre(C).

%En estos predicados se comprueba qué atributos se encuentran vacíos.
leer_nombre(59):- write('):-'),get0(C),C\==59,leer_categoria(C),!.
leer_nombre(59):- get0(C),C\==59,leer_instalacion(C),!.
leer_nombre(59):- get0(C),C\==59,leer_accesorio(C),!.
leer_nombre(59):- get0(C),C\==59,leer_jugadores(C),!.
leer_nombre(59):- get0(C),C\==59,leer_otros(C),!.
leer_nombre(C):- write('deporte('),put(C),get0(X),leer_nombre_recur(X).

leer_nombre_recur(59):- leer_nombre(_),!.                                        %;
leer_nombre_recur(C):- put(C),get0(X),leer_nombre_recur(X).

%------------------------------------CATEGORÍA------------------------------------------------
%Si se trata de un ;(59) y el siguiente caracter es también un ; pues no hace falta escribir una ,
leer_categoria(59):- get0(X),X\==59,write(','),leer_instalacion(X),!.
leer_categoria(59):- leer_instalacion(_),!.
leer_categoria(C):- write('categoria('),put(C),get0(X),leer_categoria_recur(X).

leer_categoria_recur(44):-write('),'),get0(X),leer_categoria(X),!.  %,
leer_categoria_recur(59):-write(')'),leer_categoria(59),!.                                        %;
leer_categoria_recur(C):- put(C),get0(X),leer_categoria_recur(X).

%------------------------------------INSTALACIÓN------------------------------------------------
leer_instalacion(59):- get0(X),X\==59,write(','),leer_accesorio(X),!.
leer_instalacion(59):- leer_accesorio(_),!.
leer_instalacion(C):- write('instalacion('),put(C),get0(X),leer_instalacion_recur(X).

leer_instalacion_recur(44):-write('),'),get0(X),leer_instalacion(X),!.  %,
leer_instalacion_recur(59):-write(')'),leer_instalacion(59),!.                                        %;
leer_instalacion_recur(C):- put(C),get0(X),leer_instalacion_recur(X).

%------------------------------------ACCESORIO------------------------------------------------

leer_accesorio(59):- get0(X),X\==59,write(','),leer_jugadores(X),!.
leer_accesorio(59):- leer_jugadores(_),!.
leer_accesorio(C):- write('accesorio('),put(C),get0(X),leer_accesorio_recur(X).

leer_accesorio_recur(44):-write('),'),get0(X),leer_accesorio(X),!.  %,
leer_accesorio_recur(59):-write(')'),leer_accesorio(59),!.                                        %;
leer_accesorio_recur(C):- put(C),get0(X),leer_accesorio_recur(X).


%------------------------------------JUGADORES-----------------------------------------------
leer_jugadores(59):- get0(X),X\==59,write(','),leer_otros(X),!.
leer_jugadores(59):- leer_otros(_),!.
leer_jugadores(C):- write('jugadores('),put(C),get0(X),leer_jugadores_recur(X).

leer_jugadores_recur(44):-write('),'),get0(X),leer_jugadores(X),!.  %,
leer_jugadores_recur(59):-write(')'),leer_jugadores(59),!.                                        %;
leer_jugadores_recur(C):- put(C),get0(X),leer_jugadores_recur(X).

%------------------------------------OTROS-----------------------------------------------
leer_otros(59):- get0(X),X\==59,write(','),leer_deportes(X),!.
leer_otros(59):- leer_deportes(_),!.
leer_otros(C):- write('otros('),put(C),get0(X),leer_otros_recur(X).

leer_otros_recur(44):-write('),'),get0(X),leer_otros(X),!.  %,
leer_otros_recur(59):-write(')'),leer_otros(59),!.                                        %;
leer_otros_recur(C):- put(C),get0(X),leer_otros_recur(X).

%------------------------------------DEPORTES-----------------------------------------------
leer_deportes(59):- !.
leer_deportes(C):- write('nombre_deporte('),put(C),get0(X),leer_deportes_recur(X).

leer_deportes_recur(44):-write('),'),get0(X),leer_deportes(X),!.  %,
leer_deportes_recur(59):-write(')'),leer_deportes(59),!.                  %;
leer_deportes_recur(C):- put(C),get0(X),leer_deportes_recur(X).