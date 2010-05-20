function error = calculo_error_KNN(numMax_vecino, fichero_train, fichero_test)
% error = calculo_error_KNN(numMax_vecino, fichero_train, fichero_test)
% Calcula el error para los K-vecinos, recibe el numero maximo de vecinos y
% los fichero de test y entrenamiento
    for k = 2:numMax_vecino,
        orden = sprintf('!java -classpath ";weka.jar" weka.classifiers.lazy.IBk -K %d -t %s -T %s> salida.txt', k, fichero_train,fichero_test);
        aux(k-1) = obtener_error('salida.txt');
    end;
    error = 0; %Aqui hay que igualarlo a algo pero no tengo el enunciado y no se exactamente XD    
end