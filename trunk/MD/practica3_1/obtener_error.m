function error = obtener_error(fichero)
  mf = fopen(fichero,'rt');
  error = 0;
  if mf ~= -1
    frase = 'Within cluster sum of squared errors: ';
    linea = fgets(mf);
    while ~feof(mf),
      if length(linea) > length(frase) & linea(1:length(frase)) == frase,
	              error = str2num(linea(length(frase)+1:end));
      end
      linea = fgets(mf);
    end
    fclose(mf);
  end