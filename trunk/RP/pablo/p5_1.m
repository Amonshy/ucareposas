rand('seed',0);
randn('seed',0);

m = [ 3 4];
c = [1 0.8;0.8 1];

N = 1000;

x = randnorm(m,c,N);

xprim = subpat(x,m');

W = pca(xprim);

x1 = W*xprim;

plotpat(xprim,'.g');
hold on;
plotpat(x1,'.b')
hold off;

x2 = pinv(W)*x1;

plotpat(x2,'.g');
hold on;
plotpat(xprim,'xb')
hold off;

% % Para una dimension
% 
% W1 = pca(xprim,1);
% 
% xpp = W1 * xprim;
% 
% reconvertidos = pinv(W1) * xpp;
% 
% error = sqrt(sumsqr(reconvertidos-xprim));
% 
% W2 = W1 + 5;
% 
% xppp = W2 * xprim;
% 
% reconvertidos2 = pinv(W2) * xppp;
% 
% error2 = sqrt(sumsqr(reconvertidos2-xprim));
% 
