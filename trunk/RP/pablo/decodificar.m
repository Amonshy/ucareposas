function s1 = decodificar(S,A,B)
    indiceletras = find(S>' ');
    aux = S(indiceletras) - 'A' + 1;
    estados = hmmviterbi(aux,A,B);
    indices = find(estados == 2);
    aux(indices) = char(aux(indices)-1);
    s1 = S;
    s1(indiceletras) = char(aux+'A'-1);
end