principal(ArchivoEntrada,ArchivoSalida):- see(ArchivoEntrada),tell(ArchivoSalida),get(X),leer_datos(X),write('.'),seen,told.

leer_datos(C):- leer_nombre(C).

leer_nombre(59):- write('):-'),get(C),C\==59,leer_categoria(C),!.
leer_nombre(59):- get(C),leer_instalacion(C),!.
leer_nombre(C):- write('deporte('),put(C),get(X),leer_nombre_recur(X).

leer_nombre_recur(59):- leer_nombre(X),!.                                        %;
leer_nombre_recur(C):- put(C),get(X),leer_nombre_recur(X).

%------------------------------------CATEGORÍA------------------------------------------------
%Si se trata de un ;(59) y el siguiente caracter es también un ; pues no hace falta escribir una ,
leer_categoria(59):- get(X),X\==59,write(','),leer_instalacion(X),!.
leer_categoria(59):- leer_instalacion(X),!.
leer_categoria(C):- write('categoria('),put(C),get(X),leer_categoria_recur(X).

leer_categoria_recur(44):-write('),'),get(X),leer_categoria(X),!.  %,
leer_categoria_recur(59):-write(')'),leer_categoria(59),!.                                        %;
leer_categoria_recur(C):- put(C),get(X),leer_categoria_recur(X).

%------------------------------------INSTALACIÓN------------------------------------------------
leer_instalacion(59):- get(X),X\==59,write(','),leer_accesorio(X),!.
leer_instalacion(59):- leer_accesorio(X),!.
leer_instalacion(C):- write('instalacion('),put(C),get(X),leer_instalacion_recur(X).

leer_instalacion_recur(44):-write('),'),get(X),leer_instalacion(X),!.  %,
leer_instalacion_recur(59):-write(')'),leer_instalacion(59),!.                                        %;
leer_instalacion_recur(C):- put(C),get(X),leer_instalacion_recur(X).

%------------------------------------ACCESORIO------------------------------------------------

leer_accesorio(59):- get(X),X\==59,write(','),leer_jugadores(X),!.
leer_accesorio(59):- leer_jugadores(X),!.
leer_accesorio(C):- write('accesorio('),put(C),get(X),leer_accesorio_recur(X).

leer_accesorio_recur(44):-write('),'),get(X),leer_accesorio(X),!.  %,
leer_accesorio_recur(59):-write(')'),leer_accesorio(59),!.                                        %;
leer_accesorio_recur(C):- put(C),get(X),leer_accesorio_recur(X).


%------------------------------------JUGADORES-----------------------------------------------
leer_jugadores(59):- get(X),X\==59,write(','),leer_otros(X),!.
leer_jugadores(59):- leer_otros(X),!.
leer_jugadores(C):- write('jugadores('),put(C),get(X),leer_jugadores_recur(X).

leer_jugadores_recur(44):-write('),'),get(X),leer_jugadores(X),!.  %,
leer_jugadores_recur(59):-write(')'),leer_jugadores(59),!.                                        %;
leer_jugadores_recur(C):- put(C),get(X),leer_jugadores_recur(X).

%------------------------------------OTROS-----------------------------------------------
leer_otros(59):- !.
leer_otros(C):- write('otros('),put(C),get(X),leer_otros_recur(X).

leer_otros_recur(44):-write('),'),get(X),leer_otros(X),!.  %,
leer_otros_recur(59):-write(')'),leer_otros(59),!.                                        %;
leer_otros_recur(C):- put(C),get(X),leer_otros_recur(X).