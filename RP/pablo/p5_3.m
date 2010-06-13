
% load dnatrn
% 
% 
% m = meanpat(x);
% x = subpat(x, m);
% Wpca = pca(x, 2);
% x1pca = Wpca * x;
% plotpat(x1pca, y);
% 
% load dnatrn
% Wf = fisher(x, y, 2);
% x1f = Wf * x;
% figure, plotpat(x1f, y);


%CON PCA

load diabetes


m = meanpat(x);
x = subpat(x, m);
Wpca = pca(x, 2);
x1pca = Wpca * x;
% plotpat(x1pca, y);

%Calcular el modelo lineal
A = [x1pca(1, :)' ones(size(x1pca(1, :)'))];
yreal = x1pca(2, :);
sol = pinv(A) * yreal';
ejex = minmax(x1pca(1, :));
xr = ejex(1)-1:1:ejex(2)+1;
ycalc = sol(1)*xr + sol(2);
figure, plot(xr, ycalc);
E=sum((yp-(sol(1)*x1pca(1,:)+sol(2))).^2)


%CON FIHSER
load diabetes


Wf = fisher(x, y, 2);
x1f = Wf * x;
plotpat(x1f);

%Calcular el modelo lineal
Af = [x1f(1, :)' ones(size(x1f(1, :)'))];
yf = x1f(2, :);
sol = pinv(Af) * yf';
ejex = minmax(x1f(1, :));
xr = ejex(1)-1:1:ejex(2)+1;
yr = sol(1)*xr + sol(2);
figure, plot(xr, yr);
E=sum((yp-(sol(1)*x1pca(1,:)+sol(2))).^2)