function y = densidadND(x,m,C)
%
%  y = densidadND(x,m,C)
%
%      x = punto en el espacio N-dimensional
%      m = media
%      C = matriz de covarianza
%

n = length(m);
S = (2*pi)^(n/2) * sqrt(det(C));
T = - 0.5 * (x-m)' * inv(C) * (x-m);

y = 1/S * exp(T);



