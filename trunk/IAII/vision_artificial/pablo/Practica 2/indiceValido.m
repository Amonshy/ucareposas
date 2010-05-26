function bool = indiceValido(ind, inf, sup)
% bool = indiceValido(ind, inf, sup)
% Indica si el indice IND es v�lido dentro del rango indicado [inf, sup]
bool = ind <= sup & ind >= inf;
end