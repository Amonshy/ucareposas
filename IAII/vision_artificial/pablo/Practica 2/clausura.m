function resultado = clausura(imagen,mask,x,y)
% resultado = clausura(imagen, mask, x, y)
% imagen = imagen original
% mask = mascar� a aplicar
% x posici�n x del centro de la mascar�
% y posici�n y del centro de la mascar�
    resultado = erosion(dilatacion(imagen,mask,x,y),mask,x,y);

end