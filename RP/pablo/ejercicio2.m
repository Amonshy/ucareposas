% a. Generar 100000 datos con la distribuci�n uniforme, y otros 100000 con
% distribuci�n normal de la siguiente forma:
X = rand(1,100000);
Y = randn(1,100000);

% b. Obtener sus histogramas, y analizar ambas distribuciones en cuanto a
% la forma del histograma, media de los datos, rango de los datos, suma de 
% los valores del histograma, m�nimo y m�ximo de los datos y a la altura de
% la m�xima barra del histograma. Repetir varias veces el paso a) si es preciso.

% histogramas
hist(X);
hist(Y);% forma gaussiana

% media
mean(X)
mean(Y)

% suma de los valores del histograma
sum(hist(X))
sum(hist(Y))

% m�nimo y m�ximo
min(X)
max(X)
min(Y)
max(Y)

% altura de la barra m�s alta
max(hist(X))
max(hist(Y))

% c. Determinar la media y la desviaci�n standard de la distribuci�n Y
m=mean(Y)
s=std(Y)

% d. Encontrar cu�ntos datos de Y (en porcentaje) se encuentran en los
% intervalos definidos como [m-s,m+s], [m-2s,m+2s], [m-3s,m+3s] respectivamente.
length(find(Y > m-s & Y < m+s))/length(Y)
length(find(Y > m-2*s & Y < m+2*s))/length(Y)
length(find(Y > m-3*s & Y < m+3*s))/length(Y)
