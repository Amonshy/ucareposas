clear all
close all
load iris

x = x(2:3,:);
y = y+1;

figure,plotpat(x,y);
axis([2 5 1 7])
axis equal

% Calcular parámetros de las gaussianas
for i=1:3
  indices = find(y==i);
  m{i} = meanpat(x(:,indices));
  C{i} = covpat(x(:,indices));
end

% Calcular funciones de densidad
[xi,yi] = meshgrid(2:0.01:5,1:0.01:7);
for i=1:3,
  pdf{i} = mvnpdf([xi(:) yi(:)],m{i}',C{i});
  pdf{i} = reshape(pdf{i},size(xi));
end

figure,imagesc(2:0.01:5,1:0.01:7,pdf{1}+pdf{2}+pdf{3}), axis xy
axis([2 5 1 7])

S1 = (pdf{1}>pdf{2}) & (pdf{1}>pdf{3});
S2 = (pdf{2}>pdf{1}) & (pdf{2}>pdf{3});
S3 = (pdf{3}>pdf{1}) & (pdf{3}>pdf{2});

figure,
imagesc(2:0.01:5,1:0.01:7,S1+2*S2+3*S3);axis xy
axis([2 5 1 7])

% Calcular funciones de densidad
for i=1:3,
  pdfdata(i,:) = mvnpdf(x',m{i}',C{i})';
end
[basura,clase] = max(pdfdata);

errores = find(clase~=y);
figure(1),hold on;plotpat(x(:,errores),'.');hold off