function hold_out(fichero_de_entrada,porcentaje_test)
%funcion hold_out(fichero_de_entrada,porcentaje_test)

[file,error] = fopen([fichero_de_entrada,'.arff'],'r');

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
    
    %calculamos el numero de muestras de test
    num_muestras_test = length(indices_datos) * ( porcentaje_test / 100 );
    
    %creamos un vector de 1 con el numero de elementos de test
    unos = ones(1,num_muestras_test);
    %creamos un vector de 0 con el numero de elementos de entrenamiento
    ceros = zeros(1,length(indices_datos)-num_muestras_test);
    
    %barajo par seleccionar aleatoriamente
    separacion = vectorShuffle(unos,ceros);
    
    datosTest = [cabecera];
    datosEntrenamiento = [cabecera];
    
    for contador = 1:length(separacion)
        if separacion(contador)
            datosTest = [datosTest datos(indices_datos(contador,1):indices_datos(contador,2))];
        else
            datosEntrenamiento = [datosEntrenamiento datos(indices_datos(contador,1):indices_datos(contador,2))];
        end
    end
    
    %guardamos en un fichero los datos
    
    fileTest = fopen([fichero_de_entrada '_test.arff'],'w');
    fileEntrenamiento = fopen([fichero_de_entrada '_train.arff'], 'w');
    
    fprintf(fileTest, datosTest);
    fprintf(fileEntrenamiento, datosEntrenamiento);
    
    
    close('all');
else
    sprintf(error);
end


