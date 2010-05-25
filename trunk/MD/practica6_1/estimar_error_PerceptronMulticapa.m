function [ errorPromedio neurona_optima semilla] = estimar_error_PerceptronMulticapa (nombre_bd)
% [ errorPromedio neurona_optima semilla] = estimar_error_PerceptronMulticapa (nombre_bd)
%Estima el error medio del Perceptron Multicapa, a partir de los 10
%pares de entrenamiento y test, generados en la carpeta 10kfoldoriginal.
%nombre BD será el nombre de la base de datos bank o titanic.

nombreEstandarFicheroTrain = ['10kfoldoriginal/' nombre_bd '/' nombre_bd '_kfcv_train'];
nombreEstandarFicheroTest = ['10kfoldoriginal/'  nombre_bd '/' nombre_bd  '_kfcv_test'];

%Numero máximo de semillas y neuronas que vamos a utilizar.
num_maximo_semillas = 1;
num_maximo_neuronas = 3;
%Semillas generadas aleatoriamente
semillas = round(100*rand(1,num_maximo_semillas));

%Primero obtenemos la neurona y la semilla optima para cada una de las 10 muestras del k-fold
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

        %Generamos los errores obtenidos para cada uno de los pares
        %semilla/neurona para un fragmento j determinado
        for k=1:num_maximo_semillas,
            for l=1:num_maximo_neuronas,
               errores(k,l,j) = calculo_error_PerceptronMulticapa(l,semillas(k),ficheroTrain, ficheroTest);
            end;
        end;
    end;
     
    %Calculamos la media de errores cometidos por cada par semilla/neurona
    %obtenido en cada fragmento j
    mediaPorSemillasNeuronas = mean(errores,3);

    %Obtenemos para cada neurona cual ha sido su valor mínimo entre todas
    %las semillas
    [filaMin semilla] = min(mediaPorSEmillasNeuronas);
    %Obtenemos ahora el minimo de todas las neuronas
    [columnaMin neurona] = min(filaMin);
    
    %Guardamos la neurona
    neurona_op(i) = neurona;
    %Guardamos la semilla
    semilla_op(i) = semillas(semilla(neurona));
end;

for i=1:10,

     % Ahora probamos las neuronas y la semilla para cada pliegue principal y
     % calculamos el error promedio obtenido.
     ficheroTrain = [nombreEstandarFicheroTrain  num2str(i,'%0.2d') '.arff' ];
     ficheroTest = [nombreEstandarFicheroTrain  num2str(i,'%0.2d') '.arff' ];
     erroresPrincipal(i) = calculo_error_PerceptronMulticapa(neurona_op(i),semilla_op(i),ficheroTrain,ficheroTest);
      
end;

errorPromedio = mean(erroresPrincipal);
neurona_optima = mode(neurona_op);
semilla_optima = mode(semilla_op);
end