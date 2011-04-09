% Autor:
% Fecha: 07/04/2011

principal:- see('C:/Users/Sole/Desktop/base.txt'),get(X),leer_datos(X),write('.'),seen.

leer_datos(C):- leer_nombre(C).

leer_nombre(59):- write('):-'),get(C),leer_accesorio(C),!.
leer_nombre(C):- write('deporte('),put(C),get(X),leer_nombre_recur(X).

leer_nombre_recur(59):- leer_nombre(X),!.                                        %;
leer_nombre_recur(C):- put(C),get(X),leer_nombre_recur(X).

leer_accesorio(59):- get(X),leer_instalacion(X),!.
leer_accesorio(C):- write('accesorio('),put(C),get(X),leer_accesorio_recur(X).

leer_accesorio_recur(44):-write('),'),get(X),leer_accesorio(X),!.  %,
leer_accesorio_recur(59):-write(')'),!.                                        %;
leer_accesorio_recur(C):- put(C),get(X),leer_accesorio_recur(X).


leer_instalacion(59):- !.
leer_instalacion(C):- write(',instalacion('),put(C),get(X),leer_instalacion_recur(X).

leer_instalacion_recur(44):-write(')'),get(X),leer_instalacion(X),!.  %,
leer_instalacion_recur(59):-write(')'),!.                                        %;
leer_instalacion_recur(C):- put(C),get(X),leer_instalacion_recur(X).