objetivo(X) :- predicadoDeObjetivo(X).
	
resolver :- abolish(conocido, 3),
	asserta(conocido(_, sin_valor, sin_valor)),
	historizar(objetivo(X), []),
	write('Respuesta: '), write(X), nl.
	resolver :- write('No se encontro respuesta'), nl.

resolver :- write('No se encontro respuesta'), nl.

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
	write('[Redactar o mostrar de archivo]'), nl, !.

ejecutar(r) :- listing(conocido), !.

ejecutar(e) :- !.

ejecutar(X) :- write(X), write(' invalido'), nl, fail.

ejecutar(como(Objetivo)) :- como(Objetivo), !.

ejecutar(por_que_no(Objetivo)) :- por_que_no(Objetivo), !.

pruebaPrototipo(true) :- !.

pruebaPrototipo(Objetivo) :-
	clause(Objetivo, Cuerpo),
	pruebaPrototipo(Cuerpo).
	
pruebaPrototipo(X) :- call(X).

pruebaPrototipo(Objetivo, RestoObjetivos) :-
	clause(Objetivo, Cuerpo),
	pruebaPrototipo(Cuerpo),
	pruebaPrototipo(RestoObjetivos).

historizar(true, _) :- !.

historizar((Objtv, Resto), Hist) :-
	prueba(Objtv, [Objtv|Hist]), historizar(Resto, Hist).
	
historizar(Objtv, Hist) :- prueba(Objtv, [Objtv|Hist]).

prueba(true, _) :- !.

prueba(preguntar(A, V), Hist) :-
	preguntar(A, V, Hist), !.
	
prueba(Objtv, Hist) :-
	clause(Objtv, Subjtvs), historizar(Subjtvs, Hist).

preguntar(Atributo, Valor, _) :-
	conocido(si, Atributo, Valor), !.

preguntar(Atributo, Valor, _) :-
	conocido(_, Atributo, Valor), !, fail.

preguntar(Atributo, Valor, Hist) :-
	write(Atributo:Valor), write('? '),
	leer_respuesta(Resp, Hist),
	asserta(conocido(Resp, Atributo, Valor)),
	Resp == si.

leer_respuesta(X, Hist) :-
	repeat, read(X),
	procesar_respuesta(X, Hist), !.

procesar_respuesta(por_que, Hist) :-
	escribir_historico(Hist),
	nl, !, fail.

procesar_respuesta(_, _).

escribir_historico(Hist) :-
	eliminar_primero(Hist, Hist0),
	eliminar_ultimo(Hist0, HistFinal),
	write(HistFinal).

eliminar_primero([_|R], R).

eliminar_ultimo(L, R) :-
	reverse(L, L0),
	eliminar_primero(L0),
	reverse(L0, R).

% Por ejemplo: como(familia(pato)).
como(Objetivo) :-
	clause(Objetivo, Lista),
	historizar(Lista, []), write(Lista).

% Por ejemplo: por_que_no(orden(tubinar)).
por_que_no(Objetivo) :-
	clause(Objetivo, Lista), nl, write(Objetivo),
	write(' falla porque: '), nl,
	explicacion(Lista), nl.
	
por_que_no(_).

explicacion((Primero, Resto)) :-
	comprobar(Primero), explicacion(Resto).

explicacion(Primero) :- comprobar(Primero).

comprobar(Objetivo) :-
	historizar(Objetivo, _), write(Objetivo),
	write(' ha tenido exito.'), nl, !.

comprobar(Objetivo) :-
	write(Objetivo),
	write(' ha fracasado.'), nl, fail.

bienvenida :-
	write('Bienvenido al Sistema Experto'), nl,
	write('Teclee: '), write('l (carga), '),
	write('c (consulta), '), write('h (ayuda), '),
	write('r (recuerda), '), write('como(Objtv), '),
	write('PQN(Objtv)'), write('e (finaliza)'), nl.
