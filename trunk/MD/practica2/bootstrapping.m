function bootstrapping(fichero_de_entrada,num_pares_train_test)
%funcion bootstrapping(fichero_de_entrada,num_pares_train_test)

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
    end ,
    
    
    %Generamos los k pares de entrenamiento y test
    for k = 1:num_pares_train_test
        
        %Almacenamos el número de elementos de datos de entrenamiento
        num_datos = length(indices_datos);
        
        %Cojo num_datos elementos para el vector de entrenamiento y marco
        %los que ya he seleccionado
        datosEntrenamiento = [cabecera];
        escogidos = zeros(1,num_datos);
        for contador = 1:num_datos
            %Selecionamos uno aleatoriamente.
            aleatorio = fix(rand()*num_datos);
            if ~aleatorio
               aleatorio = 1 ;
            end
            datosEntrenamiento = [datosEntrenamiento datos(indices_datos(aleatorio,1):indices_datos(aleatorio,2))];
            escogidos(aleatorio) = 1;
        end


        datosTest = [cabecera];
        for contador = 1:num_datos
            if ~escogidos(contador)
                datosTest = [datosTest datos(indices_datos(contador,1):indices_datos(contador,2))];
            end
        end
        
        %Calculamos si k es < 10 para añadir un 0 al nombre del fichero
        if k < 10
           numParExtension = '0';
        else
            numParExtension = '';
        end
        %guardamos en un fichero los datos
        fileTest = fopen([fichero_de_entrada '_boo_test' numParExtension int2str(k) '.arff'],'w');
        fileEntrenamiento = fopen([fichero_de_entrada '_boo_train' numParExtension int2str(k) '.arff'], 'w');

        fprintf(fileTest, datosTest);
        fprintf(fileEntrenamiento, datosEntrenamiento);
    end
    
    close('all');
else
    sprintf(error);
end