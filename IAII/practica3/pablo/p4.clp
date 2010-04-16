(clear)

;;***********************************
;;
;;		Clases
;;
;;*********************************** 

(defclass NOTICIA (is-a USER)
	(slot titular)
	(slot cuerpo)
	(slot resumen)
)

(defclass SUCESO (is-a USER)
	(slot lugar)
	(slot dia)
	(slot hora))

(defclass DESASTRENATURAL (is-a SUCESO)
	(slot muertos)
	(slot heridos)
	(slot sin_vivienda)
	(slot dagnos))

(defclass TERREMOTO (is-a DESASTRENATURAL)
	(slot falla)
	(slot magnitud))

(defclass HURACAN (is-a DESASTRENATURAL)
	(slot nombre)
	(slot maxVel)
	(slot categoria))

(defclass INUNDACION (is-a DESASTRENATURAL)
	(slot rio))


;;***********************************
;;
;;Funcion: Busqueda de datos
;;
;;*********************************** 

(deffunction busquedaDatosTerremoto()
	(bind ?cuerpo (send [noticia] get-cuerpo))

	(bind ?encontrado FALSE)
	
	;;***********Busqueda del dia
	(bind ?dia "Desconocido")
	(bind ?dias (create$ "hoy" "ayer" "antes de ayer" "mañana" "pasado mañana" "lunes" "martes" "miercoles"
				"jueves" "viernes" "sabado" "domingo"))
	(progn$ (?d ?dias)
		(if (str-index ?d (lowcase ?cuerpo))
			then
			(bind ?dia ?d)
		)
	)

	;;*******Busqueda de la hora*******
	(bind ?hora "Desconocida")
	
	;;Cogemos los dos puntos de la hora
	(bind ?posPuntos (str-index ":" (lowcase ?cuerpo)))
	(if ?posPuntos
		then
		(bind ?hora (sub-string (- ?posPuntos 2) (+ ?posPuntos 2) ?cuerpo))
		
	)

	;;******Busqueda del lugar
	(bind ?lugar "Desconocido")
	(bind ?lugares (create$ "montañana" "valle" "ciudad" "playa" "cueva" "acantilado" "peru"))
	(progn$ (?lug ?lugares)
		(if (str-index ?lug (lowcase ?cuerpo))
			then
			(bind ?lugar ?lug)
		)
	)

	;;*******Busqueda daños materiales
	(bind ?dagnos "")
	(bind ?posPtas (str-index "pesetas" (lowcase ?cuerpo)))
	(if ?posPtas
		then
		;;Busco el numero para la cantidad
		(bind ?simbolos (explode$ (sub-string 1 (+ ?posPtas 6) ?cuerpo)))
		(bind ?encontrado FALSE)
		(bind ?numElementos (length$ ?simbolos))
		(bind ?sim (nth$ ?numElementos ?simbolos))
		(while (and (not ?encontrado) (not (eq ?numElementos 0))) do
			(bind ?dagnos (str-cat ?sim " " ?dagnos))
			(if (numberp ?sim)
				then
				(bind ?encontrado TRUE)
			) 
			(bind ?numElementos (- ?numElementos 1))
			(bind ?sim (nth$ ?numElementos ?simbolos))
		)
	)

	;;******Busqueda de muertos
	(bind ?muertos "Desconocidos")
	;;Palabras relacionadas con muertos
	(bind ?relacionMuertos (create$ "muertos" "mato" "murieron" "acabo con la vida de" "muertes" ))

	(progn$ (?palabra ?relacionMuertos)
		(bind ?posPalabraMuerte (str-index ?palabra (lowcase ?cuerpo)))
		(if ?posPalabraMuerte
			then	
			;;Buscamos el numero de muertos antes
			(bind ?posibleMuertosAntes "")
			(bind ?encontrado FALSE)
			(bind ?simbolos (explode$ (sub-string 1 ?posPalabraMuerte ?cuerpo)))
			(bind ?numElementos (length$ ?simbolos))
			(bind ?sim (nth$ ?numElementos ?simbolos))
			(while (and (not ?encontrado) (not (eq ?numElementos 0))) do
				(if (numberp ?sim)
					then
					(bind ?encontrado TRUE)
					(bind ?posibleMuertosAntes (str-cat ?sim))
				)
				(bind ?numElementos (- ?numElementos 1))
				(bind ?sim (nth$ ?numElementos ?simbolos))
			)
			;;Buscamos el numero de muertos despues	
			(bind ?posibleMuertosDespues "")	
			(bind ?encontrado FALSE)
			(bind ?simbolos (explode$ (sub-string ?posPalabraMuerte (length$ ?cuerpo) ?cuerpo)))
			(bind ?numElementos (length$ ?simbolos))
			(bind ?i 1)
			(while (and (not ?encontrado) (not (eq ?numElementos ?i))) do
				(bind ?sim (nth$ ?i ?simbolos))
				(if (numberp ?sim)
					then
					(bind ?encontrado TRUE)
					(bind ?posibleMuertosDespues (str-cat ?sim))
				)
				(bind ?i (+ ?i 1))
			)
			;;El numero que esté mas cerca de la palabra relacionada con la muerte consideramos que es el numero de muertes
			(if (< (abs (- (str-index ?posibleMuertosDespues ?cuerpo) ?posPalabraMuerte)) 
				(abs (- (str-index ?posibleMuertosAntes ?cuerpo) ?posPalabraMuerte)))
				then
					(bind ?muertos ?posibleMuertosDespues)
				else
					(bind ?muertos ?posibleMuertosAntes)
			)
		)
	)

	;;******Busqueda heridos
	(bind ?heridos "Desconocidos")
	;;Palabras relacionadas con heridos
	(bind ?relacionHeridos (create$ "heridos" "hirio" "resultaron heridos" "resultaron heridas"))

	(progn$ (?palabra ?relacionHeridos)
		(bind ?posPalabraHeridos (str-index ?palabra (lowcase ?cuerpo)))
		(if ?posPalabraHeridos
			then	
			;;Buscamos el numero de heridos antes
			(bind ?posibleHeridosAntes "")
			(bind ?encontrado FALSE)
			(bind ?simbolos (explode$ (sub-string 1 ?posPalabraHeridos ?cuerpo)))
			(bind ?numElementos (length$ ?simbolos))
			(bind ?sim (nth$ ?numElementos ?simbolos))
			(while (and (not ?encontrado) (not (eq ?numElementos 0))) do
				(if (numberp ?sim)
					then
					(bind ?encontrado TRUE)
					(bind ?posibleHeridosAntes (str-cat ?sim))
				)
				(bind ?numElementos (- ?numElementos 1))
				(bind ?sim (nth$ ?numElementos ?simbolos))
			)
			;;Buscamos el numero de heridos despues	
			(bind ?posibleHeridosDespues "")	
			(bind ?encontrado FALSE)
			(bind ?simbolos (explode$ (sub-string ?posPalabraHeridos (length$ ?cuerpo) ?cuerpo)))
			(bind ?numElementos (length$ ?simbolos))
			(bind ?i 1)
			(while (and (not ?encontrado) (not (eq ?numElementos ?i))) do
				(bind ?sim (nth$ ?i ?simbolos))
				(if (numberp ?sim)
					then
					(bind ?encontrado TRUE)
					(bind ?posibleHeridosDespues (str-cat ?sim))
				)
				(bind ?i (+ ?i 1))
			)
			;;El numero que esté mas cerca de la palabra relacionada con los heridos consideramos que es el numero de heridos
			(if (< (abs (- (str-index ?posibleHeridosDespues ?cuerpo) ?posPalabraHeridos)) 
				(abs (- (str-index ?posibleHeridosAntes ?cuerpo) ?posPalabraHeridos)))
				then
					(bind ?heridos ?posibleHeridosDespues)
				else
					(bind ?heridos ?posibleHeridosAntes)
			)
		)
	)
	;;******Busqueda de falla
	(bind ?falla "Desconocida")
	(bind ?posFalla (str-index "falla" (lowcase ?cuerpo)))
	(if ?posFalla
		then
		(bind ?falla "")
		
		;; Iterador para encontrar el nombre despues de falla		
		(bind ?encontrado FALSE)

		;;Separamos todos los elementos que estan despues de la palabra falla
		(bind ?simbolos (explode$ (sub-string ?posFalla (length$ ?cuerpo) ?cuerpo)))

		(bind ?numMaxElementos (length$ ?simbolos))
		(bind ?iter 1)
		
		(bind ?sim (nth$ ?iter ?simbolos))

		;;Buscamos
		(while (and (not ?encontrado) (not (eq ?iter ?numElementos))) do
			;;Si la palabra empieza por mayuscula es el nombre propio de la falla
			(if (eq (sub-string 1 1 (str-cat ?sim)) (upcase (sub-string 1 1 (str-cat ?sim))))
				then			
				(bind ?encontrado TRUE)

				;;Guarda esta parte del nombre en la variable
				(bind ?falla (str-cat ?sim " "))
				;;Paso al siguiente elemento
				(bind ?iter (+ ?iter 1))
				(bind ?sim (nth$ ?iter ?simbolos))	
					
				;;Mientras que haya palabras en mayusculas es el nombre propio
				(while (eq (sub-string 1 1 (str-cat ?sim)) (upcase (sub-string 1 1 (str-cat ?sim)))) do
					(bind ?falla (str-cat ?falla " " ?sim ))
					(bind ?iter (+ ?iter 1))
					(bind ?sim (nth$ ?iter ?simbolos))
					
				)
			)
			(bind ?iter (+ ?iter 1))
			(bind ?sim (nth$ ?iter ?simbolos))
		)
	)	


	;;******Busqueda Magnitud
	(bind ?magnitud "Desconocida")
	(bind ?posMagnitud (str-index "magnitud" (lowcase ?cuerpo)))

	(if ?posMagnitud
		then
		(bind ?encontrado FALSE)
		(bind ?simbolos (explode$ (sub-string ?posMagnitud (length$ ?cuerpo) ?cuerpo)))
		(bind ?numElementos (length$ ?simbolos))
		(bind ?i 1)
		(while (and (not (eq ?i ?numElementos)) (not ?encontrado))
			(bind ?sim (nth$ ?i ?simbolos))
			(if (floatp ?sim)
				then
				(bind ?magnitud (str-cat ?sim))
			)
			(bind ?i (+ ?i 1))			
		)
	)

	;;Guardamos el suceso
	(make-instance [ter] of TERREMOTO (hora ?hora) (dia ?dia) (lugar ?lugar) (dagnos ?dagnos) (falla ?falla)
					  (muertos ?muertos) (heridos ?heridos) (magnitud ?magnitud))
);

;;***********************************
;;
;;Funcion: Busqueda de tipo
;;
;;*********************************** 

;; Busca el tipo de la noticia
(deffunction buscarTipo (?obj)
	(if (or (str-index "terremoto" (lowcase (send ?obj get-titular))) 
		(str-index "terremoto" (lowcase (send ?obj get-cuerpo))) )
		then
;;		(make-instance terremoto of TERREMOTO)
		(busquedaDatosTerremoto)
	)
	(if (or (str-index "huracan" (lowcase (send ?obj get-titular))) 
		(str-index "huracan" (lowcase (send ?obj get-cuerpo))) )
		then
		(make-instance huracan of HURACAN)
	)
	(if (or (str-index "inundacion" (lowcase (send ?obj get-titular))) 
	    	(str-index "inundacion" (lowcase (send ?obj get-cuerpo))) )
		then
		(make-instance inundacion of INUNDACION)
	)
);

;;***********************************
;;
;;		Demonios
;;
;;*********************************** 

(defmessage-handler NOTICIA put-cuerpo after(?valor)
	(buscarTipo ?self)
)

;;***********************************
;;
;;	Introducimos Noticias
;;
;;*********************************** 

(make-instance noticia of NOTICIA (titular "TERREMOTO EN PERU") (cuerpo "Hoy, un serio terremoto de magnitud 8.5 sacudio Peru el percance mato a 25 personas , un total de 98 personas resultaron heridas y ocasiono daños materiales por valor de 500 millones de pesetas. El Presidente del Peru dijo que el area mas afectada, cercana a la falla de San Juan, ha sido durante años una zona de peligro"))

(send [ter] print)

