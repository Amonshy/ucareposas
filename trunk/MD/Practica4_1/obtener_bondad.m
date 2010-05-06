function bondad = obtener_bondad(fichero)
  mf = fopen(fichero,'rt');
  bondad = 0;
  if mf ~= -1
    frase = 'Log likelihood: ';
    linea = fgets(mf);
    while ~feof(mf),
      if length(linea) > length(frase) & linea(1:length(frase)) == frase,
	              bondad = str2num(linea(length(frase)+1:end));
      end
      linea = fgets(mf);
    end
    fclose(mf);
  end