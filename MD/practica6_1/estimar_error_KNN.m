function [ errorPromedio k_optima ] = estimar_error_KNN (nombre_bd)
% [ errorPromedio k_optima ] = estimar_error_KNN (nombre_fichero)
%Estima el error medio del clasificador K-Vecinos, a partir de los 10
%pares de entrenamiento y test, generados en la carpeta 10kfoldoriginal.
%nombre BD será el nombre de la base de datos bank o titanic.

nombreEstandarFicheroTrain = ['10kfoldoriginal/' nombre_bd '/' nombre_bd '_kfcv_train'];
nombreEstandarFicheroTest = ['10kfoldoriginal/'  nombre_bd '/' nombre_bd  '_kfcv_test'];

%Numero máximo de vecinos que vamos a utilizar y que se ha obtenido
%mediante una prueba previa y generacion de una gráfica.
num_maximo_vecinos = 15;

%Primero obtenemos el k optimo para cada uno de las 10 muestras del k-fold
%cross-validation que se han generado. Para ello utilizaremos de nuevo un
%k-fold-cross-validation para obtener 10 muestras de cada una de las
%muestras
for i=1:10,
    for j=1:10,
        %El formato de los ficheros generados con k-fold para cada una de
        %las 10 muestras están en la ruta
        %10kfoldsecundario/nombrebd/trainX/nombrebd_kfcv_trainX_kfcv_trainY
        %donde X es el numero de la muestra original e Y cada uno de los
        %pliegues obtenidos para cada muestra X
        ficheroTrain = ['10kfoldsecundario/' nombre_bd '/train' num2str(i,'%0.2d') '/' nombre_bd '_kfcv_train' num2str(i,'%0.2d') '_kfcv_train' num2str(j,'%0.2d') '.arff' ];
        ficheroTest = ['10kfoldsecundario/' nombre_bd '/train' num2str(i,'%0.2d') '/' nombre_bd '_kfcv_train' num2str(i,'%0.2d') '_kfcv_test' num2str(j,'%0.2d') '.arff'];

        %Generamos los errores obtenidos para cada uno de los k vecinos desde 2
        %hasta num_maximo_vecinos, para cada pliegue j.
        for k=2:num_maximo_vecinos,
            errores(j,k-1) = calculo_error_KNN(k,ficheroTrain, ficheroTest);
        end;

        %Una vez obtenidos los errores hacemos la media de los errores y nos
        %quedamos con el minimo, porque el mínimo error, será el k_optimo
        [valor indice_k_optima] = min(mean(errores));
        
    end;
    k_op(i) = indice_k_optima;
end;

for i=1:10,

     % Ahora probamos los k_optimos obtenidos para cada pliegue principal y
     % calculamos el error promedio obtenido.
     ficheroTrain = [nombreEstandarFicheroTrain  num2str(i,'%0.2d') '.arff' ];
     ficheroTest = [nombreEstandarFicheroTrain  num2str(i,'%0.2d') '.arff' ];
     erroresPrincipal(i) = calculo_error_KNN(k_op(i)+1,ficheroTrain,ficheroTest);
      
end;

errorPromedio = mean(erroresPrincipal);
k_optima = mode(k_op);
end