rand('seed', 0);
randn('seed', 0);


m1 = [3;4];
m2 = [5;0];

c = [1 0.8;0.8 1];

clase1 = randnorm(m1,c, 1000);
clase2 = randnorm(m2,c, 1000);

% c) Calcular la matriz de PCA, convertir los datos originales al espacio PCA, 
% y dibujar los datos convertidos
clase1 = subpat(clase1, meanpat(clase1));
clase2 = subpat(clase2, meanpat(clase2));
W1 = pca(clase1);
W2 = pca(clase2);
x1 = W1 * clase1;
x2 = W2 * clase2;
plotpat(x1, '.b'); hold on;
plotpat(x2, '.r'); hold off;

% d) Calcular la matriz de Fisher, convertir los datos originales al espacio 
% FISHER, y dibujar los datos convertidos
x = [clase1 clase2];
y = [zeros(1, size(clase1, 2)) ones(1, size(clase2, 2))];
W = fisher(x, y);
x1 = W * x;
plotpat(x1, '.b'); hold on;
plotpat(x, '.r'); hold off;