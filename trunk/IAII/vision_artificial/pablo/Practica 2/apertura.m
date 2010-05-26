function resultado = apertura(imagen,mask,x,y)
% resultado = apertura(imagen, mask, x, y)
% imagen = imagen original
% mask = mascará a aplicar
% x posición x del centro de la mascará
% y posición y del centro de la mascará
    resultado = dilatacion(erosion(imagen,mask,x,y),mask,x,y);

end