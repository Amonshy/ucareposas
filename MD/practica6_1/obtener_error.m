function error = obtener_error(fichero)
% error = obtener_error(fichero)
% Devuelve el numero de instancias mal clasificadas

    file = fopen(fichero,'rt');
    if file ~= -1
        frase = 'Incorrectly Classified Instances';
        linea = fgets(file);
        while ~feof(file),
            if length(linea) > length(frase) & linea(1:length(frase))==frase,
                error = str2num(linea(length(frase)+1:end));
                error = error(:,2);
            end
            linea=fgets(file);
        end
        fclose(file);
    end
end