% Autor:       Pablo de la Torre Moreno
% Fecha:       02/05/2011
% Versión:     1.0
% Descripción: versión en castellano y con errores arreglados del código
%              propuesto en la actualización de agosto de 2000 del libro
%              "Building Expert Systems in Prolog", de Dennis Merrit.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Predicados de búsqueda %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% obtener_marco/2 %%%%%%%%%%%%%%%%%
% Recupera los valores de los atributos de un marco
obtener_marco(Objeto, ListaRequisitos) :-
    marco(Objeto, ListaSlots),
    valores_slots(Objeto, ListaRequisitos, ListaSlots).
    
%%%%%%%% valores_slots/3 %%%%%%%%%%%%%%%%%
% Obtiene una lista de slots que responden a los requisitos
valores_slots(_, [], _).
valores_slots(T, [Req|Rest], ListaSlots) :-
    prep_req(Req, req(T, S, A, V)),
    buscar_slot(req(T, S, A, V), ListaSlots),
    !,
    valores_slots(T, Rest, ListaSlots).
valores_slots(T, Req, ListaSlots) :-
    prep_req(Req, req(T, S, A, V)),
    buscar_slot(req(T, S, A, V), ListaSlots).

%%%%%%%% prep_req/2 %%%%%%%%%%%%%%%%%%%%%%
% Convierte los atributos en una
% estructura
% req(marco, slot, atributo, valor)
% 1. X es variable -> añadirlo como valor, !
prep_req(Slot-X, req(_, Slot, val, X)) :- var(X), !.
% 2. X de forma atributo(valor) -> usar atributo, !
prep_req(Slot-X, req(_, Slot, Atrib, Val)) :-
    nonvar(X),
    X =.. [Atrib, Val],
    lista_atributos(ListaAtrib),
    member(Atrib, ListaAtrib),
    !.
% 3. -> añadirlo como valor
prep_req(Slot-X, req(_, Slot, val, X)).

%%%%%%%% lista_atributos/1 %%%%%%%%%%%%%%%
% Lista de atributos permitidos
lista_atributos([val, def, calc, add, del, edit]).

%%%%%%%% buscar_slot/2 %%%%%%%%%%%%%%%%%%%
% Trata de satisfacer la búsqueda del slot
% 1. V no es variable -> busca slot, simple y lista, !
buscar_slot(req(T, S, A, V), ListaSlots) :-
    nonvar(V),
    buscar_slot(req(T, S, A, Val), ListaSlots),
    !,
    (Val == V; member(V, Val)).
% 2. -> busca en todos los atributos del slot, !
buscar_slot(req(T, S, A, V), ListaSlots) :-
    member(S-ListaAtrib, ListaSlots),
    !,
    valor_atributo(req(T, S, A, V), ListaAtrib).
% 3. -> Busca en el padre (atributo es), !
buscar_slot(req(T, S, A, V), ListaSlots) :-
    member(es-ListaAtrib, ListaSlots),
    valor_atributo(req(T, es, val, Es), ListaAtrib),
    (member(P, Es); P = Es),
    marco(P, SlotsSupers),
    buscar_slot(req(T, S, A, V), SlotsSupers),
    !.
% 4. -> Falla si no es ninguna de las anteriores
buscar_slot(_, _) :- fail.

%%%%%%%% valores_atributos/2 %%%%%%%%%%%%%
% Obtiene el valor en función del atributo
% 1. Hay valor y se corresponde a atributo -> !
valor_atributo(req(_, _, A, V), ListaAtrib) :-
    AtrVal =.. [A, V],
    member(AtrVal, ListaAtrib),
    !.
% 2. Atributo es 'val' -> V es valor o en valores, !
valor_atributo(req(_, _, val, V), ListaAtrib) :-
    member(val(ListaValores), ListaAtrib),
    member(V, ListaValores),
    !.
% 3. Atributo es 'val' y hay 'def' -> V por defecto, !
valor_atributo(req(_, _, val, V), ListaAtrib) :-
    member(def(V), ListaAtrib),
    !.
% 4. -> Se invoca al predicado que calcula
valor_atributo(req(T, S, val, V), ListaAtrib) :-
    member(calc(Predicado), ListaAtrib),
    Predicado =.. [Fn | Pars],
    FnCalc =.. [Fn, req(T, S, val, V) | Pars],
    call(FnCalc).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicados de agregación %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% agregar_marco/2 %%%%%%%%%%%%%%%%%
% Agrega al marco los valores indicados,
% creándolo si no existe
agregar_marco(Objeto, ListaValores) :-
    slots_antiguos(Objeto, ListaSlots),
    agregar_slots(Objeto, ListaValores, ListaSlots, NuevaLista),
    retract(marco(Objeto, _)),
    asserta(marco(Objeto, NuevaLista)),
    !.

%%%%%%%% slots_antiguos/2 %%%%%%%%%%%%%%%%
% Obtiene los slots del marco
% 1. Objeto existe -> devuelve sus slots, !
slots_antiguos(Objeto, ListaSlots) :- marco(Objeto, ListaSlots), !.
% 2. -> Crea el objeto en un marco
slots_antiguos(Objeto, []) :- asserta(marco(Objeto, [])).

%%%%%%%% agregar_slots/4 %%%%%%%%%%%%%%%%%
% Agrega al marco los slots antiguos más
% los nuevos
% 1. Sin slots que agregar -> mantiene la lista actual
agregar_slots(_, [], X, X).
% 2. Lista -> agrega el primero y llama de nuevo
agregar_slots(T, [Val|Rest], ListaSlots, NuevaLista) :-
    prep_req(Val, req(T, S, A, V)),
    agregar_slot(req(T, S, A, V), ListaSlots, Z),
    agregar_slots(T, Rest, Z, NuevaLista).
% 3. Sólo uno -> lo agrega
agregar_slots(T, Val, ListaSlots, NuevaLista) :-
    prep_req(Val, req(T, S, A, V)),
    agregar_slot(req(T, S, A, V), ListaSlots, NuevaLista).

%%%%%%%% agregar_slot/3 %%%%%%%%%%%%%%%%%%
% Agrega un slot nuevo a la lista de slots
% Lo borra si existe (línea 1)
% Lo agrega al final de la lista (línea 2)
% Devuelve la lista (3º parámetro de cabeza)
agregar_slot(req(T, S, A, V), ListaSlots, [S-ListaAtrib2|Resto]) :-
    delete(ListaSlots, S-ListaAtrib, Resto),
    agregar_atributo(req(T, S, A, V), ListaAtrib, ListaAtrib2).

%%%%%%%% agregar_atributo/2 %%%%%%%%%%%%%%
% Igual que agregar_slots pero con
% atributos
% 1. Elimina los antiguos (líneas 1 y 2)
% 2. Los agrega más el nuevo (3 y 5)
% 3. Chequea demonios de agregación (4)
agregar_atributo(req(T, S, A, V), ListaAtrib, [AVNuevo|Rest]) :-
    AVAnt =.. [A, ValAnt],
    delete(ListaAtrib, AVAnt, Rest),
    agregar_valor(ValAnt, V, ValNuevo),
    !,
    chequea_demonios_agregacion(req(T, S, A, V)),
    AVNuevo =.. [A, ValNuevo].

%%%%%%%% agregar_valor/3 %%%%%%%%%%%%%%%%%
% Igual que agregar_slots pero con
% valores
% Append para valores simples también, ya que los
% valores de un atributo pueden serlo
agregar_valor(X, V, V) :- var(X), !.
agregar_valor(ListaViejos, ListaValores, ListaNuevos) :-
    is_list(ListaViejos),
    is_list(ListaNuevos),
    append(ListaValores, ListaViejos, ListaNuevos),
    !.
agregar_valor([H|T], V, [V, H|T]).
agregar_valor(V, [H|T], [V, H|T]).
agregar_valor(_, V, V).

%%%%%%%% chequea_dominios_agregación/1 %%%
% Busca los desencadenadores de
% agregación y los ejecuta
chequea_demonios_agregacion(req(T, S, A, V)) :-
    obtener_marco(T, S-add(Predicado)),
    !,
    Predicado =.. [Fn | Pars],
    FnAgregar =.. [Fn, req(T, S, A, V) | Pars],
    call(FnAgregar).
chequea_demonios_agregacion(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicados de borrado %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% borrar_marco/2 %%%%%%%%%%%%%%%%%%
% Borra el marco o los valores indicados
borrar_marco(Objeto) :- retract(marco(Objeto, _)).
borrar_marco(Objeto) :- error('No hay objeto: ', Objeto).
borrar_marco(Objeto, ListaRequisitos) :-
    slots_antiguos(Objeto, ListaSlots),
    borrar_slots(Objeto, ListaRequisitos, ListaSlots, NuevaLista),
    retract(marco(Objeto, _)),
    asserta(marco(Objeto, NuevaLista)),
    !.

%%%%%%%% borrar_slots/4 %%%%%%%%%%%%%%%%%%
% Agrega los slots antiguos sin los que
% deben ser borrados
borrar_slots(_, [], X, X).
borrar_slots(T, [Req|Rest], ListaSlots, NuevaLista) :-
    prep_req(Req, req(T, S, A, V)),
    borrar_slot(req(T, S, A, V), ListaSlots, Z),
    borrar_slots(T, Rest, Z, NuevaLista).
borrar_slots(T, Req, ListaSlots, NuevaLista) :-
    prep_req(Req, req(T, S, A, V)),
    borrar_slot(req(T, S, A, V), ListaSlots, NuevaLista).
    
%%%%%%%% borrar_slot/3 %%%%%%%%%%%%%%%%%%%
% Borra cada slot de la lista de slots
borrar_slot(req(T, S, A, V), ListaSlots, [S-ListaAtrib2|Rest]) :-
    quitar(ListaSlots, S-ListaAtrib, Rest),
    borrar_atributo(req(T, S, A, V), ListaAtrib, ListaAtrib2).
borrar_slot(Req, _, _) :-
    error('Imposible de borrar: ', Req).

%%%%%%%% borrar_atributo/2 %%%%%%%%%%%%%%%
% Igual que borrar_slots, pero con
% atributos
borrar_atributo(req(T, S, A, V), ListaAtrib, ListaFinal) :-
    AV =.. [A, V],
    !, % el corte evita el siguiente predicado si falla "quitar"
    quitar(ListaAtrib, AV, ListaFinal),
    !,
    chequea_demonios_borrado(req(T, S, A, V)).
borrar_atributo(req(T, S, A, V), ListaAtrib, [AVNuevo|Rest]) :-
    AVAnt =.. [A, ValAnt],
    quitar(AVAnt, ListaAtrib, Rest),
    quitar(V, ValAnt, NuevaListaVal),
    AVNuevo =.. [A, NuevaListaVal], !,
    chequea_demonios_borrado(req(T, S, A, V)).
borrar_atributo(Req, _, _) :-
    error("Imposible borrar: ", Req).

%%%%%%%% chequea_demonios_borrado/2 %%%%%%
% Busca los desencadenadores de borrado
% y los ejecuta
chequea_demonios_borrado(req(T, S, A, V)) :-
    obtener_marco(T, S-del(Predicado)),
    !,
    Predicado =.. [Fn | Pars],
    FnBorrar =.. [Fn, req(T, S, A, V) | Pars],
    call(FnBorrar).
chequea_demonios_borrado(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicados auxiliares %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% quitar/3 %%%%%%%%%%%%%%%%%%%%%%%%
% Quita de la lista el elemento indicado,
% devolviendo fail si la lista está vacía
quitar([X|Y], X, Y) :- !.
quitar([Y|Z], X, [Y|W]) :- delete(Z, X, W).

%%%%%%%% error/2 %%%%%%%%%%%%%%%%%%%%%%%%
% Escribe un mensaje de error
% concatenando ambos parámetros, y
% devuelve fail sin opción a backtracking
error(X, Y) :- write(X), write(Y), nl, !, fail.
