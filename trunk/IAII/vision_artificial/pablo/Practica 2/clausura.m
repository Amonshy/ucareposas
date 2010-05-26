function resultado = clausura(imagen,mask,x,y)
% resultado = clausura(imagen, mask, x, y)
% imagen = imagen original
% mask = mascará a aplicar
% x posición x del centro de la mascará
% y posición y del centro de la mascará
    resultado = erosion(dilatacion(imagen,mask,x,y),mask,x,y);

end