function [error,a] = error_kmedias(k, n, fichero_datos)

% k: numero de clusters
% n: numero de semillas diferentes que se van a utilizar
% fichero_datos: nombre del fichero de datos que se le pasa a la instruccion de weka

[file, err] = fopen(fichero_datos,'r');
if file ~= -1

    %buscamos data para contar el numero de datos a partir de ahi
    linea = fgets(file);
    while length(linea)>=5 & lower(linea(1:5)) ~= '@data'
        linea = fgets(file);
    end;

    %Una vez encontrado data, contamos el numero de datos
    N = 0;
    while ~feof(file)
        N = N +1;   
        linea = fgets(file);    
    end;
    
    fclose(file);
    
	a = round(N*rand(1,n));
	
	for j=1:length(a),
		for i=1:k,
			orden = sprintf('!java -classpath ";weka.jar" weka.clusterers.SimpleKMeans -N %d -S %d -t %s > salida.txt', i, a(j), fichero_datos);
			eval(orden);
			error(j,i) = obtener_error('salida.txt');
		end
	end

else
    err    
end