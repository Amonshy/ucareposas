clear all

S = {'Fair','Loaded'};  % Conjunto de estados
M = {1,2,3,4,5,6};      % Conjunto de observaciones

A = [ 0.95    0.05;     % Matriz de cambio de estado
      0.10    0.90]
    
B = [1/6 1/6 1/6 1/6 1/6 1/6 ;  % Matriz de prob. de observacion
     0.1 0.1 0.1 0.1 0.1 0.5]
   
P = [1 0];              % Matriz de prob. inicial

% CODIGO UTIL PARA GENERAR TRANSICIONES O GENERAR OBSERVACIONES
% DE FORMA ALEATORIA. SE MUESTRA CON UN EJEMPLO, PARA COMPROBAR 
% QUE HACE LO QUE QUIERO
S = B(2,:);   % (por ejemplo)
Q=zeros(1,6000);
for i=1:6000,
  aux=find(rand<cumsum(S));
  Q(i)=aux(1);
end
hist(Q,1:6)

% ¿COMO SE GENERA UNA SECUENCIA DE OBSERVACIONES?
%  1.- Se empieza siempre en el estado 1
%  2.- Hacer una transición usando la primera fila
%      de la matriz de transicion (A)
%  3.- Generar una observacion usando la matriz de observacion(B)
%  4.- Volver al paso 2
[seq, states] = hmmgenerate(10,A,B)
S(states)   % Estados
M(seq)      % Observaciones

% COMO SE EVALUA UNA SECUENCIA DE OBSERVACIONES
%   1.- Se calcula la prob. de estar en el estado  
%
%
disp('-------------------------- seq = [6] --------------------------------');
[dummy,P1] = hmmdecode([6], A, B);     % Como se hace en matlab
r1=[0.95*(1/6);
    0.05*(1/2)];
[P1 log(sum(r1))]
disp('------------------------- seq = [6 6] -------------------------------');
[dummy,P2] = hmmdecode([6 6], A, B);   % Como se hace en matlab
r2=[(r1(1)*0.95 + r1(2)*0.1)*(1/6) ;
    (r1(2)*0.90 + r1(1)*0.05)*(1/2)];
[P2 log(sum(r2))]
disp('------------------------- seq = [6 6 2] ----------------------------');
[dummy,P3] = hmmdecode([6 6 2], A, B);
r3=[(r2(1)*0.95 + r2(2)*0.1)*(1/6) ;
    (r2(2)*0.90 + r2(1)*0.05)*(0.1)];
[P3 log(sum(r3))]
disp('----------------------------------------------------------');


% VITERBI
seq = [1 2 6 6 6];
States = hmmviterbi(seq,A,B)

prob(1,1)=1*B(1,seq(1));
prob(2,1)=0;

for i=2:length(seq),    
    prob1=prob(1,i-1)*A(1,1);
    prob2=prob(2,i-1)*A(2,1);
    if prob1>prob2
      estado(1,i)=1;
      prob(1,i)=prob1*B(1,seq(i));
    else
      estado(1,i)=2;
      prob(1,i)=prob2*B(1,seq(i));
    end
    
    prob1=prob(1,i-1)*A(1,2);
    prob2=prob(2,i-1)*A(2,2);
    if prob1>prob2
      estado(2,i)=1;
      prob(2,i)=prob1*B(2,seq(i));
    else
      estado(2,i)=2;
      prob(2,i)=prob2*B(2,seq(i));
    end
        
end

flipud(estado)
flipud(prob)
