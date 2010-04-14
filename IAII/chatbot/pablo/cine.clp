(clear all)
;;;;;;;;;; FUNCIONES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  conocimientoCinefilo: Inicializa los conocimientos basicos del cinefilo
;;  analisis1 : analiza las respuestas del usr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;***************************************
;;Conjuntos de palabras                 *
;;C1: Cosas Relacionadas con el cine    *
;;C2: Peliculas                         *
;;C3: Generos de Peliculas              *
;;***************************************

;;***************************************
;; Función conocimientoCinefilo         *
;; Inserta todos los conocimientos      *
;; básicos del cinefilo                 *
;;***************************************

(deffunction conocimientoCinefilo ()
	(assert (c1 Director))
	(assert (c1 Actor))
        (assert (c1 Actriz))
	(assert (c1 "Banda Sonora Original"))
	(assert (c1 BSO))
	(assert (c1 Palomitas))
	(assert (c1 Pelicula))
	(assert (c1 Refresco))
	(assert (c1 Butaca))
	(assert (c2 300))
	(assert (c2 Alien))
	(assert (c2 Avatar))
	(assert (c2 "El Club de la Lucha"))
	(assert (c2 "La Jungla de Cristal"))
	(assert (c2 "La vida es bella"))
	(assert (c2 Matrix))
	(assert (c2 Seven))
	(assert (c3 Accion))
	(assert (c3 Comedia))
	(assert (c3 Romantica))
	(assert (c3 "Ciencia Ficcion"))
	(assert (c3 Suspense))
	(assert (c3 Thriller))
)

;;***************************************
;; Función analisis1                    *
;; analiza la respuesta                 *
;;***************************************

(deffunction  analisis1 (?cadena)
  (if (str-index "hola" (lowcase ?cadena))
     then (assert (frase saludo));;;
     else (assert (frase ?cadena)))
); analisis1

;;;;;;;;;; REGLAS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  1. iniciando
;;  2. chateando
;;  3. despedida
;;  4. eco
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
(conocimientoCinefilo)
(printout t crlf crlf crlf)
(printout t 
"        Comienza a hablar con el Chatbot Cinefilo" crlf)
(printout t
"        teclea cualquier frase sin caracteres raros y luego Enter" crlf crlf) 
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
 (assert (respuesta (lowcase ?resp)))
 (analisis1 (lowcase ?resp))
)

;;***************************************
;; Regla despedida		        * 
;; Si la respuesta es de despedida      *
;; finaliza la conversación             *
;;***************************************

(defrule despedida
  (declare (salience 100)) ;;; prioridad mas alta que el resto de frases
  (respuesta "adios")
=>
  (printout t 
"         Cinefilo> Muchas gracias por tu charla. Saludos" crlf crlf crlf)
  (retract *)
  (halt)
)
;;**********************************************
;; Regla ECO                                   *
;; devuelve la misma respuesta que el usuario  *
;; *********************************************
(defrule eco
  (declare (salience -1)) ;;; prioridad baja para intentar dar una respuesta mejor que el eco
  (frase ?cadena)
=>
     (printout t 
"       Cinefilo> ¿ " ?cadena " ?" crlf)
     (retract *)
     (conocimientoCinefilo)
     (assert (Achatear))  ;;; volvemos al bucle para esperar otra resp
)

;;***********************************************
;;
;;***********************************************
(defrule saludando
    (declare (salience 90))
    (frase saludo)
=>
    (printout t 
"       Cinefilo>  Hola, ¿que tal?  " crlf)
    (retract *)
    (assert (Achatear))
)
(assert (initial-fact))
(run)
