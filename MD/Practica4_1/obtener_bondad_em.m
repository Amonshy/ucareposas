function [bondades,a] = obtener_bondad_em(K, n, fichero_datos, pares)
% funcion [bondad,a] = obtener_bondad_em(K, n, fichero_datos, pares)
% K: numero de clusters
% n: numero de semillas diferentes que se van a utilizar
% fichero_datos: nombre del fichero de datos que se le pasa a la
% instruccion de weka (sin terminación .arff)

	a = round(10*rand(1,n));
	
    %calculamos los pares de entrenamiento y test
    k_fold_cross_validation(fichero_datos,pares);
    
    if regexp(fichero_datos,'_train'),
        
        fichero_datos = fichero_datos(1:regexp(fichero_datos,'_train')-1);
        
    end;
    
     if regexp(fichero_datos,'_test'),
        
        fichero_datos = fichero_datos(1:regexp(fichero_datos,'_test')-1);
        
    end;
    
    for i=1:pares
            entrenamiento(i,:)=[fichero_datos '_kfcv_train' num2str(i,'%0.2d') '.arff'];
            test(i,:)=[fichero_datos '_kfcv_test' num2str(i,'%0.2d') '.arff'];
    end;
    
	for j=1:length(a),
		for i=1:K,
            for k=1:pares,
                orden = sprintf('!java -classpath ";weka.jar" weka.clusterers.EM -N %d -S %d -t %s -T %s> salida.txt', i, a(j), entrenamiento(k,:), test(k,:));
                eval(orden);
                bondad(i,k) = obtener_bondad('salida.txt');
            end;
        bondades(j,i)=mean(bondad(i,:));
		end;
    end ; 