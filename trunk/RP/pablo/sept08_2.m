clear all;
close all;

rand('seed',0');
randn('seed',0);

numDatos = 1000;
% ----------------- Uniforme


datos = rand(1,numDatos);


desvstandard=0.5;
x=-5:0.1:5;
h=zeros(1,length(x));
for i=1:length(datos),  
  h = h + normpdf(x,datos(i), desvstandard);   
end 
h = h / length(datos);

figure;
plot(x,h,'r');


media = mean(datos);
des = std(datos);


% ------------------ Normal

datos2 = randn(1,numDatos);

desvstandard=0.5;
x=-5:0.1:5;
h2=zeros(1,length(x));
for i=1:length(datos2),  
  h2 = h2 + normpdf(x,datos2(i), desvstandard);  
end 
h2 = h2 / length(datos2);

figure;
plot(x,h2,'r');


media2 = mean(datos2);
des2 = std(datos2);