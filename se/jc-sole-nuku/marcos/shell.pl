:- consult(marcosshell).
% :- consult(deportes).

resolver :-
	abolish(conocido, 3),
	asserta(conocido(_, sin_valor, sin_valor)),
	listarMarcos(L),
	procesarListaDeportes(L,X),
	write('Respuesta: '), write(X), nl.

resolver :- write('No se encontro respuesta'), nl.

listarMarcos(L) :-
	findall(Deporte,obtener_marco(Deporte,[es-deporte]),L).

procesarListaDeportes([],_) :- false.

procesarListaDeportes([Deporte|Resto],X) :-
	obtenerSlots(Deporte,Slots),
	(comprobarDeporte(Deporte,Slots,X) -> true ; procesarListaDeportes(Resto,X)).

obtenerSlots(Deporte,Slots) :-
	marco(Deporte,Slots).

comprobarDeporte(_,[],_) :- true.

comprobarDeporte(Deporte,[Slot|RestoSlots],Deporte) :-
	preguntarSlot(Slot),
	comprobarDeporte(Deporte,RestoSlots,Deporte).

preguntarSlot(es-[val([deporte])]) :- true,!.

preguntarSlot(C-[val([X])]) :-
	(preguntar(C,X,_) -> true ; preguntar(C,X)).

preguntarSlot(C-[val([X|Resto])]) :-
	preguntarSlot(C-[val(Resto)]),
	(preguntar(C,X,_) -> true ; preguntar(C,X)).

:- dynamic conocido/3.

conocido(_, sin_valor, sin_valor).

comenzar :-
        bienvenida,
        repeat,
        write('> '), read(X),
        ejecutar(X),
        X == e.

ejecutar(l) :- write('Archivo: '),
        read(Archivo), consult(Archivo), !.

ejecutar(c) :- resolver, !.

ejecutar(h) :-
        process('readme.txt'),!.

ejecutar(r) :- listing(conocido), !.

ejecutar(e) :- !.

ejecutar(X) :- write(X), write(' invalido'), nl, fail.

preguntar(Atributo, Valor, _) :-
        conocido(si, Atributo, Valor), !.

preguntar(Atributo, Valor) :-
		(conocido(no, Atributo, Valor) -> fail;
        write(Atributo:Valor), write('? '),
        leer_respuesta(Resp),
        asserta(conocido(Resp, Atributo, Valor)),
        Resp == si).

leer_respuesta(X) :-
        repeat, read(X), !.

bienvenida :-
        write('Bienvenido al Sistema Experto'), nl,
        write('Teclee: '), write('l (carga), '),
        write('c (consulta), '), write('h (ayuda), '),
        write('r (recuerda), '), write('e (finaliza)'), nl.
        
process(File) :-
        open(File, read, In),
        get_char(In, Char1),
        process_stream(Char1, In),
        close(In).

process_stream(end_of_file, _) :- !.

process_stream(Char, In) :-
        print(Char),
        get_char(In, Char2),
        process_stream(Char2, In).