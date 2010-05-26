%Funcion a la que le pasamos una imagen (objeto) y un umbral y pasa un
%filtro paso_bajo sobre ese umbral, el umbra debe estar entre 0 y 1
%Devuelve la imagen con el filtro pasado

function y = filtroPasoBajo(I,umb)
F = log(fftshift(fft2(I)));


%Obtenemos las dimensiones de ambos lados
%Para nuestro trabajo, no es necesario tener en cuenta que la imagen
%ha sido rotada, simplemente nos interesa trabajar con la matriz de la
%transformada

[lado1, lado2]=size(F);
Xcentral=lado1/2;
Ycentral=lado2/2;

%Ahora obtenemos la distancia existente desde el centro de la matriz hasta
%una esquina, esto nos servira para estblecer el umbral, de manera que si
%elige 1 estara eligiendo un radio para el circulo del filtro igual a
%esta distancia y 0 si no existe circulo. Redondearemos para no trabajar
%con decimales, con la funcion floor que aproxima al entero mas proximo.

distancia=floor(sqrt(Xcentral^2 + Ycentral^2));


%obtenemos el radio de nuestro circulo
radio=floor(umb*distancia);

%Esto es pura matematicas, si la distancia desde un punto de la matriz
%al centro es mayor que el radio entonces lo ponemos a 0 si no nada.
for i = 1:lado1
    for j = 1:lado2
        if(sqrt((i-Xcentral)^2+(j-Ycentral)^2)>radio)
            F(i,j)=0;
        end
    end
end

% Deshacemos el preprocesamiento realizado previamente
y=abs(ifft2(exp(fftshift(F))));

