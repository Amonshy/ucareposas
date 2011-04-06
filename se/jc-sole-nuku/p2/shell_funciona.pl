%El predicado conocido recibe tres parámetros, la respuesta dada por
%el usuario , el atributo y el valor del atributo. En este caso
%conocido indicará cuales son las preguntas que ya se han hecho, la
%respuesta asociada y sobre que valores de atributos
%determinados. Como no podemos tener conocimiento de todo lo que se ha
%preguntado a priori, este predicado (conocido) debe establecerse como
%dinámico para poder realizar assert's de estos predicados en tiempo
%de ejecución.
:- dynamic conocido/3.
conocido(_, sin_valor, sin_valor).

% Con esta regla comenzamos a trabajar con el shell. En este caso se
% emitirá un mensaje de bienvenida a través del predicado
% "bienvenida", a continuación se utilizará una sentencia de control
% (repeat) que se repetirá una y otra vez hasta que no se cumplan
% todos los predicados a continuación de este (definición del
% predicado repeat/0). En este caso el único predicado susceptible de
% cambio X == e, que será falso hasta que el usuario no introduzca el
% valor e (salida) para finalizar la aplicación. El contenido del
% bucle, además de comparar si el usuario decide salir (X == e),
% imprime el carácter '>' a modo de prompt, leerá la opción elegida
% por el usuario y la ejecutará siempre que exista.
comenzar :- bienvenida,
  repeat,
  write('> '), read(X),
  ejecutar(X),
  X == e.

%Predicado destinado a imprimir por pantalla el mensaje de bienvenida y las diferentes opciones permitidas al usuario. No tiene mucha chicha. 
bienvenida :-
    write('Bienvenido al Sistema Experto'), nl,
    write('Teclee: '),
    write('l (carga), '),
    write('c (consulta), '),
    write('h (ayuda), '),
    write('r (recuerda), '),
    write('como(Objtv), '),
    write('pqn(Objtv), '),
    write('e (finaliza)'), nl.

% Si el usuario ha introducido la l, se pedirá por pantalla el nombre del archico sin .pl y se compilará el archivo con consult. Finalmente se utiliza un predicado de corte para que no pueda seguir explorando el árbol de búsqueda pues solo hemos decidido cargar un archivo.
ejecutar(l) :-
	write('Archivo: '),
	read(Archivo),
	consult(Archivo), !.
% Si el usuario ha introducido la c deseará realizar una consulta en
% este caso se ejecutará el predicado resolver (descrito más adelante)
% y de nuevo ponemos un corte para evitar el backtracking y que
% encuentre otro predicado con el que case y se ejecute. Si quitásemos
% el corte entonces casaría con el predicado ejecutar X y además de
% hacerlo todo se imprimirá "c inválido".
ejecutar(c) :- resolver, !.

%Ejecutar h está pendiente de desarrollar, actualmente solo muestra un mensaje informativo. El corte está puesto por el mismo motivo que en los ejecutar anteriores.
ejecutar(h) :-
	write('[Redactar o mostrar de archivo]'), nl, !.

%Si el usuario introduce r entonces lo que se hace es un listing, es
%decir un listado, en este caso al recibir como parámetro el predicado
%conocido entonces se hará un listado de todos los conocidos que se
%han assertado durante la ejecución.El corte está puesto por el mismo
%motivo que en los ejecutar anteriores.
ejecutar(r) :- listing(conocido), !.

%Cuando el usuario decide como alcanzar un objetivo, en este caso se
%llama al predicado como (descrito más adelante) con el objetivo a
%alcanzar.El corte está puesto por el mismo motivo que en los ejecutar
%anteriores.
ejecutar(como(Objtv)) :- como(Objtv), !.
%El usuario decide conocer porque no se ha alcanzado un objetivo
%determinado, entonces se llama al predicado pqn (descrito más
%adelante) con el objetivo que no se ha podido alcanzar.El corte está
%puesto por el mismo motivo que en los ejecutar anteriores.
ejecutar(pqn(Objtv)) :- pqn(Objtv), !.
%No se ejecutada nada, simplemente el carácter es 'e' y cuando la
%comparación X == e sea cierta, todos los predicados del repeat son
%true y se acaba el bucle. El corte está puesto por el mismo motivo
%que en los ejecutar anteriores.
ejecutar(e) :- !.
%El usuario ha introducido un comando inválido, se imprime por
%pantalla y se indica que es inválido.
ejecutar(X) :- write(X), write(' invalido'), nl, fail.

%En primer lugar se eliminarán todos los conocidos que se tenga de la
%pregunta anterior, esto permite ejecutar el programa una y otra vez
%dentro de la misma sesión. A continuación se incluye un nuevo
%conocido base a partir del cual se partirá en la búsqueda del nuevo
%objetivo, si no ponemos conocido, la primera vez que se pregunte por
%él se producirá un error. A continuación si llamáramos a objetivo(X),
%únicamente se realizaría una pregunta al usuario así que debemos usar
%el predicado historizar (Descrito más adelante). Una vez llegada a
%una conclusión se escribe la respuesta,
resolver :- abolish(conocido, 3),
   asserta(conocido(_, sin_valor, sin_valor)),
   historizar(objetivo(X), []),
   write('Respuesta: '), write(X), nl.

%En caso de que al resolver no se encuentre ninguna respuesta simplemente mostramos el mensaje por pantalla de que no se ha encontrado ninguna respuesta.
resolver :- write('No se encontro respuesta'), nl.


%Cuando queramos preguntar, si esa pregunta ya se ha hecho, y la
%respuesta que el usuario ha dado es 'sí', entonces no es necesario
%preguntar más porque ya se sabe que ese valor con ese atributo tiene
%una respuesta que es 'si'. De ahí que utilicemos el predicado de
%corte, así se devolverá verdadero y además no se realizará
%backtracking y seguirá preguntando.
preguntar(Atributo, Valor, _) :-
      conocido(si, Atributo, Valor), !.

%Cuando queramos preguntar, si esa pregunta ya se ha hecho, y la
%respuesta que el usuario ha dado es 'No', entonces no es necesario
%preguntar más porque ya se sabe que ese valor con ese atributo tiene
%una respuesta que es 'No'. En este caso se utiliza un predicado de
%corte para no seguir preguntando pero en este caso se utiliza el fail
%porque la respuesta a la pregunta es falsa.
preguntar(Atributo, Valor, _) :-
      conocido(_, Atributo, Valor), !, fail.

%Si no se tiene conocimiento de esa pregunta, para un Atributo dado y
%un valor de dicho atributo no se tiene una respuesta, entonces se le
%pregunta al usuario cual es la respuesta a esa pregunta con
%leer_respuesta (descrito más adelante). La respuesta obtenido se
%inserta dinámicamente y se comprueba si era 'si' o 'no' para devolver
%verdadero o falso.
preguntar(Atributo, Valor, Hist) :-
      write(Atributo:Valor), write('? '),
      leer_respuesta(Resp, Hist),
      asserta(conocido(Resp, Atributo, Valor)),
      Resp == si.

%El predicado leer_respuesta se encarga de pedirle al usuario la
%respuesta correspondiente a la pregunta realizada por el sistema
%experto. En este caso tenemos un repeat (se repite hasta que todos
%los predicados sean ciertos), y procesamos la respuesta, procesar
%respuesta siempre dará true y por tanto acabará el bucle, a menos que
%pongamos 'por_que' en cuyo caso volverá a preguntar la misma
%pregunta, ya que procesar_respuesta con por_que devuelve false, como
%veremos a continuación.
leer_respuesta(X, Hist) :-
      repeat, read(X),
      procesar_respuesta(X, Hist), !.

%Si la respuesta a procesar es 'por_que' entonces se escribirá un
%histórico de los objetivos y a continuación se pone un predicado de
%corte para que no case con el siguiente procesar que devuelve
%true. Colocamos un fail para que devuelva false y entonces vuelva a
%leerse una nueva respuesta.
procesar_respuesta(por_que, Hist) :-
      escribir_historico(Hist),
      nl, !, fail.
%Sea cual sea la respuesta del usuario, este predicado devolverá true.
procesar_respuesta(_, _).

%Historizar permite llevar un control de todas los predicados que
%deben cumplir y por los que preguntar al usuario para poder llegar a
%una respuesta. En este caso nuestro primero historizar siempre será
%el predicado objetivo y un historial vacío donde ir guardando
%aquellos predicados que debemos ir preguntado.

%Una vez que hemos llegado a un objetivo true, debemos dejar de
%historizar, no podemos seguir historizando y por eso ponemos un
%predicado de corte que nos permita no volver atrás y continuar con
%los siguientes predicados, anulando así el backtracking.
historizar(true, _) :- !.

%En este caso tenemos una tupla con un objetivo a probar y un serie de objetivos más que debemos historizar. El predicado de corte se utiliza para no hacer backtracking y que case con el historizar siguiente, haciendo que entre así en un bucle infinito. En este caso se prueba (descrito más adelante) el objetivo y se historiza el resto.
historizar((Objtv, Resto), Hist) :-
  !, prueba(Objtv, [Objtv|Hist]), historizar(Resto, Hist).

%Como comentábamos la primera llamada a historizar es con objetivo(X)
%y un historial vacío ([]). Cuando historizar unifique con este caso
%se llamará a prueba con el objetivo a buscar y se añadirá al
%historial de objetivos procesados. El predicado prueba está descrito
%posteriormente.
historizar(Objtv, Hist) :- prueba(Objtv, [Objtv|Hist]).

%Al igual que con historizar(true,_) este predicado indica que si
%probamos algo que es true el resultado es true.
prueba(true, _) :- !.

%En este caso cuando el objetivo es preguntar un valor sobre un
%atributo determinado, entonces se realizar la pregunta (ver
%descripción del predicado preguntar). El predicado de corte impide
%que no se siga haciendo más prueba.
prueba(preguntar(A, V), Hist) :-
  preguntar(A, V, Hist), !.

%En caso de que el objetivo no sea una pregunta, entonces el objetivo
%se descompone en sus reglas con el predicado clause y se produce una
%historización de las mismas, es de esta forma como dado un objetivo
%se descompone en sus reglas hasta que se lleguen a predicados que hay
%que preguntar directamente y entonces entraría por el predicado
%prueba descrito justo arriba y se haría la pregunta necesaria para
%intentar alcanzar el objetivo.
prueba(Objtv, Hist) :-
  clause(Objtv, Subjtvs), historizar(Subjtvs, Hist).

%Subsistema de explicaciones


%Con el predicado como podemos obtener una lista de los objetivos a
%satisfacer para alcanzar dicho objetivo.
como(Objetivo) :- clause(Objetivo, Lista),
   historizar(Lista, []), write(Lista).

%Con este predicado obtendremos la explicación de porque no se ha
%podio obtener un objetivo determinado. Para ello descomponemos el
%objetivo en sus reglas (clause) , imprimimos dicho objetivo y hacemos
%una explicación (detallado más adelante) de la lista de reglas a satisfacer.
pqn(Objetivo) :-
   clause(Objetivo, Lista), nl, write(Objetivo),
   write(' falla porque: '), nl,
   explicacion(Lista), nl.
%De esta forma nos cercioramos de que el predicado pqn devuelva siempre true.
pqn(_).

% La explicación de un objetivo true, siempre es true.
explicacion(true).

%Cuando hacemos una explicación de varios elementos debemos separar
%entre el primero y el resto, de manera que comprobemos (ver
%descripción de comprobar más adelante) y a continuación sigamos
%explicando el resto de elementos.
explicacion((Primero, Resto)) :-
   comprobar(Primero), explicacion(Resto).
%Si por el contrario el elemento que se desea explicar es uno solo,
%entonces comprobamos dicho elementos directamente.
explicacion(Primero) :- comprobar(Primero).

%Para comprobar un objetivo puede ocurrir que:

%Se pueda realizar una historización , es decir se va probando todos
%los resultado hasta que se cumplan todos los objetivos en cuyo caso
%tenemos éxito y ponemos un predicado de corte para que no haga
%backtracking y vuelva a casar con el comprobar objetivo de abajo,
%produciéndose así una incongruencia ya que diría que el objetivo ha
%tenido éxito y también que no ha tenido éxito.
comprobar(Objetivo) :-
   historizar(Objetivo, _), write(Objetivo),
   write(' ha tenido exito.'), nl, !.

%Si por el contrario no se ha podido probar el objetivo obteniendo
%resultado true (como explicábamos antes) entonces la comprobación ha
%fracasado.
comprobar(Objetivo) :-
   write(Objetivo),
   write(' ha fracasado.'), nl, fail.

%Elimina el primer objetivo y el último y escribe la lista de los
%objetivos procesados. Es un predicado que permite ver el proceso
%seguido por el SE para alcanzar el objetivo deseado.
escribir_historico(Hist) :-
  eliminar_primero(Hist, Hist0),
  eliminar_ultimo(Hist0, HistFinal),
  write(HistFinal).

%Muy triviales, elimina el primer elemento de una lista y el último de
%una lista respectivamente.
eliminar_primero([_|R], R).
eliminar_ultimo(L, R) :-
  reverse(L, L0),
  eliminar_primero(L0,LF),
  reverse(LF, R).


















