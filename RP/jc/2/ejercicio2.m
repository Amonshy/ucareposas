% a
randn('seed',0)

% b
N=5000;
Pw1 = 0.5;
Pw2 = 0.5;
w1 = randn(1,N*Pw1)*3+20;
w2 = randn(1,N*Pw2)*2+25;

m1 = mean(w1); s1= std(w1);  m2 = mean(w2); s2=std(w2);

A=s1*s1-s2*s2;
B=2*(m1*s2*s2-m2*s1*s1);
C=2*s1*s1*s2*s2*(log(Pw1)-log(Pw2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
x1=(-B+sqrt(B*B-4*A*C))/2/A
x2=(-B-sqrt(B*B-4*A*C))/2/A

% I=-9:0.01:9;plot(I,Pw1*normpdf(I,m1,s1));hold on;
% plot(I,Pw2*normpdf(I,m2,s2),'r');hold off;

% c
N=5000;
Pw1 = 0.7;
Pw2 = 0.3;
w1 = randn(1,N*Pw1)*3+20;
w2 = randn(1,N*Pw2)*2+25;

m1 = mean(w1); s1= std(w1);  m2 = mean(w2); s2=std(w2);

A=s1*s1-s2*s2;
B=2*(m1*s2*s2-m2*s1*s1);
C=2*s1*s1*s2*s2*(log(Pw1)-log(Pw2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
x1=(-B+sqrt(B*B-4*A*C))/2/A
x2=(-B-sqrt(B*B-4*A*C))/2/A

% d
N=5000;
Pw1 = 0.3;
Pw2 = 0.7;
w1 = randn(1,N*Pw1)*3+20;
w2 = randn(1,N*Pw2)*2+25;

m1 = mean(w1); s1= std(w1);  m2 = mean(w2); s2=std(w2);

A=s1*s1-s2*s2;
B=2*(m1*s2*s2-m2*s1*s1);
C=2*s1*s1*s2*s2*(log(Pw1)-log(Pw2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
x1=(-B+sqrt(B*B-4*A*C))/2/A
x2=(-B-sqrt(B*B-4*A*C))/2/A

% e

