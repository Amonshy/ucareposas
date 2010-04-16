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

	;;Guardamos el suceso
	(make-instance [ter] of TERREMOTO (hora ?hora) (dia ?dia) (lugar ?lugar) (dagnos ?dagnos))
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

(make-instance noticia of NOTICIA (titular "TERREMOTO EN PERU") (cuerpo "Hoy, un serio terremoto de magnitud 8.5 sacudio Peru el percance mato a 25 personas y ocasiono daños materiales por valor de 500 millones de pesetas. El Presidente del Peru dijo que el area mas afectada, cercana a la falla de San Juan, ha sido durante años una zona de peligro"))

(send [ter] print)

