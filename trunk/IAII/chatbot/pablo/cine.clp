;;;;;;;;;; FUNCIONES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  1. analisis1 : analiza las respuestas del usr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;***************************************
;; Función analisis1                    *
;; analiza la respuesta                 *
;;***************************************
(deffunction  analisis1 (?cadena)
  (if (str-index "hola" (lowcase ?cadena))
     then (assert (frase saludo));;; podria activar otra regla para contestar al hola
     else (assert (frase eco ?cadena))) ;;; por defecto realiza el eco
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
(printout t crlf crlf crlf)
(printout t 
"        Comienza a hablar con el ChatbotECO" crlf)
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
 (printout t  "           Tú> ")
 (bind ?resp (readline))
 (assert (respuesta (lowcase ?resp)))
 (analisis1 (lowcase ?resp))
)

;;***************************************
;; Regla salida-usr		        * 
;; Si la respuesta es de despedida      *
;; finaliza la conversación             *
;;***************************************

(defrule despedida
  (declare (salience 100)) ;;; prioridad mas alta que el resto de frases
  (respuesta "adios")
=>
  (printout t 
"         ChatbotECO> Muchas gracias por tu charla. Saludos" crlf crlf crlf)
  (retract *)
  (halt)
)
;;**********************************************
;; Regla ECO                                   *
;; devuelve la misma respuesta que el usuario  *
;; *********************************************
(defrule eco
  (declare (salience -1)) ;;; prioridad baja para intentar dar una respuesta mejor que el eco
  (frase eco ?cadena)
=>
     (printout t 
"       ChatbotECO> ¿ " ?cadena " ?" crlf)
     (retract *)
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
"       ChatbotECO>  Hola, ¿qué tal?  " crlf)
    (retract *)
    (assert (Achatear))
)
