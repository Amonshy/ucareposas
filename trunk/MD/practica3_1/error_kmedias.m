function [error,a] = error_kmedias(k, n, fichero_datos)

% k: numero de clusters
% n: numero de semillas diferentes que se van a utilizar
% fichero_datos: nombre del fichero de datos que se le pasa a la instruccion de weka

datos = textread(fichero_datos,'%s','delimiter','\n','whitespace','');
indice = find(ismember(datos, '@DATA')==1 | ismember(datos, '@data')==1);
datos = datos(indice+1:end,1); % Matriz con los datos (desde '@data' al final)
N = size(datos,1)
a = round(N*rand(1,n));
for j=1:length(a),
	for i=1:k,
		orden = sprintf('!java -classpath ";weka.jar" weka.clusterers.SimpleKMeans -N %d -S %d -t %s > salida.txt', i, a(j), fichero_datos);
		eval(orden);
		error(j,i) = obtener_error('salida.txt');
	end
end