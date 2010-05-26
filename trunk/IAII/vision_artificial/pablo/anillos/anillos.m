clear all;
close all;
%Cargamos la imagen orginal
orig=imread('AnillosCuanticos.jpg');

figure;imshow(orig);

%Pasamos a escala de grises
gris = rgb2gray(orig);


%Primero quitamos el ruido de la imagen con un filtro de la media
mascara = fspecial('gaussian',[7 7],4);
sinruido=imfilter(gris,mascara,'same');






%Aplicamos un filtro watershed para poder quedarnos con los bordes de los
%anillos
bordes = edge(sinruido,'canny');

figure;imshow(bordes);

mascaraDil = strel('square',6);
dilatada = imdilate(bordes,mascaraDil);



inversa = dilatada == 0;




%Etiquetamos para poder usar la imagen etiquetada, para extraer las
%caracteristicas
etiquetada=bwlabel(inversa);


%Cogeremos ademas del area el perimetro, para posteriormente quedarnos con
%aquellos que tienen una determinada area
datos=regionprops(etiquetada,'Area','Perimeter');

% compacidad = [ [datos.Perimeter].^2 ./ [datos.Area] ];

% Me quedo con aquellos bordes cuya area está entre 500 y 100
etiquetas = find( [datos.Area] <= 600 & [datos.Area] >= 20 );

imagenAnillos = zeros(size(orig,1),size(orig,2));

for i=1:length(etiquetas)
    indices = find(etiquetada == etiquetas(i));
    imagenAnillos(indices) = etiquetada(indices);
end;

mascaraDil = strel('square',12);
figure;imshow(imdilate(imagenAnillos,mascaraDil));
figure; imshow(imdilate(imagenAnillos,mascaraDil).*bordes);


% 
% 
% 
% %Los anillos seran aquellos que tienen un area menor que 1000, puesto que si
% %tiene mas de mil pixel, se podra considerar que son del fondo, guardaremos
% %los indices de los anillos, que ademas usaremos despues para calcular la
% %media de las areas
% anillos=find(datos.size < 1000);
% 
% %Obtenemos el tamaño del vector de todos los que tienen un area menor que
% %1000 y entonces tendremos los anillos que hay, la variable aux, es
% %simplemente porque no nos interesa las filas, si no las columnas que tiene
% %el vector, estas seran el numero de anillos.
% [aux, numeroAnillos]=size(Anillos);
% % 
% % %En la variable Anillos teniamos los indices del vector de datos, que
% % %pertenecen a los anillos, pues ahora usamos estos indices para calcular la
% % %media de las areas de todos los anillos.
% % 
% % %Sumamos todas las areas de todos los anillos, sumando todos los valores
% % %del vector de datos cuyos indices se encuentran en la variable Anillos y
% % %luego lo dividimos entre el numero total de anillos
% % 
% % MediaTamAnillos=sum(datos(Anillos).size)/numeroAnillos;
% % 
% % %Por ultimo usaremos los indices ya hallados y guardados en Anillos, para
% % %obtener la compacidad, para ello cogeremos los datos correspondientes a
% % %los anillos, tanto su area como su perimetro, y aplicaremos la formula de
% % %la compacidad comp=perimetro^2 / area
% % 
% % CompacidadAnillos=(datos(Anillos).perimeter.^2)./datos(Anillos).size;
% % 
% % %Como la compacidad de una figura debe valer 12,6 para que se considere
% % %circular tomaremos un rango de entre 11 y 14 para considerar a un anillo
% % %circular, asi que volveremos a usar el procedimiento para contar los
% % %anillo, pero esta vez aplicado a aquellos anillos que tengan una
% % %compacidad entre 11 y 14, y veremos cuantos son esfericos
% % 
% % SonEsfericos=find( CompacidadAnillos > 11 & CompacidadAnillos < 14 );
% % 
% % %Ahora contaremos cuantos de todos los anillos hemos considerados esfericos
% % 
% % [aux, numeroAnillosEsfericos]=size(SonEsfericos);
% % 
% % %esto sirve para comprobar si la media del area es de verdad
% % %representativa
% % coeficientedepearson=std(datos(Anillos).Size)/MediaTamAnillos; 
% %  
% % %Mostramos por pantalla la solucion de todos los datos obtenidos
% %  
% % sprintf('EL numero total de Anillos cuanticos es %d, el area media de estos anillos es %f  y el numero total de anillos que se pueden considerar esfericos es %d',numeroAnillos,MediaTamAnillos,numeroAnillosEsfericos)
% % if coeficientedepearson < 0.5
% %     sprintf('la media es representativa con cf de Pearson de %f',coeficientedepearson)
% % else
% %     sprintf('la media NO es representativa')
% % end