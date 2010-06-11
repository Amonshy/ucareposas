close all
clear all
randn('seed',3);
rand('seed',3);

datos=shuffle([randn(1,1000)*5+30 randn(1,1000)*3+17]);
%datostrn = datos(1:1500);
%datostst = datos(1501:2000);

datostrn = datos(1:2:end);
datostst = datos(2:2:end);


k=1;
x=0.1:0.1:50;
interv_desvstandard = linspace(0.2,2,200);
h2 = (normpdf(x,30,5) + normpdf(x,17,3))/2;

for desvstandard = interv_desvstandard

  % Calculamos la densidad de Parzen
  desvstandard
  h=zeros(1,length(x));
  for i=1:length(datostrn)
    h = h + normpdf(x,datostrn(i), desvstandard);
  end
  h = h / length(datostrn);
  
  % Calculamos el valor de la densidad en los datos de test
  % usando una funcion de interpolacion
  P = interp1(x,h,datostst);
  
  R(k) = sum(log(P+1e-20));
  
  
  h0=zeros(1,length(x));
  for i=1:length(datostst),
    h0 = h0 + normpdf(x,datostst(i), desvstandard);
  end
  h0 = h0 / length(datostst);

  S(k)=sumsqr(h0-h2);
    
  k=k+1;
end

% Elegimos la posicion que da un valor maximo en la probabilidad
figure,plot(interv_desvstandard,R);
[basura,pos] = max(R);

% Calculamos la funcion optima
desvstandard = interv_desvstandard(pos);
h=zeros(1,length(x));
for i=1:length(datos),
  h = h + normpdf(x,datos(i), desvstandard);
end
h = h / length(datos);

% Dibujamos la funcion optima y de la que proceden los datos
figure, plot(x,h,'r',x,h2,'b');
legend('calculada','exacta')

figure,subplot(2,1,1),plot(S);
       subplot(2,1,2),plot(R)