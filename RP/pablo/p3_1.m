% ***************************** a) b) c) d)

N = 5000;

w1 = 0.3;
w2 = 0.7;

m1 = 15;
s1 = 5;

m2 = 18;
s2 = 3;

datos1 = [(m1 + randn(1,N*w1)*s1) (m2 + randn(1,N*w2)*s2)];

w3 = 0.4;
w4 = 0.6;

m3 = 13;
s3 = 6;

m4 = 15;
s4 = 2; 

datos2 = [(m3 + randn(1,N*w3)*s3) (m4 + randn(1,N*w4)*s4)];

%Calculo la funcion para el primero
desvstandard=0.5;
x=5:0.1:45;
h=zeros(1,length(x));
for i=1:length(datos1),  
  h = h + normpdf(x,datos1(i), desvstandard);  
%   plot(x,h)
%   title(num2str(datos1(i)),'FontSize',14)
%   drawnow  
end 
h = h / length(datos1);
h3 = (normpdf(x,m1,s1) + normpdf(x,m2,s2))/2;


%Calculo la funcion para el segundo
desvstandard=0.5;
x=5:0.1:45;
h2=zeros(1,length(x));
for i=1:length(datos2),  
  h2 = h2 + normpdf(x,datos2(i), desvstandard);  
%   plot(x,h2)
%   title(num2str(datos2(i)),'FontSize',14)
%   drawnow  
end 
h2 = h2 / length(datos2);
h4 = (normpdf(x,m3,s3) + normpdf(x,m4,s4))/2;
% plot(x,h,'r',x,h2,'b',x,h3,'g',x,h4,'k');

% ***************************** d)

w1 = 0.5;
w2 = 0.5;

m1 = mean(datos1);
s1 = std(datos1);

m2 = mean(datos2);
s2 = std(datos2);

A=s1*s1-s2*s2;
B=2*(m1*s2*s2-m2*s1*s1);
C=2*s1*s1*s2*s2*(log(w1)-log(w2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
x1=(-B+sqrt(B*B-4*A*C))/2/A
x2=(-B-sqrt(B*B-4*A*C))/2/A

I=x;plot(I,w1*normpdf(I,m1,s1));hold on;
plot(I,w2*normpdf(I,m2,s2),'r');hold off;
