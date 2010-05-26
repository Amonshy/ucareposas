function umbralizada = umbral (imagen, umb)
% umbrlizada = umbral (imagen, umb)
% devuelve 255 si el pixel está por encima del umbral y 0 en caso contrario

    if umb >= 0 & umb <= 255
        umbralizada = (imagen > umb)*255;
    else
        disp('Umbra no permitido (Solo entre 0 y 255)');
    end;


end