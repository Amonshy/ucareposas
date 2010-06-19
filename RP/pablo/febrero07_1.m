clear all;
close all;

load IRIS;

% Distancia Euclidea
%Entrenamiento
modelo = zeros(size(x,1),3);

for i =1:3,
    modelo(:,i) = meanpat(x(:,find(y==(i-1))));
end;

%Clasificacion

for i = 1:3,
    media=modelo(:,i);
    d(i,:) = d_euclid(x,media);
end;

[basura,yout] = min(d);

yout=yout-1;

error = sum(y ~= yout)/size(yout,2) * 100;

%Distancia Mahalanobis

%Entrenamiento
modelo = zeros(size(x,1),3);
cov = covpat(x);
for i =1:3,
    modelo(:,i) = meanpat(x(:,find(y==(i-1))));
end;

%Clasificacion

for i = 1:3,
    media=modelo(:,i);
    d(i,:) = d_mahal(x,media,cov);
end;

[basura,yout] = min(d);

yout=yout-1;

error = sum(y ~= yout)/size(yout,2) * 100;

% Apartado b)

N = size(x,2);
d = [];
eEu = 0;
eMa = 0;
for i=1:N
    [xtrn,xtst,ytrn,ytst] = crossval(x,y,N,i);
    
    %Entrenamiento Euclidea
    modelo = zeros(size(xtrn,1),3);

    for i =1:3,
        modelo(:,i) = meanpat(xtrn(:,find(ytrn==(i-1))));
    end;

    %Clasificacion Euclidea
    for i = 1:3,
        media=modelo(:,i);
        d(i,:) = d_euclid(xtst,media);
    end;
    yout = [];
    [basura,yout] = min(d);
    yout=yout-1;
    
    eEu = eEu + (ytst ~= yout);
    
    %Entrenamiento Mahalanobis
    modelo = zeros(size(xtrn,1),3);
    cov = covpat(xtrn);
    for i =1:3,
        modelo(:,i) = meanpat(xtrn(:,find(ytrn==(i-1))));
    end;

    %Clasificacion Mahalanobis
    for i = 1:3,
        media=modelo(:,i);
        d(i,:) = d_mahal(xtst,media,cov);
    end;
    [basura,yout] = min(d);
    yout=yout-1;
    
    eMa = eMa + (ytst ~= yout);
    
end;

disp(['Error Euclidea: ' num2str((eEu/N)*100)]);
disp(['Error Mahalanobis: ' num2str((eMa/N)*100)]);