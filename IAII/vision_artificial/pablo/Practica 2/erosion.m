function erosionada = erosion(imagen, mask, x, y)
% erosionada = erosion(imagen, mask, x, y)
% imagen = imagen original
% mask = mascar� a aplicar
% x posici�n x del centro de la mascar�
% y posici�n y del centro de la mascar�

%Limites de la imagen
size_x = size(imagen,1);
size_y = size(imagen,2);

%Limites de la mascar�
mask_x = size(mask,1);
mask_y = size(mask,2);

% Recorremos cada uno de los p�xeles de la imagen
for i=1:size_x
    for j=1:size_y
        
        % Tomamos los p�xeles vecinos, seg�n la m�scara
        for u=1:mask_x
            for v=1:mask_y
                %Calculamos el desplazamiento del vecino a calcular
                desplazamiento_x = u - x;
                desplazamiento_y = v - y;
                %Calculamos la posicion del supuesto vecino a observar
                vecino_x = i + desplazamiento_x;
                vecino_y = j + desplazamiento_y;
                
                if(indiceValido(vecino_x,1,size_x) & indiceValido(vecino_y,1,size_y))
                    vecinos(u,v) = imagen(vecino_x,vecino_y);
                else
                    vecinos(u,v) = 0;
                end;
            end;
        end;
        
        
        
        % Multiplicamos por la mascara y tomamos el minimo
        pixel = min(min(vecinos.*mask));
        
        %Ahora colocamos este valor en la posicion indicada dentro de la
        %imagen
        erosionada(i,j) = pixel;    
        
    end;
end;

end