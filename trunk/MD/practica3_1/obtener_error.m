function error = obtener_error(fichero)
  mf = fopen(fichero,'rt');
  if mf ~= -1
    frase = 'Within cluster sum of squared errors';
    linea = fgets(mf);
    while ~feof(mf)
      if length(linea) > length(frase)
	if linea (1:length(frase)) == false
	  error = str2num(linea(length(frase)+1:end));
	end
      end
      linea = fgets(mf);
    end
    fclose(mf);
  end