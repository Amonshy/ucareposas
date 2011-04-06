%BASE DE CONOCIMIENTOS DE AVES%

%Objetivo
%La finalidad de objetivo es crear un predicado de manera que no sea necesario modificar el código del objetivo a alcanzar en el shell. En el shell tendremos objetivo(X) y en nuestra Base de conocimiento tendremo objetivo(X) :- predicado(X).
objetivo(Ave) :- ave(Ave).

% Orden
% Predicado que hace referencia al orden al que pertencen las aves, incluyendo las características asociadas, que a su vez vuelves a ser predicados o atributos directos.
orden('tubinar'):-
	agujero_en_pico('tubular externo'),
	habitat('mar'),
	pico('ganchudo').
orden('acuatica'):-
	patas('palmeadas'),
	pico('plano').
orden('falconiforme'):-
	alimentacion('carne'),
	patas('garras curvas'),
	pico('ganchudo y afilado').
orden('paseriforme'):-
	patas('una garra larga hacia atras').
orden(X) :-
	preguntar('Orden', X).

% Familia
% Predicado que hace referencia a la familia a la que pertencen las aves, incluyendo las características asociadas, que a su vez vuelves a ser predicados o atributos directos.
familia('albatros'):-
	orden('tubinar'),
	tamano('grande'),
	alas('largas y estrechas').
familia('petrel'):-
	orden('tubinar'),
	tamano('mediano').
familia('cisne'):-
	orden('acuatica'),
	cuello('largo'),
	color('blanco'),
	vuelo('pesado').
familia('ganso'):-
	orden('acuatica'),
	tamano('grueso'),
	vuelo('potente').
familia('pato'):-
	orden('acuatica'),
	alimentacion('sobre la superficie del agua'),
	vuelo('agil').
familia('buitre'):-
	orden('falconiforme'),
	alimentacion('carroña'),
	alas('anchas').
familia('halcon'):-
	orden('falconiforme'),
	alas('largas y afiladas'),
	cabeza('grande'),
	cola('estrecha en la punta').
familia('papamoscas'):-
	orden('paseriforme'),
	pico('plano'),
	alimentacion('insectos voladores').
familia('golondrina'):-
	orden('paseriforme'),
	alas('largas y afiladas'),
	pico('corto').
familia(X) :-
	preguntar('Familia', X).

% Ave
%Algunas aves objetivo y cuales son las características que las definen.
ave('pato maicero'):-
	familia('pato'),
	sonido('silbido corto').
ave('buitre de cabeza roja'):-
	familia('buitre'),
	perfil_del_vuelo('forma de v').
ave('condor de California'):-
	familia('buitre'),
	perfil_del_vuelo('planeador').
ave('cernicalo americano'):-
	familia('halcon'),
	alimentacion('insectos').
ave('Halcon peregrino'):-
	familia('halcon'),
	alimentacion('pajaros').
ave('papamoscas viajero'):-
	familia('papamoscas'),
	cola('larga color oxido').
ave('papamoscas cenizo'):-
	familia('papamoscas'),
	color_cuello('blanca').
ave('golondrina comun'):-
	familia('golondrina'),
	cola('bifida').
ave('golondrina risquera'):-
	familia('golondrina'),
	cola('cuadrada').
ave('golondrina azulnegra'):-
	familia('golondrina'),
	color('oscuro').
ave(X) :-
	preguntar('Ave', X).

% Predicados que hacen alusión a las preguntas que se le va a realizar al usuario, en este caso se asocia un predicado del atributo X a la pregunta de ese atributo con un valor determinado Y, por ejemplo si X = pico e Y = ganchudo, esto preguntará si el pico es ganchudo. El comportamiento de preguntar está definido en el shell.
pico(X) :-
	preguntar('Pico', X).

agujero_en_pico(X) :-
	preguntar('Agujero', X).

alas(X) :-
	preguntar('Alas', X).

vuelo(X) :-
	preguntar('Vuelo', X).

perfil_de_vuelo(X) :-
	preguntar('Perfil de vuelo', X).

color_cuello(X) :-
	preguntar('Color cuello',X).

habitat(X) :-
	preguntar('Habitat', X).

alimentacion(X) :-
	preguntar('Alimentacion', X).

color(X) :-
	preguntar('Color',X).

provincia(X) :-
	preguntar('Provincia', X).

estado(X) :-
	preguntar('Estado', X).

tamano(X) :-
	preguntar('tamano', X).

cuello(X) :-
	preguntar('Cuello', X).

patas(X) :-
	preguntar('Patas', X).

sonido(X) :-
	preguntar('Sonido', X).

cola(X) :-
	preguntar('Cola', X).


% Zonas geograficas
% Las zonas geográficas distribuidas en paises y regiones dentro de esos paises.
pais('Estados Unidos'):-
	region('Nueva Inglaterra');
	region('sureste');
	region('zona norte central');
	region('suroeste');
	region('noroeste');
	region('Atlantico medio').
pais('Canada'):-
	provincia('ontario');
	provincia('quebec');
	provincia('etc').
pais(X) :-
	preguntar('Pais', X).

region('Nueva Inglaterra'):-
	estado(X),
	member(X,[massachusetts, vermont,etc]).
region('sureste'):-
	estado(X),
	member(X,[florida,mississippi,etc]).
region(X) :-
	preguntar('Region', X).



