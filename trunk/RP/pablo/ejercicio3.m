% a. Crear los datos de partida
randn('seed',0);
A = round(20 + randn(1,500)*5);  % Doradas
B = round(30 + randn(1,500)*2);  % Lubinas

% b. Obtener los histogramas de A y B en intervalos de tamaño 1
[Ax Ay] = hist(A,max(A)-min(A));
[Bx By] = hist(B,max(B)-min(B));

% c. Obtener las probabilidades de A y B para cada intervalo.
Ax/500
Bx/500

% d. Determinar cuántos errores cometo si digo las siguientes afirmaciones:
% Si un pez mide menos o igual a 24, es dorada. Si no, es lubina.
(length(find(A>24))+length(find(B<=24)))/(length(A)+length(B))
% Si un pez mide menos o igual a 25, es dorada. Si no, es lubina.
(length(find(A>25))+length(find(B<=25)))/(length(A)+length(B))
% Si un pez mide menos o igual a 26, es dorada. Si no, es lubina.
(length(find(A>26))+length(find(B<=26)))/(length(A)+length(B))
% Si un pez mide menos o igual a 27, es dorada. Si no, es lubina.
(length(find(A>27))+length(find(B<=27)))/(length(A)+length(B))
% Si un pez mide menos o igual a 28, es dorada. Si no, es lubina.
(length(find(A>28))+length(find(B<=28)))/(length(A)+length(B))

% e. Realizar los pasos anteriores, suponiendo que genero datos para 500
% doradas y para 50 lubinas. ¿Qué ha ocurrido con el punto de error mínimo? ¿Y si son 50 doradas y 500 lubinas?
A = round(20 + randn(1,500)*5);  % Doradas
B = round(30 + randn(1,50)*2);  % Lubinas
% Si un pez mide menos o igual a 24, es dorada. Si no, es lubina.
(length(find(A>24))+length(find(B<=24)))/(length(A)+length(B))
% Si un pez mide menos o igual a 25, es dorada. Si no, es lubina.
(length(find(A>25))+length(find(B<=25)))/(length(A)+length(B))
% Si un pez mide menos o igual a 26, es dorada. Si no, es lubina.
(length(find(A>26))+length(find(B<=26)))/(length(A)+length(B))
% Si un pez mide menos o igual a 27, es dorada. Si no, es lubina.
(length(find(A>27))+length(find(B<=27)))/(length(A)+length(B))
% Si un pez mide menos o igual a 28, es dorada. Si no, es lubina.
(length(find(A>28))+length(find(B<=28)))/(length(A)+length(B))

A = round(20 + randn(1,50)*5);  % Doradas
B = round(30 + randn(1,500)*2);  % Lubinas
% Si un pez mide menos o igual a 24, es dorada. Si no, es lubina.
(length(find(A>24))+length(find(B<=24)))/(length(A)+length(B))
% Si un pez mide menos o igual a 25, es dorada. Si no, es lubina.
(length(find(A>25))+length(find(B<=25)))/(length(A)+length(B))
% Si un pez mide menos o igual a 26, es dorada. Si no, es lubina.
(length(find(A>26))+length(find(B<=26)))/(length(A)+length(B))
% Si un pez mide menos o igual a 27, es dorada. Si no, es lubina.
(length(find(A>27))+length(find(B<=27)))/(length(A)+length(B))
% Si un pez mide menos o igual a 28, es dorada. Si no, es lubina.
(length(find(A>28))+length(find(B<=28)))/(length(A)+length(B))

% f. Enuncia un procedimiento para, dados A y B, encontrar el punto óptimo de decisión N: 
% Si un pez mide menos o igual a N, es dorada. Si no, es lubina.
X = round(20 + randn(1,50)*5);  % Doradas
Y = round(30 + randn(1,500)*2);  % Lubinas

m1 = mean(X); s1= std(X);  m2 = mean(Y); s2=std(Y);

Pw1=length(X)/(length(X)+length(Y));
Pw2=length(Y)/(length(X)+length(Y));

A=s1*s1-s2*s2;
B=2*(m1*s2*s2-m2*s1*s1);
C=2*s1*s1*s2*s2*(log(Pw1)-log(Pw2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
x1=(-B+sqrt(B*B-4*A*C))/2/A
x2=(-B-sqrt(B*B-4*A*C))/2/A

% I=-9:0.01:9;plot(I,Pw1*norm(I,m1,s1));hold on;
% plot(I,Pw2*norm(I,m2,s2),'r');hold off;
