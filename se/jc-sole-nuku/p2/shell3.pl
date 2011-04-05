resolver :- abolish(conocido, 3),
        asserta(conocido(_, sin_valor, sin_valor)),
        historizar(objetivo(X), []),
        write('Respuesta: '), write(X), nl.

%este predicado se jecuta cuando falla el anterior, es decir cuando no existe una correspondencia entre los hechos
%de la base de conocimiento y las respuestas que se han dado.
resolver :- write('No se encontro respuesta'), nl.

:- dynamic conocido/3.

conocido(_, sin_valor, sin_valor).

% predicado de partida del sistema experto, llama al menu de bienvenida y deja introducir comandos
% hasta que no se introduce una e (fin de la ejecución). En funcion del argumento que se introduce (X), se llama al predicado
% ejecutar con el argumento X.
comenzar :-
        bienvenida,
        repeat,
        write('> '), read(X),
        ejecutar(X),
        X == e.

% ejecutar(l) carga un archivo (el que se le especifique por la entrada estándar)
% y lo añade a la base de conocimiento. Para ello se solicita que se escriba la ruta del archivo
% para así poderlo leer (read) y añadirlo a la base de conocimientos(consult)
ejecutar(l) :- write('Archivo: '),
        read(Archivo), consult(Archivo), !.

%este predicado se llama cuando se quiere realizar una consulta, se limita a llamar al predicado resolver.
ejecutar(c) :- resolver, !.

% ejecutar(h) muestra la ayuda del sistema experto, en este caso no esta redactada y solo
% va a aparecer la frase(Redactar o mostrar de archivo).
ejecutar(h) :-
        write('[Redactar o mostrar de archivo]'), nl, !.

%muestra una lista con todos los  predicados conocidos que se han registrado.
ejecutar(r) :- listing(conocido), !.

% con este predicado termina la ejecución del sistema experto.
ejecutar(e) :- !.

ejecutar(como(Objetivo)) :- como(Objetivo), !.

ejecutar(por_que_no(Objetivo)) :- por_que_no(Objetivo), !.

%Si se le pasa otro valor diferente a los anteriores se considera como
%inválido y devuelve un fallo (fail).
ejecutar(X) :- write(X), write(' invalido'), nl, fail.

historizar(true, _) :- !.

historizar((Objtv, Resto), Hist) :-
        !,prueba(Objtv, [Objtv|Hist]), historizar(Resto, Hist).

historizar(Objtv, Hist) :- prueba(Objtv, [Objtv|Hist]).

prueba(true, _) :- !.

prueba(preguntar(A, V), Hist) :-
        preguntar(A, V, Hist), !.
        
prueba(Objtv, Hist) :-
        clause(Objtv, Subjtvs), historizar(Subjtvs, Hist).

preguntar(Atributo, Valor, Hist) :-
        write(Atributo:Valor), write('? '),
        leer_respuesta(Resp, Hist),
        asserta(conocido(Resp, Atributo, Valor)),
        Resp == si.
        
preguntar(Atributo, Valor, _) :-
        conocido(si, Atributo, Valor), !.

preguntar(Atributo, Valor, _) :-
        conocido(_, Atributo, Valor), !, fail.

leer_respuesta(X, Hist) :-
        %repeat, read(X),
        read(X),
        procesar_respuesta(X, Hist), !.

procesar_respuesta(por_que_no, Hist) :-
        escribir_historico(Hist),
        nl, !, fail.

 procesar_respuesta(_, _).

%elimina el primer y el ultimo elemento del historico, es decir, elimina preguntar() y objetivo()
%y muestra por la salida estandar el resultado final.
escribir_historico(Hist) :-
        eliminar_primero(Hist, Hist0),
        eliminar_ultimo(Hist0, HistFinal),
        write(HistFinal).

%elimina el primer elemento de una lista.
eliminar_primero([_|R], R).

%elimina el ultimo elemento de una lista,inviertiendo la lista inicial, para asi poder utilizar
%la funcion eliminar_primero.Una vez que se ha eliminado el primer elemento(el ultimo de la lista inicial),
%se vuelve a invertir la lista para asi obtener la lista inicial sin el ultimo elemento.
eliminar_ultimo(L, R) :-
        reverse(L, L0),
        eliminar_primero(L0,R0),
        reverse(R0, R).

%este menu permite seleccionar un valor entre un ranngo de valores predeterminado.
%solicita que se introduzca un valor, y comprueba que se encuentra entre los valores Opciones
%mediante el predicado comprobar.
menu(Atributo, Valor, Opciones) :-
        write('Valor para '), write(Atributo),
        write('? '), nl, write(Opciones), nl,
        read(X),
        comprobar(X, Atributo, Valor, Opciones),
        asserta(conocido(si, Atributo, X)).
        %X == Valor.

%comprueba que el elemento X es una elemento que esta dentro de Opciones con el predicado member
comprobar(X, Atributo, Valor, Opciones) :-
        member(X, Opciones), !.
        
%en caso de que no se encuentre dentro de las opciones(este predicado se ejecutaria si fallase el anterior) se mostraria
%por la salida estandar que el argumento no es valido y se volveria a llamar a la funcion menu.
comprobar(X, Atributo, Valor, Opciones) :-
        write(X), write(' no valido.'), nl,
        menu(Atributo, Valor, Opciones).
        
% %Por ejemplo: como(familia(pato)).
como(Objetivo) :-
        clause(Objetivo, Lista),
        historizar(Lista, []), write(Lista),nl.

% %Por ejemplo: por_que_no(orden(tubinar)).
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

% Este predicado muestra por la salida estandar las diferentes opciones
% que se pueden realizar.
bienvenida :-
        write('Bienvenido al Sistema Experto'), nl,
        write('Teclee: '), write('l (carga), '),
        write('c (consulta), '), write('h (ayuda), '),
        write('r (recuerda), '), write('como(Objtv), '),
        write('por_que_no(Objtv),'), write('e (finaliza)'), nl.