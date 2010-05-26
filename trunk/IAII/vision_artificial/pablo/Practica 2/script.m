%%% Preparación de la Imagen
RGB=imread('elefantesolo.jpg');
I = RGB2GRAY(RGB); %%% convertir el elefante a escala degrises
I = imresize(I,0.5); %%% reducir resolución% 
A = imcrop(I); %%% recortar la imagen
close all,
imshow(I) %%% mostrar la imagen
title('Imagen Original Recortada');
%%% Aplicación de operadores individuales
%%% %%% Operacion UMBRAL
um=140; %%% asignar valor al umbral
Aumbral=umbral(A,um);
figure, imshow(Aumbral); title(['Umbral = ',int2str(um)]);
%%% OPeración Inverso
figure, imshow(inverso(Aumbral)); title('Operador Inverso');

i1 =50;
i2 =140;
%%% OPeración Intervalo
figure, imshow(intervalo(A,i1,i2));
title(['Operador Intervalo [',int2str(i1),' , ',int2str(i2),']']);