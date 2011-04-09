objetivo(Ave) :- ave(Ave).

%ave(X) :-
%        preguntar(ave, X).


agujero_en_pico(X) :-
        preguntar('agujero_en_pico', X).

alas(X) :-
        preguntar(alas, X).

cabeza(X) :-
        preguntar(cabeza, X).

comida(X) :-
        preguntar(comida, X).

cola(X) :-
        preguntar(cola, X).

color(X) :-
        preguntar(color,X).

cuello(X) :-
        preguntar(cuello, X).

estacion(X) :-
        preguntar(estacion, X).

estado(X) :-
        preguntar(estado, X).



garganta(X) :-
        preguntar(garganta,X).

habita_en(X) :-
        preguntar('habita_en', X).



pais(X) :-
        preguntar(pais, X).

patas(X) :-
        preguntar(patas, X).

perfil_del_vuelo(X) :-
        preguntar(perfil_del_vuelo, X).

pico(X) :-
        preguntar(pico, X).

provincia(X) :-
        preguntar(provincia, X).

region(X) :-
        preguntar(region, X).

sonido(X) :-
        preguntar(sonido, X).

tamano(X) :-
        preguntar(tamano, X).
        
vuelo(X) :-
        preguntar(vuelo, X).
%vuelo(X) :- menu(vuelo, X, [agil,pesado, potente]).


% Orden
orden(acuatica):- patas(palmeadas), pico(plano).
orden(falconiforme):- comida(carne), patas(garras_curvas), pico('ganchudo y afilado').
orden(paseriforme):- patas('una garra larga hacia atras').
orden(tubinar):- agujero_en_pico('tubular externo'),habita_en(mar), pico(ganchudo).
orden(X) :- preguntar(orden, X).

% Familia

familia(albatros):- orden(tubinar), tamano(grande), alas('largas y estrechas').
familia(buitre):- orden(falconiforme), comida(carrona),alas(anchas).
familia(cisne):- orden(acuatica), cuello(largo), color(blanco), vuelo(pesado).
familia(ganso):- orden(acuatica), tamano(grueso), vuelo(potente).
familia(golondrina):- orden(paseriforme), alas('largas y afiladas'), pico(corto).
familia(halcon):- orden(falconiforme), alas('largas y afiladas'), cabeza(grande), cola('estrecha en la punta').
familia(papamoscas):- orden(paseriforme), pico(plano), comida('insectos voladores').
familia(pato):- orden(acuatica), comida('sobre la superficie del agua'), vuelo(agil).
familia(petrel):- orden(tubinar), tamano(mediano).
familia(X) :- preguntar(familia, X).

% Ave

ave('buitre de cabeza roja'):- familia(buitre), perfil_del_vuelo('forma de v').
ave('cernicalo americano'):- familia(halcon), comida(insectos).
ave('condor de California'):- familia(buitre), perfil_del_vuelo('planeador').
ave('golondrina comun'):- familia(golondrina), cola(bifida).
ave('golondrina risquera'):- familia(golondrina), cola(cuadrada).
ave('golondrina azulnegra'):- familia(golondrina), color(oscuro).
ave('Halcon peregrino'):- familia(halcon), comida(pajaros).
ave('papamoscas viajero'):- familia(papamoscas), cola('larga color oxido').
ave('papamoscas cenizo'):- familia(papamoscas), garganta(blanca).
ave('pato maicero'):- familia(pato), sonido('silbido corto').

% Zonas geograficas
pais('Estados Unidos'):-
region('Nueva Inglaterra'); region(sureste);
region('zona norte central'); region('suroeste');
region(noroeste); region('Atlantico medio').
pais('Canada'):-
provincia(ontario); provincia(quebec);
provincia(etc).
region('Nueva Inglaterra'):-
estado(X), member(X,[massachusetts, vermont,etc]).
region(sureste):-
estado(X), member(X,[florida,mississippi,etc]).
