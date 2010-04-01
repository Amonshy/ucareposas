(clear)

;; Definicion de la clase persona
(deftemplate persona
	     (slot nombre (default NIL))
	     (slot sexo (allowed-values hombre mujer))
	     (slot padre(default NIL))
	     (slot madre (default NIL))
	     (slot conyuge (default NIL))
	     (multislot hijos (default NIL))
	     (multislot hermanos (default NIL))
	     (multislot tios (default NIL))
	     (multislot abuelos (default NIL))
	     (multislot nietos (default NIL))
	     (multislot primos (default NIL))
)

;; Hechos iniciales
(deffacts initial-fact
	(persona (nombre Juan) (sexo hombre) (conyuge Sofia) (hijos Carlos Mateo Clara))
	(persona (nombre Sofia) (sexo mujer)(conyuge Juan) (hijos Carlos Mateo Clara))
 	(persona (nombre Carlos) (sexo hombre) (hermanos Mateo Clara) (padre Juan) (madre Sofia))
 	(persona (nombre Mateo) (sexo hombre) (hermanos Carlos Clara)(padre Juan) (madre Sofia) (conyuge Calixta) (hijos Amancio Amanda))
 	(persona (nombre Clara) (hermanos Carlos Mateo) (sexo mujer) (padre Juan) (madre Sofia) (conyuge Joao) (hijos Pepito Julia))
 	(persona (nombre Amancio) (sexo hombre) (hermanos Amanda) (padre Mateo) (madre Calixta))
 	(persona (nombre Amanda) (sexo mujer) (hermanos Amancio) (padre Mateo) (madre Calixta))
 	(persona (nombre Pepito) (sexo hombre) (hermanos Julia) (padre Joao) (madre Clara))
 	(persona (nombre Julia) (sexo mujer) (hermanos Pepito) (padre Joao) (madre Clara) (conyuge Mario) (hijos Julieta Juanete))
 	(persona (nombre Julieta) (sexo mujer) (hermanos Juanete) (padre Mario) (madre Julia))
 	(persona (nombre Juanete) (sexo hombre) (hermanos Julieta) (padre Mario) (madre Julia))
	  
)
(reset)


;; Reglas establecidas
(defrule reglaNietos
	(persona (nombre ?x) (hijos $?listaHijos&:(eq (member$ NIL $?listaHijos) FALSE)))
	?a<-(persona (hijos $? ?x $?) (nietos $?listaNietos))
	(test (not (subsetp $?listaHijos $?listaNietos)))
=>
	(bind $?listaNietos (delete-member$ $?listaNietos NIL))
	(modify ?a (nietos (create$ $?listaHijos $?listaNietos)))
)

(defrule reglaAbuelos
	?nieto<-(persona (nombre ?x) (abuelos $?listAbuelos&:(< (length$ $?listAbuelos) 2)))
	(persona (nombre ?abu) (nietos $? ?x $?))
	(test (not (member$ ?abu $?listAbuelos))) 
=>
	(bind $?listAbuelos (delete-member$ $?listAbuelos NIL))
	(modify ?nieto (abuelos (create$ $?listAbuelos ?abu)))

)

(defrule reglaTios
	?s<-(persona (nombre ?x) (tios $?listaTios))
	(persona (hijos $? ?x $?) (hermanos $?listaHerm&:(not (member$ NIL $?listaHerm))))
	(test (not (subsetp $?listaHerm $?listaTios)))
=>
	(bind $?listaTios (delete-member$ $?listaTios NIL))
	(modify ?s (tios (create$ $?listaTios $?listaHerm)))
)	

(defrule reglaPrimos
	(persona (nombre ?y) (hijos $?lHijos&:(not (member$ NIL $?lHijos))))
	?p<-(persona (nombre ?x) (tios $? ?y $?) (primos $?lPrimos))
	(test (not (subsetp $?lHijos $?lPrimos)))
=>
	(bind $?lPrimos (delete-member$ $?lPrimos NIL))
	(modify ?p (primos (create$ $?lHijos $?lPrimos)))
)

(defrule reglaImprimePrimas
  (persona (nombre ?z) (sexo mujer))
  (persona (nombre ?y) (hijos $? ?z $?))
  (persona (nombre ?x) (tios $? ?y $?))
  (not (impreso ?z ?x))
  =>
  (assert (impreso ?z ?x))
  (printout t ?z " es prima de " ?x crlf)
)

(defrule reglaImprimePrimos
  (persona (nombre ?z) (sexo hombre))
  (persona (nombre ?y) (hijos $? ?z $?))
  (persona (nombre ?x) (tios $? ?y $?))
  (not (impreso ?z ?x))
  =>
  (assert (impreso ?z ?x))
  (printout t ?z " es primo de " ?x crlf)
)

(run)

