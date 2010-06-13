rand('seed', 0);
randn('seed', 0);

m1 = [0; 0]; C1 = [1 0.8; 0.8 2];
m2 = [3; 3]; C2 = [1 -0.9; -0.9 2];
clase1 = randnorm(m1, C1, 1000);
clase2 = randnorm(m2, C2, 1000);
%Clase a la que pertenecen
y = [ones(1, 1000) ones(1, 1000)*2];
%barajamos
[x, y] = shuffle([x1 x2], y);
m = meanpat(x);

% a) Realizar un clasificador de mínima distancia con los primeros 1600 
% datos

xtrn = x(:,1:1600);
ytrn = y(:,1:1600);

xtest = x(:,1601:end);
ytest = y(:,1601:end);
%Entrenamiento
modelo = zeros(size(xtrn,1),2);
for i=1:2,
    modelo(:,i) = meanpat(xtrn(:,find(ytrn==i)));
end;

%Clasificación
for i=1:2,
    media = modelo(:,i);
    dist(i,:)=d_euclid(xtest,media);
end;
[dummy,y] = min(dist);
error = sum(ytest ~= y)/size(y,2) * 100


% % b) Convertir los datos al espacio PCA y realizar el clasificador de míni-
% % ma distancia. ¿Qué procedimiento da mejores resultados de clasificación 
% % en los 400 datos restantes? Es razonable el resultado obtenido.
disp('PCA');
xtrn1 = subpat(xtrn,meanpat(xtrn));
W = pca(xtrn1);

datos = W * xtrn;

%Entrenamiento
modelo = zeros(size(datos,1),2);
for i=1:2,
    modelo(:,i) = meanpat(datos(:,find(ytrn==i)));
end;

xtest1 = W*xtest;

%Clasificación
for i=1:2,
    media = modelo(:,i);
    dist(i,:)=d_euclid(xtest1,media);
end;
[dummy,y] = min(dist);
error = sum(ytest ~= y)/size(y,2) * 100


% % c) ¿Puedes predecir qué ocurre si usas Fisher?
disp('Fisher');
W = fisher(xtrn,ytrn);

datos = W * xtrn;

%Entrenamiento
modelo = zeros(size(datos,1),2);
for i=1:2,
    modelo(:,i) = meanpat(datos(:,find(ytrn==i)));
end;

xtest1 = W*xtest;

%Clasificación
for i=1:2,
    media = modelo(:,i);
    dist(i,:)=d_euclid(xtest1,media);
end;
[dummy,y] = min(dist);
error = sum(ytest ~= y)/size(y,2) * 100

% e) ¿Cómo son las fronteras entre una clase y otra? ¿Puedes dibujarlas?
plotbon(m1, C1, m2, C2,'k'); hold on;
plotpat(x, y); hold off;