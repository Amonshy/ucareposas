clc
clear all
close all

load iris
y = y+1;

for k=1:20,

  k
  
xtrn = x(:,1:110);
ytrn = y(1:110);

xtst = x(:,111:150);
ytst = y(111:150);

% ENTRENAMIENTO - ESTIMACION DE PARAMETROS
ind = find(ytrn==1);
m1 = meanpat(xtrn(:,ind));
C1 = covpat(xtrn(:,ind));

ind = find(ytrn==2);
m2 = meanpat(xtrn(:,ind));
C2 = covpat(xtrn(:,ind));

ind = find(ytrn==3);
m3 = meanpat(xtrn(:,ind));
C3 = covpat(xtrn(:,ind));

% ------------------------------------------------------

% TEST
for i=1:length(ytst),
  s(1) = densidadND(xtst(:,i),m1,C1);
  s(2) = densidadND(xtst(:,i),m2,C2);
  s(3) = densidadND(xtst(:,i),m3,C3);  
  [basura,clase(i)]=max(s);
end

porcentaje(k) = 100 * length(find(clase==ytst)) / length(ytst)

[x,y]=shuffle(x,y);

end