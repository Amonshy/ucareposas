% a. generamos los datos
rand('seed',0);
X = fix(rand(1,30)*100);

% b. Determinar cu�ntos valores hay en los intervalos
% [0-9],[10-19],[20-29]�[90-99]
a=hist(X) % en a est�n el n�mero de valores de cada intervalo

% c. Analizar qu� hacen las siguientes instrucciones:
hist(X)% muestra el histograma de X
[a,b]=hist(X)% en a est�n el n�mero de valores de cada intervalo y en b la posici�n de cada centro de cada barra
a=hist(X,5:10:95);% histograma de 10 barras del 5 al 95
[a,b]=hist(X,5:10:95);% histograma de 10 barras con los centros del 5 al 95 de 10 en 10

% d. �Qu� representan la primera y la �ltima barra del histograma?
% la primera barra representa todos los valores desde -inf al 1� centro y
% la �ltima los valores desde el centro de la �ltima barra a +inf

% e. �Cu�nto vale sum(a)?
sum(a) % vale 30, evidentemente, porque eran 30 datos

% f. �C�mo convierto los valores del histograma a probabilidades, o sea,
% a la probabilidad de que tomando un pez al azar est� en uno de los intervalos usados en la construcci�n del histograma?
a/length(X)

% g. �Cu�nto suman todas las probabilidades?
sum(a/length(X))

% h. Generar 1000 datos como en el paso A, y determinar qu� sucede si el
% n�mero de intervalos utilizado es demasiado grande o demasiado peque�o.
rand('seed',0);
X = fix(rand(1,1000)*100);
hist(X,5)
hist(X,1000)

% i. Generar 100000 datos como en el paso A, determinar un buen n� de
% intervalos y observar el histograma. �Qu� ocurre?
rand('seed',0);
X = fix(rand(1,100000)*100);
hist(X,100) % el 100 se saca de la manga
