%Soledad Batista Rivero

%Este predicado se ejecuta cada vez que se introduce la opción c en el menú de bienvenida.Para empezar, elimina todo los conocido
%que existan, a continuación introduce en la base de conocimento el predicado conocido con los argumentos sin_valor para los campos atributo y valor.
%Después se llama al predicado historizar con objetivo(X), que en este caso, debido a la base de conocimiento que tenemos será objetivo(Ave).
%Una vez que se termine de ejecutar este predicado se obtendrá un valor correspondiente con los datos que se han estado introduciendo.
resolver :- abolish(conocido, 3),
        asserta(conocido(_, sin_valor, sin_valor)),
        historizar(objetivo(X), []),
        write('Respuesta: '), write(X), nl.

%Este predicado se ejecuta cuando falla el anterior, es decir cuando no existe una correspondencia entre los hechos
%de la base de conocimiento y las respuestas que se han dado.
resolver :- write('No se encontro respuesta'), nl.

%Se declara conocido como predicado dinámico.Esto va a permitir que a lo largo del trancurso de la ejecución del programa se pueda modificar.
:- dynamic conocido/3.

%conocido va a almacenar las repuestas para cada atributo-valor.
conocido(_, sin_valor, sin_valor).

% Predicado de partida del sistema experto, llama al menú de bienvenida y deja introducir comandos
% hasta que no se introduce una e (fin de la ejecución). En función del argumento que se introduce (X), se llama al predicado
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

%Este predicado se llama cuando se quiere realizar una consulta, se limita a llamar al predicado resolver.
ejecutar(c) :- resolver, !.

% ejecutar(h) muestra la ayuda del sistema experto, en este caso no esta redactada y solo
% va a aparecer la frase(Redactar o mostrar de archivo).
ejecutar(h) :-
        process('readme.txt'),!.

%Muestra una lista con todos los  predicados conocidos que se han registrado.
ejecutar(r) :- listing(conocido), !.

%Con este predicado termina la ejecución del sistema experto.
ejecutar(e) :- !.

%Con este predicado se llama al predicado como, que inidica cómo se puede alcanzar un determinado objetivo, es decir, que hechos deben
%cumplirse.
ejecutar(como(Objetivo)) :- como(Objetivo), !.

%Este predicado llama al predicado por_que_no, que indica cuales son los objetivos que han fallado y que han hecho que un determinado objetivo
%no se alcance.
ejecutar(por_que_no(Objetivo)) :- por_que_no(Objetivo), !.

%Si se le pasa otro valor diferente a los anteriores se considera como inválido y devuelve un fallo (fail).
ejecutar(X) :- write(X), write(' invalido'), nl, fail.

%Si recibe un true no se va a modificar nada.
historizar(true, _) :- !.

%Este predicado llama al predicado prueba con el objetivo actual y una lista que incluye el histórico y el objetivo actual. Una vez que se termine
%de ejecutar se llama de nuevo al predicado historizar con el resto de objetivos.
historizar((Objtv, Resto), Hist) :-
        !,prueba(Objtv, [Objtv|Hist]), historizar(Resto, Hist).

%Cuando sólo hay un objetivo es cuando se utiliza este predicado.
historizar(Objtv, Hist) :- prueba(Objtv, [Objtv|Hist]).

%Con este predicado, si se recibe true, finaliza sin alterar nada.
prueba(true, _) :- !.

%Con este predicado se va a realizar la pregunta correspondiente al atributo(A) y valor (V) que se han pasado como argumentos.
%Para ello, va a llamar al predicado preguntar.
prueba(preguntar(A, V), Hist) :-
        preguntar(A, V, Hist), !.

%Al usar este predicado identifica los hechos de la base de conocimiento que están relacionados con el objetivo que se pasa como argumento.
%Posteriormente se llama a historizar con los distintos hechos relacionados con el objetivo.
prueba(Objtv, Hist) :-
        clause(Objtv, Subjtvs), historizar(Subjtvs, Hist).

%Si ya se ha preguntado por el atributo-valor correspondiente este predicado hace que no se vuelva a preguntar.
preguntar(Atributo, Valor, _) :-
        conocido(si, Atributo, Valor), !.

%En caso de que anteriormente no se haya preguntado pues se provoca un fallo después de un corte para que entre en el predicado siguiente, que es
%el que va a realizar las preguntas.
preguntar(Atributo, Valor, _) :-
        conocido(_, Atributo, Valor), !, fail.

%Este predicado pregunta por el atributo-valor que recibe como argumento,para ello llama al predicado  leer_respuesta y posteriormente se introduce
%en la base de conocimiento (mediante asserta) conocido con los valores atributo, valor y la respuesta que se ha obtenido.
preguntar(Atributo, Valor, Hist) :-
        write(Atributo:Valor), write('? '),
        leer_respuesta(Resp, Hist),
        asserta(conocido(Resp, Atributo, Valor)),
        Resp == si.

%Este predicado lee una respuesta desde la entrada estándar y llama al predicado procesar_respuesta
leer_respuesta(X, Hist) :-
        repeat, read(X),
        procesar_respuesta(X, Hist), !.

%Este predicado llama a la función procesar_historico con el historico como argumento.
procesar_respuesta(por_que_no, Hist) :-
        escribir_historico(Hist),
        nl, !, fail.
        
%Otros argumentos diferentes al anterior no va a modificar nada.
procesar_respuesta(_, _).

%Elimina el primer y el ultimo elemento del historico, es decir, elimina preguntar() y objetivo()
%y muestra por la salida estándar el resultado final.
escribir_historico(Hist) :-
        eliminar_primero(Hist, Hist0),
        eliminar_ultimo(Hist0, HistFinal),
        write(HistFinal).

%Elimina el primer elemento de una lista.
eliminar_primero([_|R], R).

%Elimina el último elemento de una lista,inviertiendo la lista inicial, para así poder utilizar
%el predicado eliminar_primero.Una vez que se ha eliminado el primer elemento(el último de la lista inicial),
%se vuelve a invertir la lista para así obtener la lista inicial sin el último elemento.
eliminar_ultimo(L, R) :-
        reverse(L, L0),
        eliminar_primero(L0,R0),
        reverse(R0, R).

%Este menú permite seleccionar un valor entre un rango de valores predeterminado.
%Solicita que se introduzca un valor, y comprueba que se encuentra entre los valores Opciones
%mediante el predicado comprobar.
menu(Atributo, Valor, Opciones) :-
        write('Valor para '), write(Atributo),
        write('? '), nl, write(Opciones), nl,
        read(X),
        comprobar(X, Atributo, Valor, Opciones),
        asserta(conocido(si, Atributo, X)).
        %X == Valor.

%Comprueba que el elemento X es una elemento que esta dentro de Opciones con el predicado member
comprobar(X, Atributo, Valor, Opciones) :-
        member(X, Opciones), !.
        
%En caso de que no se encuentre dentro de las opciones(este predicado se ejecutaría si fallase el anterior) se mostraría
%por la salida estandar que el argumento no es válido y se volvería a llamar al predicado menú.
comprobar(X, Atributo, Valor, Opciones) :-
        write(X), write(' no valido.'), nl,
        menu(Atributo, Valor, Opciones).
        
%Con este predicado, dado un objetivo, se indica (mediante clause) los distintos hechos relacionados con él,de manera que con este predicado
%conseguimos saber que hechos deben cumplirse para que se cumpla un objetivo.
como(Objetivo) :-
        clause(Objetivo, Lista),
        historizar(Lista, []), write(Lista),nl.

%Con este predicado, al igual que en el caso anterior, obtiene todos los hechos relacionados con un objetivo, en este caso, se llama al predicado
% explicacion con estos hechos.
por_que_no(Objetivo) :-
        clause(Objetivo, Lista), nl, write(Objetivo),
        write(' falla porque: '), nl,
        explicacion(Lista), nl.

por_que_no(_).

%Este predicado llama a comprobar con el primer hecho y vuelve a llamar a explicacion con el resto.
explicacion((Primero, Resto)) :-
        comprobar(Primero), explicacion(Resto).

%Si sólo hay un hecho se llama a comprobar con éste.
explicacion(Primero) :- comprobar(Primero).

%Si éste hecho se cumple (se llama al predicado historizar con él) se indica que ha tenido éxito.
comprobar(Objetivo) :-
        historizar(Objetivo, _), write(Objetivo),
        write(' ha tenido exito.'), nl, !.

%En caso contrario, se indica que el hecho a fracasado.
comprobar(Objetivo) :-
        write(Objetivo),
        write(' ha fracasado.'), nl, fail.

% Este predicado muestra por la salida estándar las diferentes opciones
% que se pueden realizar.
bienvenida :-
        write('Bienvenido al Sistema Experto'), nl,
        write('Teclee: '), write('l (carga), '),
        write('c (consulta), '), write('h (ayuda), '),
        write('r (recuerda), '), write('como(Objtv), '),
        write('por_que_no(Objtv),'), write('e (finaliza)'), nl.
        
% Funciones auxiliares para mostrar la ayuda.
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