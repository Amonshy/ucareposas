
principal(ArchivoEntrada,ArchivoSalida):- see(ArchivoEntrada),tell(ArchivoSalida),write('marco(deporte, []).\n'),procesar_fichero,seen,told.

%Leemos y escribimos línea a línea el fichero
%---------------------------------------------

procesar_fichero:-get0(X),X\== -1,leer_datos(X),get0(_),get0(SaltoLinea),put(SaltoLinea),procesar_fichero,!.
procesar_fichero:-!.

%Leemos y escribimos los datos. Las características de los deportes se encuentran en una lista.
%----------------------------------------------------------------------------------------------
leer_datos(C):-  Lista = ['categoria','instalacion','accesorio','jugadores','otros','nombre'],leer_nombre(C,Lista).

%Comenzamos leyendo el nombre del deporte
leer_nombre(59,Lista):- write(', [es-[val([deporte])],'),get0(C),leer_primero(C,Lista,1),!.
leer_nombre(C,Lista):- write('marco('),put(C),get0(X),leer_nombre_recur(X,Lista).

leer_nombre_recur(59,Lista):- leer_nombre(59,Lista),!.                                        
leer_nombre_recur(C,Lista):- put(C),get0(X),leer_nombre_recur(X,Lista).

%Con este predicado comprobamos que característica es la primera.
leer_primero(59,Lista,Cont):-Cont0 is Cont + 1,get0(C),leer_primero(C,Lista,Cont0),!.
leer_primero(C,Lista,Cont):- leer(C,Lista,Cont).

%Si se han procesado las 6 características se finaliza de leer y escribir
leer(_,_,7):- write(']).'),!.
leer(59,Lista,Cont):- get0(X),X\==59,X\==46,write(','),Cont0 is Cont + 1,leer(X,Lista,Cont0),!.
leer(59,Lista,Cont):- Cont0 is Cont + 1,leer(_,Lista,Cont0),!.
leer(C,Lista,Cont):-elemento(Lista,Cont,Atributo),write(Atributo),write('-[val(['),put(C),get0(X),leer_recur(X,Lista,Cont).

leer_recur(44,Lista,Cont):-write(','),get0(X),leer_recur(X,Lista,Cont),!.  
leer_recur(59,Lista,Cont):-write('])]'),leer(59,Lista,Cont),!.                                        
leer_recur(C,Lista,Cont):- put(C),get0(X),leer_recur(X,Lista,Cont).

%Predicado que obtiene el elemento n-ésimo de una lista
%-------------------------------------------------------
elemento([E|_],1,E):- !.
elemento([_|F],N,E):- N0 is N - 1,elemento(F,N0,E).
