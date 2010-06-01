function error = calculo_error_KNN(vecinos,fichero_train, fichero_test)
% error = calculo_error_KNN(numMax_vecino, fichero_train, fichero_test)
% Calcula el error para los K-vecinos, recibe el numero de vecinos y
% los fichero de test y entrenamiento.
    orden = sprintf('!java -classpath ";weka.jar" weka.classifiers.lazy.IBk -K %d -t %s -T %s> salida.txt', vecinos, fichero_train,fichero_test);
    eval(orden);
    error = obtener_error('salida.txt');
end