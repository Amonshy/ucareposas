clear all;

load housing;

x = p;
y = t;

rand('seed',0);

[x, y] = shuffle(x,y);

xtrn = x(:,1:400);
ytrn = y(:,1:400);

xtst = x(:,401:end);
ytst = y(:,401:end);

clc
% apartado a)
A = [ xtrn' ones(size(xtrn,2),1) ];

coefs = pinv(A)*ytrn';

yout = [ xtst' ones(size(xtst,2),1)]*coefs;

dif = yout - ytst';

error = sum(dif.^2)

% apartado b)
W = pca(xtrn,5);

xtrnp = W * xtrn;

A = [ xtrnp' ones(size(xtrn,2),1) ];

coefs = pinv(A)*ytrn';

yout = [ (W*xtst)' ones(size(xtst,2),1)]*coefs;

dif = yout - ytst';

error = sum(dif.^2)

% apartado c)
W = pca(xtrn,4);

xtrnp = W * xtrn;

A = [ xtrnp' ones(size(xtrn,2),1) ];

coefs = pinv(A)*ytrn';

yout = [ (W*xtst)' ones(size(xtst,2),1)]*coefs;

dif = yout - ytst';

error = sum(dif.^2)

% apartado d)
W = pca(xtrn,3);

xtrnp = W * xtrn;

A = [ xtrnp' ones(size(xtrn,2),1) ];

coefs = pinv(A)*ytrn';

yout = [ (W*xtst)' ones(size(xtst,2),1)]*coefs;

dif = yout - ytst';

error = sum(dif.^2)