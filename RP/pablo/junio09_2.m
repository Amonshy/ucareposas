S = 'LAS COORDENADAS DE LA GSBHBUB HAN SIDO FIJADAS EN FM NBS EF BMCPSBO FO MB QBSUF MAS OCCIDENTAL DEL MAR MEDITERRANEO TUPQ MB WFMPDJEBE DEL VIENTO ES DE UNOS VEINTE NUDOS Z MB QSPGVOEJEBE FT DE DOSCIENTOS METROS STOP';

r ='111 11111111111 11 11 2222222 111 1111 1111111 11 22 222 22 2222222 22 22 22222 111 1111111111 111 111 111111111111 2222 22 222222222 111 111111 11 11 1111 111111 11111 2 22 22222222222 22 11 1111111111 111111 1111';

indiceletras = find(S>' ');

estimstates = r(indiceletras) - '0';
aux = S(indiceletras) - 'A' + 1;
%-----------------------------------------------------
[estimA,estimB] = hmmestimate(aux,estimstates);
[A,B] = hmmtrain(aux,estimA,estimB);

ind = find(B==0);
B(ind) = 1e-4;
for i=1:size(B,1),
   B(i,:) = B(i,:)/sum(B(i,:));
end;
%--------------------------------------------

S = 'LAS TROPAS SE ENCUENTRAN EN LA GSPOUFSB DPO FM FOFNJHP STOP SE RECOMIENDA DETENER LA PQFSBDJPO STOP MB HVFSSB IB UFSNJOBEP';

S2 = decodificar(S,A,B);




