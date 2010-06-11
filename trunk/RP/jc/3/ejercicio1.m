% a)Se sabe que los datos de la clase 1 pertenecen en un 30% a una distribución N(15,5) y en un 70% a una distribución N(18,3).
% b)Se sabe que los datos de la clase 2 pertenecen en un 40% a una distribución N(13,6) y en un 60% a una distribución N(15,2).
% c)Estimar ambas funciones de decisión mediante el método de Parzen usando ventanas gaussianas.
% d)Obtener la(s) frontera(s) de decisión lo mejor posible.

N=1000;
clase1 = [randn(1,N*0.3)*5+15 randn(1,N*0.7)*3+18];
clase2 = [randn(1,N*0.4)*6+13 randn(1,N*0.6)*2+15];

s1=0.5;
s2=0.5;

x=-6:0.1:32;
h=zeros(1,length(x));
h2=zeros(1,length(x));
for i=1:length(clase1), 
  h = h + normpdf(x,clase1(i), s1);
  h2 = h2 + normpdf(x,clase2(i), s2);
%   plot(x,h)
%   title(num2str(clase1(i)),'FontSize',14)
%   drawnow  
end 
h = h / length(clase1);
h2 = h2 / length(clase2);

h3 = (normpdf(x,15,5) + normpdf(x,18,3))/2;
h4 = (normpdf(x,13,6) + normpdf(x,15,2))/2;
figure, plot(x,h,'r',x,h2,'g',x,h3,'b',x,h4,'k');
legend('calculada1','calculada2','exacta1','exacta2')