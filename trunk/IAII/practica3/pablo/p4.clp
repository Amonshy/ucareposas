(clear)

;; Clases que vamos a utilizar

(defclass NOTICIA (is-a USER)
	(slot titular)
	(slot cuerpo)
	(slot resumen)
)

(defclass SUCESO (is-a USER)
	(slot lugar)
	(slot dia)
	(slot hora)
	(slot noticia))

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

;; Funciones a utilizar

;; Busca el tipo de la noticia
(deffunction buscarTipo (?obj)
	(if (or (str-index "terremoto" (lowcase (send ?obj get-titular))) 
		(str-index "terremoto" (lowcase (send ?obj get-cuerpo))) )
		then
		(make-instance terremoto of TERREMOTO)
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

;;Busqueda de datos en la noticia

(deffunction busquedaDatos (?obj)
	(bind ?cuerpo (send [noticia] put-cuerpo))
	
);

;; Demonios 

(defmessage-handler NOTICIA put-cuerpo after(?valor)
	(buscarTipo ?self)
)


(defmessage-handler TERREMOTO create after()
	(busquedaDatos ?self)	
)

(defmessage-handler HURACAN create after()
	(busquedaDatos ?self)	
)

(defmessage-handler INUNDACION create after()
	(busquedaDatos ?self)	
)

;; Introducimos una noticia
(make-instance noticia of NOTICIA (titular "TERREMOTO EN PERU") (cuerpo "Hoy, un serio terremoto de magnitud 8.5 sacudio Peru el percance mato a 25 personas y ocasiono daños materiales por valor de 500 millones de pesetas. El Presidente del Peru dijo que el area mas afectada, cercana a la falla de SAn Juan, ha sido durante años una zona de peligro"))

