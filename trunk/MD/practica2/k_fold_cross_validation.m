function k_fold_cross_validation(fichero_de_entrada,num_par_train_test)
%funcion k_fold_cross_validation(fichero_de_entrada,num_par_train_test)
%Esta implementacion del metodo k_fold_cross_validation reparte de
%manera equitativa los elementos

[file,error] = fopen([fichero_de_entrada,'.arff'],'r');

%Eliminamos la terminacion _train
fichero_de_entrada = fichero_de_entrada(1:length(fichero_de_entrada)-6);

%Comprobamos si el fichero se ha podido abrir
if file ~= -1
    %variable que indica si ha encontrado o no el principio de los datos
    %(@data)
    datosEncontrados = 0;    
    %Variable que almacena la cabecera de un fichero arff
    cabecera = []; 
    while ~datosEncontrados
        %Tomamos una linea
        linea = fgets(file);
        cabecera = [cabecera, linea];
         %Si encontramos @data entonces lo siguiente son datos
        if length(linea) >= 5 & lower(linea(1:5)) == '@data'
            datosEncontrados = 1;
        end
    end
    
    datos = [];
    indices_datos = [];
    %Recorremos todo hasta el final del fichero
    while ~feof(file)
       %tomamos un dato y lo guardamos en la variable
       linea = fgets(file);
       %vamos a suponer que los comentarios estan solo al principio de la
       %linea y no tras unos datos, por simplificar
       if linea(1) ~= '%'
        empieza = length(datos) + 1;
        datos = [datos linea];
        acaba = length(datos);
        indices_datos = [ indices_datos;[empieza acaba]];
       end
    end 
    
    
    num_datos = length(indices_datos);
    %marcamos cada dato, indicando a que pliegue pertenece
    for i = 1:num_datos
        distribucion(i) = mod(i,num_par_train_test) + 1;
    end

    %Generamos los k pares de entrenamiento y test
    for k = 1:num_par_train_test
        
        datosTest = [cabecera];
        datosEntrenamiento = [cabecera];

        for i = 1:num_datos
            if k ~= distribucion(i)
                datosEntrenamiento = [datosEntrenamiento datos(indices_datos(i,1):indices_datos(i,2))];
            else
                datosTest = [datosTest datos(indices_datos(i,1):indices_datos(i,2))];
            end;
        end;
        
        %Calculamos si k es < 10 para añadir un 0 al nombre del fichero
        if k < 10
           numParExtension = '0';
        else
            numParExtension = '';
        end
        %guardamos en un fichero los datos
        fileTest = fopen([fichero_de_entrada '_kfcv_test' numParExtension int2str(k) '.arff'],'w');
        fileEntrenamiento = fopen([fichero_de_entrada '_kfcv_train' numParExtension int2str(k) '.arff'], 'w');

        fprintf(fileTest, datosTest);
        fprintf(fileEntrenamiento, datosEntrenamiento);
    end
    
    datosTest = [cabecera];
    
    close('all');
else
    sprintf(error);
end