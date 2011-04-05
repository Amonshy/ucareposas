% preguntar(Atributo, Valor) :-
% 	write(Atributo:Valor),
% 	write('? '), read(si).

predicadoDeObjetivo(X) :- ave(X).

orden(X) :-
	preguntar(Orden, X).

familia(X) :-
	preguntar(Familia, X).

ave(X) :-
	preguntar(Ave, X).

tipo_de_pico(X) :-
	preguntar(Pico, X).

agujero_en_pico(X) :-
	preguntar(Agujero, X).

alas(X) :-
	preguntar(Alas, X).

color_cuerpo(X) :-
	preguntar('Color cuerpo',X).

color_cara(X) :-
	preguntar('Color cara', X).

color_cuello(X) :-
	preguntar('Color cuello',X).

habitat(X) :-
	preguntar(Habitat, X).

estacion(X) :-
	preguntar(Estacion, X).

provincia(X) :-
	preguntar(Provincia, X).

estado(X) :-
	preguntar(Estado, X).

alimentacion(X) :-
	preguntar(Alimentacion, X).

tamano(X) :-
	preguntar(Tamano, X).

pais(X) :-
	preguntar(Pais, X).

region(X) :-
	preguntar(Region, X).

cuello(X) :-
	preguntar(Cuello, X).

patas(X) :-
	preguntar(Patas, X).

sonido(X) :-
	preguntar(Sonido, X).

cola(X) :-
	preguntar(Cola, X).

vuelo(X) :-
	preguntar(Vuelo, X).


vuelo(X) :- menu(Vuelo, X, [pesado, potente]).
menu(Atributo, Valor, Opciones) :-
	write('Valor para '), write(Atributo),
	write('? '), nl, write(Opciones), nl,
	read(X),
	comprobar(X, Atributo, Valor, Opciones),
	asserta(conocido(si, Atributo, Valor)),
	X == Valor.

comprobar(X, Atributo, Valor, Opciones) :-
	member(X, Opciones), !.

comprobar(X, Atributo, Valor, Opciones) :-
	write(X), write(' no valido.'), nl,
	menu(Atributo, Valor, Opciones).	
	
% Orden
orden(tubinar):-
agujero_en_la_nariz('tubular externo'),
habita_en(mar), pico(ganchudo).
orden(acuatica):-
patas(palmeadas), pico(plano).
orden(falconiforme):-
comida(carne), patas(garras_curvas),
pico('ganchudo y afilado').
orden(paseriforme):-
patas('una garra larga hacia atras').

% Familia
familia(albatros):-
orden(tubinar), tamano(grande), alas('largas y estrechas').
familia(petrel):-
orden(tubinar), tamano(mediano).
familia(cisne):-
orden(acuatica), cuello(largo), color(blanco),
vuelo(pesado).
familia(ganso):-
orden(acuatica), tamano(grueso),
vuelo(potente).
familia(pato):-
orden(acuatica), comida('sobre la superficie del agua'), vuelo(agil).
familia(buitre):-
orden(falconiforme), comida(carrona),
alas(anchas).
familia(halcon):-
orden(falconiforme),
alas('largas y afiladas'),
cabeza(grande), cola('estrecha en la punta').
familia(papamoscas):-
orden(paseriforme), pico(plano), comida('insectos voladores').
familia(golondrina):-
orden(paseriforme), alas('largas y afiladas'),
pico(corto).

% Ave
ave('pato maicero'):-
familia(pato), sonido('silbido corto').
ave('buitre de cabeza roja'):-
familia(buitre), perfil_del_vuelo('forma de v').
ave('condor de California'):-
familia(buitre), perfil_del_vuelo('planeador').
ave('cernicalo americano'):-
familia(halcon), comida(insectos).
ave('Halcon peregrino'):-
familia(halcon), comida(pajaros).
ave('papamoscas viajero'):-
familia(papamoscas), cola('larga color oxido').
ave('papamoscas cenizo'):-
familia(papamoscas), garganta(blanca).
ave('golondrina comun'):-
familia(golondrina), cola(bifida).
ave('golondrina risquera'):-
familia(golondrina), cola(cuadrada).
ave('golondrina azulnegra'):-
familia(golondrina), color(oscuro).

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
