function error = calculo_error_Bayes(fichero_train, fichero_test)
% error = calculo_error_Bayes(fichero_train, fichero_test)
% Calcula el error para el clasificador Bayesiano, recibe los fichero de test y entrenamiento
    orden = sprintf('!java -classpath ";weka.jar" weka.classifiers.bayes.NaiveBayes -t %s -T %s> salida.txt', fichero_train,fichero_test);
    error = obtener_error('salida.txt'); %Aqui hay que igualarlo a algo pero no tengo el enunciado y no se exactamente XD    
end