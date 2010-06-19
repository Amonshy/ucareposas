% clear all;
% 
% A = [28.53 22.93 19.33 17.73 18.13 20.53 24.93 31.33 39.73 50.13; 
%      21.13 15.53 11.93 10.33 10.73 13.13 17.53 23.93 32.33 42.73;
%      15.73 10.13  6.53  4.93  5.33  7.73 12.13 18.53 26.93 37.33;
%      12.33  6.73  3.13  1.53  1.93  4.33  8.73 15.13 23.53 33.93;
%      10.93  5.33  1.73  0.13  0.53  2.93  7.33 13.73 22.13 32.53;
%      11.53  5.93  2.33  0.73  1.13  3.53  7.93 14.33 22.73 33.13;
%      14.13  8.53  4.93  3.33  3.73  6.13 10.53 16.93 25.33 35.73;
%      18.73 13.13  9.53  7.93  8.33 10.73 15.13 21.53 29.93 40.33;
%      25.33 19.73 16.13 14.53 14.93 17.33 21.73 28.13 36.53 46.93;
%      33.93 28.33 24.73 23.13 23.53 25.93 30.33 36.73 45.13 55.53];
%  
% 
%  % Apartado a)
%  
% [valores, minPorColumna] = min (A);
% 
% [basura, x] = min(valores);
% 
% y = minPorColumna(x);
% 
% disp(['x = ' num2str(x) ' e Y = ' num2str(y) ]); 
% 
% % Apartado b)
% 
% 
% minimo = [x y];
% [x,y]=meshgrid(1:10,1:10);
% 
% Areg = [ x(:).^2 y(:).^2 x(:) y(:) ones(size(x(:)))];
% 
% coefs = pinv(Areg)*A(:);
% 
% maximoaprox=inv([2*coefs(1) 0;0 2*coefs(2)])*[-coefs(3);-coefs(4)]
clear all
load DIABETES

%Como es un problema de regresión usamos PCA

x = subpat(x,meanpat(x));
W = pca(x,2);
x1 = W * x;

A = [x1; ones(1,size(x1,2))]';
b = y';
coefs = pinv(A) * b;

salida = A * coefs;
error_pca = sumsqr(salida-y');
fprintf('Error pca: %f \n',error_pca);

%Probamos con Fisher

W = fisher(x,y,2);
x1 = W * x;

A = [x1; ones(1,size(x1,2))]';
b = y';
coefs = pinv(A) * b;

salida = A * coefs;
error_fisher = sumsqr(salida-y');
fprintf('Error fisher: %f \n',error_fisher);
