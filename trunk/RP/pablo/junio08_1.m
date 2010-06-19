clear all;
close all;

load cancer;


W = fisher(x,y,2);

xp = W * x;

%Apartado a)

clase1 = xp(:,find(y==1));
clase0 = xp(:,find(y==0));

m0 = meanpat(clase0);
m1 = meanpat(clase1);

c0 = covpat(clase0);
c1 = covpat(clase1);

disp(['Distancia del ultimo punto a clase 0:' num2str(d_mahal(xp(:,end),m0,c0))]);
disp(['Distancia del ultimo punto a clase 1:' num2str(d_mahal(xp(:,end),m1,c1))]);


% Apartado b)
numCentros = 3;

centrosIniciales0 = clase0(:,1:numCentros);
centrosIniciales1 = clase1(:,1:numCentros);

centros0 = kmeans(clase1,numCentros,centrosIniciales0);
centros1 = kmeans(clase1,numCentros,centrosIniciales1);

distancias = [];
for i=1:numCentros,
    distancias = [ distancias; d_euclid(xp,centros0(:,i)); d_euclid(xp,centros1(:,i)) ];
end;
[basura,yout] = min(distancias);
yout = (rem(yout, 2) == 0);

plotpat(xp,yout);

