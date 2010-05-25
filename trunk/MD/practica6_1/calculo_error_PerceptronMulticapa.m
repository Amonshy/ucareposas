function error = calculo_error_PerceptronMulticapa(numNeuronas, numSemilla,fichero_train, fichero_test)
% error = calculo_error_PerceptronMulticapa(numMax_vecino, fichero_train, fichero_test,rango)
% Calcula el error para el perceptron multicapa, recibe el numero de neuronas, el numero de semillas y
% los fichero de test y entrenamiento.
disp('train:');
fichero_train
disp('test');
fichero_test
        orden = sprintf('!java -classpath ";weka.jar" weka.classifiers.functions.MultilayerPerceptron  -S %d -H %d -t %s -T %s > salida.txt',numSemilla,numNeuronas,fichero_train,fichero_test);
        eval(orden);
        error=obtener_error('salida.txt');
end