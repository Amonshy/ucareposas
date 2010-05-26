% **************************A)

randn('seed',0);

% **************************B)

% N = 5000; %peces
% 
% %doradas
% m1 = 20;
% s1 = 3;
% %lubinas
% m2 = 25;
% s2 = 2;
% 
% w1 = 0.5; %Probabilidad de que sea dorada
% w2 = 0.5; %Probabilidad de que sea lubina
% 
% doradas = (m1 + randn(1,N*w1)*s1);
% lubinas = (m2 + randn(1,N*w1)*s2);
% 
% A=s1*s1-s2*s2;
% B=2*(m1*s2*s2-m2*s1*s1);
% C=2*s1*s1*s2*s2*(log(w1)-log(w2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
% x1=(-B+sqrt(B*B-4*A*C))/2/A
% x2=(-B-sqrt(B*B-4*A*C))/2/A
% 
% I=10:0.01:30;plot(I,w1*normpdf(I,m1,s1));hold on;
% plot(I,w2*normpdf(I,m2,s2),'r');hold off;


% **************************C)

% N = 5000; %peces
% 
% %doradas
% m1 = 20;
% s1 = 3;
% %lubinas
% m2 = 25;
% s2 = 2;
% 
% w1 = 0.7; %Probabilidad de que sea dorada
% w2 = 0.3; %Probabilidad de que sea lubina
% 
% doradas = (m1 + randn(1,N*w1)*s1);
% lubinas = (m2 + randn(1,N*w1)*s2);
% 
% A=s1*s1-s2*s2;
% B=2*(m1*s2*s2-m2*s1*s1);
% C=2*s1*s1*s2*s2*(log(w1)-log(w2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
% x1=(-B+sqrt(B*B-4*A*C))/2/A
% x2=(-B-sqrt(B*B-4*A*C))/2/A
% 
% I=10:0.01:30;plot(I,w1*normpdf(I,m1,s1));hold on;
% plot(I,w2*normpdf(I,m2,s2),'r');hold off;

% **************************D)
% N = 5000; %peces
% 
% %doradas
% m1 = 20;
% s1 = 3;
% %lubinas
% m2 = 25;
% s2 = 2;
% 
% w1 = 0.3; %Probabilidad de que sea dorada
% w2 = 0.7; %Probabilidad de que sea lubina
% 
% doradas = (m1 + randn(1,N*w1)*s1);
% lubinas = (m2 + randn(1,N*w1)*s2);
% 
% A=s1*s1-s2*s2;
% B=2*(m1*s2*s2-m2*s1*s1);
% C=2*s1*s1*s2*s2*(log(w1)-log(w2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
% x1=(-B+sqrt(B*B-4*A*C))/2/A
% x2=(-B-sqrt(B*B-4*A*C))/2/A
% 
% I=10:0.01:30;plot(I,w1*normpdf(I,m1,s1));hold on;
% plot(I,w2*normpdf(I,m2,s2),'r');hold off;


% **************************E)


