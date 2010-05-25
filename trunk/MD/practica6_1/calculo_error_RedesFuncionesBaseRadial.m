function error = calculo_error_RedesFuncionesBaseRadial(numFunciones, semilla,fichero_train, fichero_test)
% error = calculo_error_RedesFuncionesBaseRadial(numFunciones,semilla,fichero_train, fichero_test)
% Calcula el error para las redes de funciones de base radial, recibe el numero de funciones de base radial,
% la semilla y los fichero de test y entrenamiento.
    orden = sprintf('!java -classpath ";weka.jar" weka.classifiers.functions.RBFNetwork -B %i -S %i -R 1.0E-8 -M -1 -W 0.1 -t %s -T %s > salidaRBF.txt',numFunciones,semilla, fichero_train,fichero_test);
    eval(orden);
    error = obtener_error('salida.txt');
end