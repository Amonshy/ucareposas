function error = estimar_error_Bayes (nombre_bd)
%error = estimar_error_Bayes (nombre_bd)
%Estima el error medio del clasificador Bayesiano, a partir de los 10
%pares de entrenamiento y test, generados en la carpeta 10kfoldoriginal.
%nombre BD será el nombre de la base de datos bank o titanic.

nombreEstandarFicheroTrain = ['10kfoldoriginal/' nombre_bd '/' nombre_bd '_kfcv_train'];
nombreEstandarFicheroTest = ['10kfoldoriginal/'  nombre_bd '/' nombre_bd  '_kfcv_test'];

%Para cada uno de los pares de entrenamiento y test;
for i=1:10,
    ficheroTrain = [nombreEstandarFicheroTrain  num2str(i,'%0.2d') '.arff' ];
    ficheroTest = [nombreEstandarFicheroTrain  num2str(i,'%0.2d') '.arff' ];
    errores(i) = calculo_error_Bayes(ficheroTrain,ficheroTest);
      
end;

%Calculamos el error promedio
error = mean(errores);
%Mostramos un mensaje por pantalla
mensaje = ['El error promedio estimado para el clasificador Bayesiano es de:' num2str(error) '%' ];
disp(mensaje);

end