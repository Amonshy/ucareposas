function resultado = intervalo(imagen, inf, sup)
% resultado = intervalo(imagen, inf, sup)
    resultado = (imagen <= sup & imagen >= inf)*255;
end