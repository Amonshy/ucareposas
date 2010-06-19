clear all;
close all;

load cancer;

W = fisher(x,y,2);

xp = W * x;

m0 = meanpat(xp(:,find(y==0)));
c0 = covpat(xp(:,find(y==0)));

m1 = meanpat(xp(:,find(y==1)));
c1 = covpat(xp(:,find(y==1)));

dist0 = d_mahal(xp(:,end),m0,c0)
dist1 = d_mahal(xp(:,end),m1,c1)


%Apartado b)

n = 1;

clase0 = xp(:,find(y==0));
clase1 = xp(:,find(y==1));

centros0 = kmeans(clase0,n,clase0(:,1:n));
centros1 = kmeans(clase1,n,clase1(:,1:n));
d = [];
for i = 1:n,
    d = [d; d_euclid(xp, centros0(:, i)); 
            d_euclid(xp, centros1(:, i))];
end;
[basura, yout] = min(d);
yout = (rem(yout, 2) == 0);


plotpat(xp,yout); hold on;
plotpat(centros0,'ob'); hold on;
plotpat(centros1,'ok');hold on;
plotpat(m0,'xb'); hold on;
plotpat(m1,'xk');