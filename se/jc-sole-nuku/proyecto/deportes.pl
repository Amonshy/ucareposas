:-consult('entrada_datos').

:-principal('base.txt','deportes_db.pl').

objetivo(Deporte) :- deporte(Deporte).

:-consult('deportes_db').

nombre_deporte(X) :- preguntar(nombre_deporte, X).

categoria(X) :-
        preguntar(categoria, X).

instalacion(X) :-
        preguntar(instalacion, X).

accesorio(X) :-
        preguntar(accesorio, X).

jugadores(X) :-
        preguntar(jugadores, X).

otros(X) :-
        preguntar(otros, X).
