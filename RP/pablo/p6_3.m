clear all;

rand('seed', 0);
randn('seed', 0);

m1 = [0; 0]; C1 = [1 0.8; 0.8 2];
m2 = [3; 3]; C2 = [1 -0.9; -0.9 2];

clase1 = randnorm(m1, C1, 1000);
clase2 = randnorm(m2, C2, 1000);

y = [ones(1, 1000) ones(1, 1000)+1];
[x, y] = shuffle([clase1 clase2], y);


x1 = x(:, find(y(1:1600) == 1)); c1 = covpat(x1);
x2 = x(:, find(y(1:1600) == 2)); c2 = covpat(x2);

xtest = x(:,1601:end);
ytest = y(:,1601:end);

errores = zeros(1, 5);
for k = 1:5,    
    centros1 = kmeans(x1, k);
    centros2 = kmeans(x2, k);
    d = [];
    for i = 1:k
        d = [d; d_mahal(xtest, centros1(:, i), c1); 
            d_mahal(xtest, centros2(:, i), c2)];
    end
    [basura, yout] = min(d);
    yout = (rem(yout, 2) == 0)+1;
    errores(k) = sum(ytest ~= yout)/size(yout,2) * 100;
end
