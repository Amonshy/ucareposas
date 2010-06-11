% b
N=5000;
Pw1 = 0.5;
Pw2 = 0.5;
w1 = randn(1,N*Pw1)*3+20;
w2 = randn(1,N*Pw2)*2+25;

m1 = mean(w1); s1= std(w1);  m2 = mean(w2); s2=std(w2);

L = [0 2; 0.8 0]
A=s1*s1-s2*s2;
B=2*(m1*s2*s2-m2*s1*s1);
C=2*s1*s1*s2*s2*(log(L(1,2)*Pw1)-log(L(2,1)*Pw2)-log(s1)+log(s2))+s1*s1*m2*m2-s2*s2*m1*m1;
x1=(-B+sqrt(B*B-4*A*C))/2/A
x2=(-B-sqrt(B*B-4*A*C))/2/A
