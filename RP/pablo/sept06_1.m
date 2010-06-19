clear all;
close all;

load abalone_dataset;

primeraFila = (abaloneInputs(1,:) == 0);
segundaFila = (abaloneInputs(1,:) == 1);
terceraFila = (abaloneInputs(1,:) == 2);

x = [primeraFila; segundaFila; terceraFila; abaloneInputs(2:end,:)];
y = abaloneTargets;


xtrn = x(:,1:3133);
ytrn = y(:,1:3133);

xtst = x(:,3134:end);
ytst = y(:,3134:end);

N = 10;

for i = 1:N,
   [xtrnp xtstp ytrnp ytstp] = crossval(xtrn,ytrn,N,i);
   
   %PCA
   for j=size(xtrnp,1):-1:1,
       W = pca(xtrnp,j);
       x1 = W * xtrnp;
       
       A1 = [ x1' ones(size(x1,2),1) ];
       b = ytrnp';
       coefs = pinv(A1)*b;
       
       x2 = W * xtstp;
       A2 = [ x2' ones(size(x2,2),1) ];
       
       salida = A2 * coefs;
       
       errores(i,j) = 100*mean(round(salida) ~= ytstp');
   end;
end

errorPorCadaPCA = meanpat(errores');
