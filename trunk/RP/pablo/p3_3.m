load iris;

pat = x(2:3,:);

clase1 = pat(:,find(y==1));
clase2 = pat(:,find(y==2));
clase3 = pat(:,find(y==3));

m1 = meanpat(clase1);
m2 = meanpat(clase2);
m3 = meanpat(clase3);

c1 = covpat(clase1);
c2 = covpat(clase2);
c3 = covpat(clase3);

plotpat(x,y);
