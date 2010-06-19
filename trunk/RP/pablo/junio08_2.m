clear all;
close all;

load cancer;


W = fisher(x,y,1);

xp = W * x;

%Apartado a)

clase1 = xp(:,find(y==1));
clase0 = xp(:,find(y==0));

m0 = meanpat(clase0);
m1 = meanpat(clase1);

s0 = covpat(clase0);
s1 = covpat(clase1);

N = size(y,1);

w0 = (length(find(y==0))*100)/length(y);
w1 = (length(find(y==1))*100)/length(y);

A=s0*s0-s1*s1;
B=2*(m0*s1*s1-m1*s0*s0);
C=2*s0*s0*s1*s1*(log(w0)-log(w1)-log(s0)+log(s1))+s0*s0*m1*m1-s1*s1*m0*m0;
x1=(-B+sqrt(B*B-4*A*C))/2/A;
x2=(-B-sqrt(B*B-4*A*C))/2/A;

I=0:0.01:3;plot(I,w0*normpdf(I,m0,s0));hold on;
plot(I,w1*normpdf(I,m1,s1),'r');hold off;

clc;
%Apartado b)

%Calculo la funcion para el primero
desvstandard=0.1;
x=0:0.1:3;
h=zeros(1,length(x));
for i=1:length(clase0),  
  h = h + normpdf(x,clase0(i), desvstandard);  
%   plot(x,h)
%   title(num2str(datos1(i)),'FontSize',14)
%   drawnow  
end 
h = h / length(clase0);



%Calculo la funcion para el segundo
desvstandard=0.1;
x=0:0.1:3;
h2=zeros(1,length(x));
for i=1:length(clase1),  
  h2 = h2 + normpdf(x,clase1(i), desvstandard);  
%   plot(x,h2)
%   title(num2str(datos2(i)),'FontSize',14)
%   drawnow  
end 
h2 = h2 / length(clase1);
plot(x,h,'r',x,h2,'b');

m0 = mean(h);
s0 = std(h);

m1 = mean(h2);
s1 = std(h2);


