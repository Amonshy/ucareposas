function mix = vectorShuffle (v1, v2)
% mix = vectorShuffle (v1, v2)
% Función que recibe dos vectores como parámetros y los mezlca y ordena
% aleatoriamente

%Primero creamos un vector que contiene ambos vectores uno a continuación
%del otro
concatenacion = [ v1 v2 ];

%Ahora creamos un vector aleatorio que indica las posiciones el orden de
%las posiciones en la que colocaremos los elementos del vector
%concatenacion
orden = randperm(length(concatenacion));

%Creamos un vector aleatorio cogiendo la entrada que nos indique el vector
%orden,que contiene una permutacion posible de todos los elementos del
%vector concatenacion e indica el orden que ocupara un determinado
%elemento.
mix = concatenacion(:,orden(1));

for i = 2:length(concatenacion)
    mix = [ mix concatenacion(:,orden(i)) ];
end
