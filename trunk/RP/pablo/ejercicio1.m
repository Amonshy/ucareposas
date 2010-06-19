% a. generamos los datos
rand('seed',0);
X = fix(rand(1,30)*100);

% b. Determinar cuántos valores hay en los intervalos
% [0-9],[10-19],[20-29]…[90-99]
a=hist(X) % en a están el número de valores de cada intervalo

% c. Analizar qué hacen las siguientes instrucciones:
hist(X)% muestra el histograma de X
[a,b]=hist(X)% en a están el número de valores de cada intervalo y en b la posición de cada centro de cada barra
a=hist(X,5:10:95);% histograma de 10 barras del 5 al 95
[a,b]=hist(X,5:10:95);% histograma de 10 barras con los centros del 5 al 95 de 10 en 10

% d. ¿Qué representan la primera y la última barra del histograma?
% la primera barra representa todos los valores desde -inf al 1º centro y
% la última los valores desde el centro de la última barra a +inf

% e. ¿Cuánto vale sum(a)?
sum(a) % vale 30, evidentemente, porque eran 30 datos

% f. ¿Cómo convierto los valores del histograma a probabilidades, o sea,
% a la probabilidad de que tomando un pez al azar esté en uno de los intervalos usados en la construcción del histograma?
a/length(X)

% g. ¿Cuánto suman todas las probabilidades?
sum(a/length(X))

% h. Generar 1000 datos como en el paso A, y determinar qué sucede si el
% número de intervalos utilizado es demasiado grande o demasiado pequeño.
rand('seed',0);
X = fix(rand(1,1000)*100);
hist(X,5)
hist(X,1000)

% i. Generar 100000 datos como en el paso A, determinar un buen nº de
% intervalos y observar el histograma. ¿Qué ocurre?
rand('seed',0);
X = fix(rand(1,100000)*100);
hist(X,100) % el 100 se saca de la manga
