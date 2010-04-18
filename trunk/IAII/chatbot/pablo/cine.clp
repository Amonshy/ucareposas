(clear)
;;;;;;;;;; FUNCIONES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  conocimientoCinefilo: Inicializa los conocimientos basicos del cinefilo
;;  analisis : analiza las respuestas del usr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;*************************************
;;Variables globales de conocimientos *
;;				      *
;;*************************************

(defglobal
	?*directores* = (create$  "ridley scott" "james cameron" "quentin tarantino" "roberto benigni" "john mctiernan" "david fincher")
	?*actores* = (create$ "hugh jackman" "nicolas cage" "sam worthington")
	?*actrices* = (create$  "charlize theron" "milla jovovich" "keira knightley" )
	?*peliculas* = (create$ "300" "alien" "avatar" "romeo y julieta" "la jungla de cristal" "la vida es bella" "matrix" "seven")
	?*generos* = (create$ "accion" "comedia" "romantica" "ciencia ficcion" "suspense" "thriller")
	?*peliculas_accion* = (create$ "300" "la jungla de cristal")
	?*peliculas_comedia* = (create$ "ice age")
	?*peliculas_drama* = (create$ "la vida es bella")
	?*peliculas_romantica* = (create$ "romeo y julieta")
	?*peliculas_cienciaficcion* = (create$ "matrix" "avatar" "alien")
	?*peliculas_suspense* = (create$ "seven")
)

;;***************************************
;;Conjuntos de palabras                 *
;;C1: Cosas Relacionadas con el cine    *
;;C2: Peliculas                         *
;;C3: Generos de Peliculas              *
;;***************************************


;;***************************************
;; Función analisis                     *
;; analiza la respuesta                 *
;;***************************************

(deffunction  analisis (?cadena)
	;;Conjuntos de palabras
	(bind ?c1 (create$ "director" "actor" "actriz" "palomitas" "pelicula" "refresco" "butaca"))
	(bind ?c2 (create$ "300" "alien" "avatar" "romeo y julieta" "la jungla de cristal" "la vida es bella" "matrix" "seven"))
	(bind ?c3 (create$ "accion" "comedia" "romantica" "ciencia ficcion" "suspense" "thriller"))


	;;Podemos seleccionar varios temas una vez escogido uno ya no miramos mas
	(bind ?temaSeleccionado FALSE)
	
	;;Guardamos las raices de los verbos que usaremos
	(bind ?verbos (create$ "gust" "dorm" "escuch" "visuali" "aburr" "odi"))
	
	;;Miramos si nos pide una recomendacion
	(if (and (str-index "me" ?cadena) (or (str-index "recomienda" ?cadena) (str-index "recomendar" ?cadena)))
		then
		;;Miramos si pide recomendacion por algo concreto
		(bind ?temaSeleccionado TRUE)
		(bind ?recomendacionConcreta FALSE)
		(progn$ (?queRecomendar ?c1)
			(if (str-index ?queRecomendar ?cadena)
				then
				(bind ?recomendacionConcreta TRUE)	
				(assert (recomendar ?queRecomendar))
			)
		)
		
		;;Miramos si me pide alguna pelicula de algun genero en particular
		(if (str-index "genero" ?cadena)
			then
			(bind ?recomendacionConcreta TRUE)
			(bind ?conocido FALSE)
			(progn$ (?palabra ?c3)
				(if (str-index ?palabra ?cadena)
					then
					(bind ?conocido ?palabra)
				)
			)
			(if ?conocido
				then
				(assert (recomendar genero ?conocido))
				else
				(assert (recomendar genero no))
			)
		)
		;;Si me pide algo que no conozco le pregunto que quiere
		(if (not ?recomendacionConcreta)
			then		
			(assert (recomendar preguntar))
			)
	)

	;;Vemos si vamos a hablar de cine	
	(progn$ (?palabra ?c1)
		(if (and (str-index ?palabra ?cadena) (not ?temaSeleccionado))
			then
			(bind ?temaSeleccionado TRUE)
			;;Si esta hablando de algun director miro si es de los que conoce el chatbot
			(if (eq ?palabra "director")
				then
				(bind ?encontrado FALSE)
				(progn$ (?directores ?*directores*)
					(if (str-index ?directores ?cadena)
						then
						(bind ?encontrado ?directores)
					)
				)
				(if ?encontrado
						then
						(assert (director ?encontrado))
						else
						(assert (director no))
				)
			)

			;;Si esta hablando de algun actor miro si es de los que conoce el chatbot
			(if (eq ?palabra "actor")
				then
				(bind ?encontrado FALSE)
				(progn$ (?acts ?*actores*)
					(if (str-index ?acts ?cadena)
						then
						(bind ?encontrado ?acts)
					)
				)
				(if ?encontrado 	
					then
					(assert (actor ?encontrado))
					else
					(assert (actor no))
				)
			)

			;;Si esta hablando de alguna actriz miro si es de las que conoce el chatbot
			(if (eq ?palabra "actriz")
				then
				(bind ?encontrado FALSE)
				(progn$ (?acts ?*actrices*)
					(if (str-index ?acts ?cadena)
						then
						(bind ?encontrado ?acts)
					)
				)
				(if ?encontrado 	
					then
					(assert (actriz ?encontrado))
					else
					(assert (actriz no))
				)
			)
			;;Cosas relacionada con ver una peli, refrescos, asiento, etc
			(if (or (eq ?palabra "butaca") (eq ?palabra "palomitas") (eq ?palabra "refresco"))
				then
				(assert (cine ?palabra))
			)
			;;Si sale la palabra peli, busco si está entre las que conozco o no
			(if (eq ?palabra "pelicula")
				then
				(bind ?encontrado FALSE)
				(progn$ (?peli ?c2)
					(if (str-index ?peli ?cadena)
						then
						(bind ?encontrado TRUE)
						(assert (pelicula ?peli))
					)
				)
				(if (not ?encontrado)
					then
					(assert (pelicula no))
				)
			)
		)
	)
	
	;;Vemos si vamos a hablar de peliculas
	(if (not ?temaSeleccionado)
		then
		(progn$ (?palabra ?c2)
			(if (str-index ?palabra ?cadena)
				then
				(bind ?temaSeleccionado TRUE)
				(assert (pelicula ?palabra))
			)
		)
	)

	;;Vemos si vamos a hablar de algun genero	
	(if (and (not ?temaSeleccionado) (str-index "genero" ?cadena))
		then
		(bind ?temaSeleccionado TRUE)
		(bind ?conocido FALSE)
		(progn$ (?palabra ?c3)
			(if (str-index ?palabra ?cadena)
				then
				(bind ?conocido ?palabra)
			)
		)	
		(if ?conocido
			then
			(assert (genero ?conocido))
			else
			(assert (genero no))
		)
	)

	;;Miramos si dice algunas palabras de asentimiento, agradecimiento o algo para proseguir
	(bind ?c4 (create$ "ok" "muchas gracias" "gracias" "lo tendre en cuenta" "guay" "muy bien"))
	(if (not ?temaSeleccionado)
		then	
		(progn$ (?palabra ?c4)
			(bind ?encontrado FALSE)
			(if (str-index ?palabra ?cadena)
				then
				(bind ?encontrado TRUE)
				(bind ?temaSeleccionado TRUE)
			)
			(if ?encontrado
				then
				(assert (proseguir))
			)
		)
	)	
	;;Si no está hablando de cine lo encaminamos
	(if (not ?temaSeleccionado)
		then
		(assert (encamina))
	)

		;;Vemos si es un saludo
	(if (eq "hola" (lowcase ?cadena))
		then
 		(assert (saludo))
	)

	;;Vemos si es una despedida
	(if (eq "adios" (lowcase ?cadena))
		then
 		(assert (despedida))
	)
); analisis

;;********************************************************
;; Función fraseRespuestaDirectorAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de directores
;;********************************************************

(deffunction fraseRespuestaDirectorAleatoria (?num)
	(bind ?res "")
	(if (eq ?num 0)
		then
		(bind ?res "Tendre que ver algo mas de ese director, parece interesante.")
	)
	(if (eq ?num 1)
		then
		(bind ?res "Puedes decirme todo cuanto quieras pero nadie supera a James Cameron.")
	)
	(if (eq ?num 2)
		then
		(bind ?res "Bueno, espero que no acabe su carrera siendo un director mas del monton.")
	)
	(if (eq ?num 3)
		then
		(bind ?res "Yo podria ser director, tengo grandes ideas, cualquier dia veras algo mio.")
	)
	(if (eq ?num 4)
		then
		(bind ?res "Me parece muy curioso me lo apunto en mi lista de mis cosas pendientes.")
	)
	?res
)

;;********************************************************
;; Función fraseRespuestaPeliculaAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de pelis
;;********************************************************
(deffunction  fraseRespuestaPeliculaAleatoria (?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		
		(bind ?res "No se tu pero yo disfrute como un niño chico toda la pelicula.")
	)
	(if (eq ?num 1)
		then
		(bind ?res "Pues yo no fui capaz de apartar la vista de la pantalla en todo momento.")
	)
	(if (eq ?num 2)
		then
		(bind ?res "Yo solo puedo describirtela en dos palabras IM PRESIONANTE.")
	)
	(if (eq ?num 3)
		then
		(bind ?res "Es un peliculon en mayusculas.")
	)
	(if (eq ?num 4)
		then
		(bind ?res "Yo la vería una y mil veces y aun asi no podría elegir una escena favorita.")
	)
	?res
)

;;********************************************************
;; Función fraseRespuestaPeliculaDesconocidaAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de pelis
;;********************************************************
(deffunction  fraseRespuestaPeliculaDesconocidaAleatoria (?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res "Pues habrá que verla entonces.")
	)
	(if (eq ?num 1)
		then
		(bind ?res "Me ha llamado la atencion, posiblemente baje al videoclub a alquilarla.")
	)
	(if (eq ?num 2)
		then
		(bind ?res "No acaba de convencerme posiblemente no pagaria por verla.")
	)
	(if (eq ?num 3)
		then
		(bind ?res "Bueno no me gusta ir con prejuicios, sacare tiempo y la vere.")
	)
	(if (eq ?num 4)
		then
		(bind ?res "Mmm, quizas la vea.")
	)
	?res
)

;;********************************************************
;; Función fraseRespuestaActorActrizAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de actores
;;********************************************************

(deffunction fraseRespuestaActorActrizAleatoria (?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res "No sabia nada creo que me lo apunto para el futuro.")
	)
	(if (eq ?num 1)
		then
		(bind ?res "De todas formas ya no hay actores y actrices como los de antes, a veces son mejores.")
	)
	(if (eq ?num 2)
		then
		(bind ?res "Quien fuera actor, dinero, fama, mujeres lo tienen todo :P.")
	)
	(if (eq ?num 3)
		then
		(bind ?res "Guau!, intentare ver alguna pelicula suya y ya te comentaré.")
	)
	(if (eq ?num 4)
		then
		(bind ?res "Hoy en dia salen actores y actrices de debajo de las piedras.")
	)
	?res
)

;;********************************************************
;; Función fraseRespuestaGeneroDesconocidoAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de actores
;;********************************************************

(deffunction fraseRespuestaGeneroDesconocidoAleatoria (?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res "No sabia nada creo que me lo apunto para el futuro.")
	)
	(if (eq ?num 1)
		then
		(bind ?res "No termina de llamarme la atencion, me quedo con mis clasicos")
	)
	(if (eq ?num 2)
		then
		(bind ?res "Donde este una buena pelicula de accion que se quite el resto.")
	)
	(if (eq ?num 3)
		then
		(bind ?res "Nunca me ire a la cama sin aprender algo nuevo, gracias por el aporte.")
	)
	(if (eq ?num 4)
		then
		(bind ?res "Que interesante, tendre que buscar informacion sobre ello.")
	)
	?res
)

;;********************************************************
;; Función frasePreguntaPeliculaAleatoria            
;; Devuelve una muletilla aleatoria cuando habla de pelis
;;********************************************************
(deffunction  frasePreguntaPeliculaAleatoria ()
	(bind ?num (mod (random) 5))	
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res  " ¿Cual fue la escena que mas te gusto?." )
	)
	(if (eq ?num 1)
		then
		(bind ?res " ¿Te gusto?.")
	)
	(if (eq ?num 2)
		then
		(bind ?res "¿Que opinas de ella?.")
	)
	(if (eq ?num 3)
		then
		(bind ?res  "¿No te parece?." )
	)
	(if (eq ?num 4)
		then
		(bind ?res " ¿La has visto?.")
	)
	?res
)

;;********************************************************
;; Función fraseComentarioPeliculaAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de pelis
;;********************************************************
(deffunction  fraseComentarioPeliculaAleatoria (?peli ?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res (str-cat ?peli " esta entre mis peliculas favoritas."))
	)
	(if (eq ?num 1)
		then
		(bind ?res (str-cat ?peli " es una gran pelicula."))
	)
	(if (eq ?num 2)
		then
		(bind ?res (str-cat ?peli " la conozco."))
	)
	(if (eq ?num 3)
		then
		(bind ?res (str-cat ?peli " engancha hasta el final."))
	)
	(if (eq ?num 4)
		then
		(bind ?res (str-cat ?peli ", no me cansaré de verla nunca."))
	)
	?res
)

;;********************************************************
;; Función fraseComentarioActorAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de pelis
;;********************************************************
(deffunction  fraseComentarioActorAleatoria (?act ?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res (str-cat ?act " es un gran profesional y sabe ganarse a los espectadores, y a las espectadoras creo que mas, jeje."))
	)
	(if (eq ?num 1)
		then
		(bind ?res (str-cat "Hace mucho tiempo que no veo nada de" ?act))
	)
	(if (eq ?num 2)
		then
		(bind ?res (str-cat "Creo que " ?act " tiene un gran futuro como actor."))
	)
	(if (eq ?num 3)
		then
		(bind ?res (str-cat ?act " es uno de mis actores favoritos."))
	)

	?res
)

;;********************************************************
;; Función fraseComentarioActrizAleatoria            
;; Devuelve una respuesta aleatoria cuando habla de pelis
;;********************************************************
(deffunction  fraseComentarioActrizAleatoria (?act ?num)
	(bind ?res "")	
	(if (eq ?num 0)
		then
		(bind ?res (str-cat ?act " es una gran actriz y si me lo permite es una belleza."))
	)
	(if (eq ?num 1)
		then
		(bind ?res (str-cat "Guau! " ?act " que mujer, tengo que ver algo de ella."))
	)
	(if (eq ?num 2)
		then
		(bind ?res (str-cat ?act " es una actriz que conozco, hace muy buenos trabajos."))
	)
	(if (eq ?num 3)
		then
		(bind ?res (str-cat "Espero que " ?act " tenga una larga carrera como actriz."))
	)
	?res
)

fraseProseguirAleatoria
;;***************************************
;; Función fraseProseguirAleatoria      *
;; Devuelve un director al azar         *
;;***************************************
(deffunction fraseProseguirAleatoria ()
	(bind ?frases (create$ "¿Hablamos de otra cosa?" "¿Tienes otra pregunta?" "¿Comentamos algo mas?" "¿Que mas podriamos tocar?"))
	(bind ?numMax (length$ ?frases))
	(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?frases))
	?res
)

;;***************************************
;; Función directorAleatorio            *
;; Devuelve un director al azar         *
;;***************************************
(deffunction directorAleatorio ()
	(bind ?numMax (length$ ?*directores*))
	(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*directores*))
	?res
)
;;***************************************
;; Función actorAleatorio               *
;; Devuelve un actor al azar            *
;;***************************************
(deffunction actorAleatorio ()
	(bind ?numMax (length$ ?*actores*))
	(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*actores*))
	?res
)
;;***************************************
;; Función actrizAleatoria              *
;; Devuelve una actriz al azar          *
;;***************************************
(deffunction actrizAleatoria ()
	(bind ?numMax (length$ ?*actrices*))
	(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*actrices*))
	?res
)
;;***************************************
;; Función peliculaAleatoria            *
;; Devuelve una pelicula al azar        *
;;***************************************
(deffunction peliculaAleatoria ()
	(bind ?numMax (length$ ?*peliculas*))
	(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas*))
	?res
)
;;***************************************
;; Función peliculaGeneroAleatoria      *
;; Devuelve una pelicula al azar        *
;;***************************************
(deffunction peliculaGeneroAleatoria (?genero)
	(bind ?res "")
	(if (eq ?genero "accion")
		then
		(bind ?numMax (length$ ?*peliculas_accion*))
		(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas_accion*))
	)
	(if (eq ?genero "comedia")
		then
		(bind ?numMax (length$ ?*peliculas_comedia*))
		(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas_comedia*))
	)
	(if (eq ?genero "drama")
		then
		(bind ?numMax (length$ ?*peliculas_accion*))
		(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas_accion*))
	)
	(if (eq ?genero "romantica")
		then
		(bind ?numMax (length$ ?*peliculas_romantica*))
		(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas_romantica*))
	)
	(if (eq ?genero "ciencia ficcion")
		then
		(bind ?numMax (length$ ?*peliculas_cienciaficcion*))
		(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas_cienciaficcion*))
	)
	(if (eq ?genero "suspense")
		then
		(bind ?numMax (length$ ?*peliculas_suspense*))
		(bind ?res (nth$ (+ (mod (random) ?numMax) 1) ?*peliculas_suspense*))
	)
	?res
)


;;***************************************
;; Función analisisRespuesta            *
;; analiza la respuesta                 *
;;***************************************

(deffunction analisisRespuesta (?cadena ?tipresp)
	;;Espera una respuesta para director	
	(if (eq ?tipresp "director")
		then
		(assert (respuesta (fraseRespuestaDirectorAleatoria (mod (random) 5))))	
	)	
	;;Espera una respuesta para actrices y actores
	(if (or (eq ?tipresp "actor") (eq ?tipresp "actriz"))
		then
		(assert (respuesta (fraseRespuestaActorActrizAleatoria (mod (random) 5))))
	)
	;;Respuestas para pelicula
	(if (eq ?tipresp "pelicula")
		then
		(if (str-index ninguna ?cadena)
			then
			(assert (respuesta "Entonces creo que no has visto esa pelicula, porque es genial, te la recomiendo."))
			else
			(assert (respuesta (fraseRespuestaPeliculaAleatoria (mod (random) 5))))	
		)
	)
	
	(if (eq ?tipresp "pelicula no")
		then
		(assert (respuesta (fraseRespuestaPeliculaDesconocidaAleatoria (mod (random) 5))))	

	)

	(if (eq ?tipresp "generodesconocido")
		then
		(assert (respuesta (fraseRespuestaGeneroDesconocidoAleatoria (mod (random) 5))))	

	)

	(if (str-index "generoconocido" ?tipresp)
		then
		(if (str-index "accion" ?tipresp)
			then
			(bind ?todas "")
			(progn$ (?pelis ?*peliculas_accion*)
				(bind ?todas (str-cat ?todas ?pelis))
			)
			(assert (respuesta (str-cat "Si hablamos de pelis de accion no podemos olvidar estas peliculas: " ?todas ".")))
		)
		(if (str-index "comedia" ?tipresp)
			then
			(bind ?todas "")
			(progn$ (?pelis ?*peliculas_comedia*)
				(bind ?todas (str-cat ?todas ?pelis))
			)
			(assert (respuesta (str-cat "Si hablamos de pelis de risa no podemos olvidar estas peliculas: " ?todas ".")))
		)
		(if (str-index "drama" ?tipresp)
			then
			(bind ?todas "")
			(progn$ (?pelis ?*peliculas_drama*)
				(bind ?todas (str-cat ?todas ?pelis))
			)
			(assert (respuesta (str-cat "Si hablamos de dramas no podemos olvidar estas peliculas: " ?todas ".")))
		)
		(if (str-index "romantica" ?tipresp)
			then
			(bind ?todas "")
			(progn$ (?pelis ?*peliculas_romantica*)
				(bind ?todas (str-cat ?todas ?pelis))
			)
			(assert (respuesta (str-cat "Si hablamos de pelis romanticas no podemos olvidar estas peliculas: " ?todas ".")))
		)
		(if (str-index "ciencia ficcion" ?tipresp)
			then
			(bind ?todas "")
			(progn$ (?pelis ?*peliculas_cienciaficcion*)
				(bind ?todas (str-cat ?todas ?pelis))
			)
			(assert (respuesta (str-cat "Si hablamos de pelis de ciencia ficcion no podemos olvidar estas peliculas: " ?todas ".")))
		)
		(if (str-index "suspense" ?tipresp)
			then
			(bind ?todas "")
			(progn$ (?pelis ?*peliculas_suspense*)
				(bind ?todas (str-cat ?todas ?pelis))
			)
			(assert (respuesta (str-cat "Si hablamos de pelis de suspense no podemos olvidar estas peliculas: " ?todas ".")))
		)	

	)

	(if (eq ?tipresp "recomendacion")
		then
		(bind ?recomendado FALSE)
		(if (str-index "peli" ?cadena)
			then
			(bind ?recomendado TRUE)
			(assert (respuesta (str-cat
					   	(fraseComentarioPeliculaAleatoria (peliculaAleatoria) (mod (random) 5))
			 			(frasePreguntaPeliculaAleatoria )) esperarespuesta "pelicula"))	
		)
		(if (str-index "actor" ?cadena)
			then
			(bind ?recomendado TRUE)
			(assert (respuesta (fraseComentarioActorAleatoria (actorAleatorio) (mod (random) 5))))	
		)
		(if (str-index "actriz" ?cadena)
			then
			(bind ?recomendado TRUE)
			(assert (respuesta (fraseComentarioActrizAleatoria (actrizAleatoria) (mod (random) 5))))	
		)	
		(if (str-index "director" ?cadena)
			then
			(bind ?recomendado TRUE)
			(assert (respuesta (str-cat "Creo que " (directorAleatorio) " puede ser una buena eleccion." )))	
		)
		(if (not ?recomendado)
			then
			(assert (respuesta "Si no eliges algo creo que no puedo ayudarte." ))	
		)

	)

	
	(if (eq "adios" ?cadena)
		then
 		(assert (despedida))
	)
);


;;;;;;;;;; REGLAS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  1. iniciandoChatbot
;;  2. chateando
;;  3. responder
;;  4. despedida
;;  5. encaminando
;;  6. saludo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;****************************************************
;; Iniciando el Chatbot                              *
;;                                                   *
;; Variables:                                        *
;;   ?ih - para borrar el hecho inicial una vez      *
;;         lanzado                                   *
;;****************************************************

(defrule iniciandoChatbot
 ?ih <- (initial-fact)
=>
(retract ?ih)
(printout t crlf crlf crlf)
(printout t 
"        Comienza a hablar con el Chatbot Cinefilo" crlf)
(printout t
"        teclea cualquier frase del tipo indicado en el manual sin caracteres raros y luego Enter" crlf crlf) 
(printout t
"        para finalizar teclea ADIOS " crlf crlf) 
(assert (Achatear))  
)

;;****************************************************
;; Regla: Chateando                                  *
;; recibe la respuesta del usuario                   *
;; y la envia para que sea analizada en otra regla   *
;; Variables:                                        *
;;   ?ih - para borrar el hecho que dispara la regla *
;;****************************************************

(defrule Chateando
 ?ih <- (Achatear)
=>
 (retract ?ih)
 (printout t  "           Tu> ")
 (bind ?resp (readline))
 (analisis (lowcase ?resp))
)

;;****************************************************
;; Regla: hablandoDeDirectorConocido                 *
;;						     *
;;****************************************************

(defrule hablandoDeDirectorConocido
	?dir <- (director ?d)
	(test (not (eq ?d no)))
=>
	(assert (respuesta (str-cat "Que opinas de "  ?d ", yo creo que es un gran director de cine.")))
	(retract ?dir)
)

;;****************************************************
;; Regla: hablandoDeDirectorDesconocido              *
;;						     *
;;****************************************************

(defrule hablandoDeDirectorDesconocido
	?dir <- (director ?d)
	(test (eq ?d no))
=>
	(assert (respuesta "¿Podrias hablarme de ese director y de su trabajo cinematografico." esperarespuesta (str-cat director)))
	(retract ?dir)
)

;;****************************************************
;; Regla: actorConocido			             *
;;						     *
;;****************************************************

(defrule actorConocido
	?act <- (actor ?a)
	(test (not (eq ?a no)))
=>
	(assert (respuesta (fraseComentarioActorAleatoria ?a (mod (random) 4))))
	(retract ?act)
)

;;****************************************************
;; Regla: actorDesconocido		             *
;;						     *
;;****************************************************

(defrule actorDesconocido
	?act <- (actor ?a)
	(test (eq ?a no))
=>
	(assert (respuesta "No conozco a ese actor, ¿ podrias describirmelo un poco y que tipo de peliculas hace?" esperarespuesta (str-cat actor)))
	(retract ?act)
)

;;****************************************************
;; Regla: actrizConocida		             *
;;						     *
;;****************************************************

(defrule actrizConocida
	?act <- (actriz ?a)
	(test (not (eq ?a no)))
=>
	(assert (respuesta (fraseComentarioActrizAleatoria ?a (mod (random) 4))))
	(retract ?act)
)

;;****************************************************
;; Regla: actrizDesconocida                          *
;;						     *
;;****************************************************

(defrule actrizDesconocida
	?act <- (actriz ?a)
	(test (eq ?a no))
=>
	(assert (respuesta "No conozco a esa actriz, ¿ podrias describirmela un poco y que tipo de peliculas hace?" esperarespuesta (str-cat actriz)))
	(retract ?act)
)

;;****************************************************
;; Regla: cosasDeCine			             *
;;						     *
;;****************************************************

(defrule cosasDeCine
	?cin <- (cine ?c)
=>
	(assert (respuesta (str-cat "Ahora que sacas el tema '" ?c "'. Creo que una peli sin palomitas y refresco y sin un buen asiento, no se disfruta al maximo.")))
	(retract ?cin)
)

;;****************************************************
;; Regla: peliculaConocida   		             *
;;						     *
;;****************************************************

(defrule peliculaConocida
	?pel <- (pelicula ?p)
	(test (not (eq ?p no)))
=>
	(assert (respuesta (str-cat (fraseComentarioPeliculaAleatoria ?p (mod (random) 5)) (frasePreguntaPeliculaAleatoria)) esperarespuesta "pelicula"))
	
	(retract ?pel)	
)

;;****************************************************
;; Regla: peliculaDesconocida    	             *
;;						     *
;;****************************************************
(defrule peliculaDesconocida
	?pel <- (pelicula ?p)
	(test (eq ?p no))
=>
	(assert (respuesta "No conozco esa pelicula, ¿cuentame algo mas sobre ella?" esperarespuesta "pelicula no"))
	(retract ?pel)	
)

;;****************************************************
;; Regla: queRecomendar   	                     *
;;						     *
;;****************************************************
(defrule queRecomendar
	?rec <- (recomendar preguntar)
=>
	(retract ?rec)
	(assert (respuesta "¿Que quieres que te recomiende?, una pelicula, un actor, una actriz o un director." esperarespuesta "recomendacion"))
	
)

;;****************************************************
;; Regla: recomendarConcretamente    	             *
;;						     *
;;****************************************************
(defrule recomendarConcretamente
	?rec <- (recomendar ?r)
	(test (not (eq ?r preguntar)))
=>
	(retract ?rec)	
	(analisisRespuesta (lowcase ?r) "recomendacion")
	
)

;;****************************************************
;; Regla: generoConocido 	   	             *
;;						     *
;;****************************************************
(defrule generoConocido
	?gen <- (genero ?g)
	(test (not (eq ?g no)))
=>
	(retract ?gen)	
	(assert (respuesta (str-cat "¿Que peliculas del genero " ?g " te gustan?") esperarespuesta (str-cat "generoconocido-" ?g)))
	
)

;;****************************************************
;; Regla: generoDesconocido 	   	             *
;;						     *
;;****************************************************
(defrule generoDesconocido
	?gen <- (genero no)
=>
	(retract ?gen)	
	(assert (respuesta "No conocia ese genero, ¿podria ilustrarme un poco?" esperarespuesta "generodesconocido"))
	
)

;;****************************************************
;; Regla: recomendarPeliGeneroDesconocido            *
;;						     *
;;****************************************************
(defrule recomendarPeliGeneroDesconocido
	?rec <- (recomendar genero no)
=>
	(retract ?rec)	
	(assert (respuesta "No puedo ayudarte con ese genero, no lo conozco, lo siento."))
	
)

;;****************************************************
;; Regla: recomendarPeliGeneroConocido               *
;;						     *
;;****************************************************
(defrule recomendarPeliGeneroConocido
	?rec <- (recomendar genero ?g)
	(test (not (eq ?g no)))
=>
	(retract ?rec)	
	(assert (respuesta (str-cat (fraseComentarioPeliculaAleatoria (peliculaGeneroAleatoria ?g) (mod (random) 5)))))
	
)

;;****************************************************
;; Regla: proseguir			             *
;;						     *
;;****************************************************
(defrule proseguir
	?pro <- (proseguir)
=>
	(retract ?pro)	
	(assert (respuesta (fraseProseguirAleatoria)))
	
)

;;****************************************************
;; Regla: responder                                  *
;; Esta regla intenta dar una respuesta dentro       *
;; del ambito del cinefilo			     *
;;****************************************************

(defrule responder
	?res<-(respuesta ?c)
=>
	(printout t "         Cinefilo> " ?c "" crlf)
  	(retract ?res)
  	(assert (Achatear))
)

;;****************************************************
;; Regla: responderEsperandoRespuesta                *
;; Esta regla intenta dar una respuesta dentro       *
;; del ambito del cinefilo y espera contestacion     *
;;****************************************************

(defrule responderEsperandoRespuesta
	?res<-(respuesta ?c esperarespuesta ?tiprespuesta)
=>
	(printout t "         Cinefilo> " ?c "" crlf)
  	(retract ?res)
	(printout t  "           Tu> ")
 	(bind ?resp (readline))
	(analisisRespuesta (lowcase ?resp) ?tiprespuesta)
)

;;***************************************
;; Regla: despedida		        * 
;; Si la respuesta es de despedida      *
;; finaliza la conversación             *
;;***************************************

(defrule despedida
  (declare (salience 100)) ;;; prioridad mas alta que el resto de frases
  (despedida)
=>
  (printout t 
"         Cinefilo> Ha sido un placer conversar de cine contigo. Que la fuerza te acompañe." crlf crlf crlf)
  (retract *)
  (halt)
)

;;**********************************************
;; Regla: encaminando                           *
;; Encamina al usuario para que hable de cine  *
;; *********************************************
(defrule encaminando
  (declare (salience -1)) ;;; prioridad baja para intentar dar una respuesta mejor que el eco
  (encamina)
=>
     (printout t 
"       Cinefilo> Creo que se está yendo por las ramas, ¿por qué no hablamos de algo relacionado con el cine?, y si no le parece correcto lo dejamos por el momento." crlf)
     (retract *)
     (assert (Achatear))  ;;; volvemos al bucle para esperar otra resp
)

;;***********************************************
;;Regla: Saludo
;;Esta funcion saluda al usuario y borra todo lo
;;que se hubiera comentado hasta el momento
;;***********************************************
(defrule saludo
    (declare (salience 90))
    (saludo)
=>
    (printout t 
"       Cinefilo>  Muy buenas usuario, ¿de que le apetece hablar?" crlf)
    (retract *)
    (assert (Achatear))
)
(assert (initial-fact))
(run)
