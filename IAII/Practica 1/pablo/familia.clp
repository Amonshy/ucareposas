;;Guardamos la traza
(dribble-on traza_familia)

(clear)
(deffacts initial-fact
	;;Matrimonios
	(esposos Sofia Juan)
	(esposos Calixta Mateo)
	(esposos Clara Joao)
	(esposos Julia Mario)	
	;;Paternidad
	(padre Juan Carlos)
	(madre Sofia Carlos)
	(padre Juan Mateo)
	(madre Sofia Mateo)
	(padre Juan Clara)
	(madre Sofia Clara)
	(padre Mateo Amancio)
	(madre Calixta Amancio)
	(padre Mateo Amanda)
	(madre Sofia Amanda)
	(padre Joao Pepito)
	(madre Clara Pepito)
	(padre Joao Julia)
	(madre Clara Julia)
	(padre Mario Julieta)
	(madre Julia Julieta)
	(padre Mario Juanete)
	(madre Julia Juanete)
	;;Hermandad
	(hermanode Carlos Mateo Clara)
	(hermanode Mateo Clara Carlos)
	(hermanode Clara Carlos Mateo)
	(hermanode Amancio Amanda)
	(hermanode Amanda Amancio)
	(hermanode Pepito Julia)
	(hermanode Julia Pepito)
	(hermanode Julieta Juanete)
	(hermanode Juanete Julieta)
	;;Sexo
	(mujer Sofia)
	(mujer Calixta)
	(mujer Clara)
	(mujer Amanda)
	(mujer Julia)
	(mujer Julieta)
	(hombre Juan)
	(hombre Carlos)
	(hombre Mateo)
	(hombre Joao)
	(hombre Amancio)
	(hombre Pepito)
	(hombre Mario)
	(hombre Juanete))
(reset)


;;Reglas establecidas

(defrule reglaTios
	(or 
	  (and (or (hermanode $? ?x $? ?p $?) (hermanode $? ?p $? ?x $?))
	       (or (padre ?p ?s) (madre ?p ?s))
	  )
	  (and (or (esposos ?x ?y) (esposos ?y ?x))
	       (or (hermanode $? ?y $? ?p $?) (hermanode $? ?p $? ?y $?))
	       (or (padre ?p ?s) (madre ?p ?s))
	  )	  	
	)
	(hombre ?x)
	=>
	(assert (tio ?x ?s)))

(defrule reglaTias
	(or 
	  (and (or (hermanode $? ?x $? ?p $?) (hermanode $? ?p $? ?x $?))
	       (or (padre ?p ?s) (madre ?p ?s))
	  )
	  (and (or (esposos ?x ?y) (esposos ?y ?x))
	       (or (hermanode $? ?y $? ?p $?) (hermanode $? ?p $? ?y $?))
	       (or (padre ?p ?s) (madre ?p ?s))
	  )	  	
	)
	(mujer ?x)
	=>
	(assert (tia ?x ?s)))

(defrule reglaSobrinos
	(or (tio ?t ?s) (tia ?t ?s))
	(hombre ?s)
	=>
	(assert (sobrino ?s ?t)))
	
(defrule reglaSobrinas
	(or (tio ?t ?s) (tia ?t ?s))
	(mujer ?s)
	=>
	(assert (sobrina ?s ?t)))

(defrule reglaPrimos
	(or (tio ?t ?s) (tia ?t ?s))
	(or (padre ?t ?x) (madre ?t ?x))
	(hombre ?x)
	=>
	(assert (primo ?x ?p)))

(defrule reglaPrimas
	(or (tio ?t ?s) (tia ?t ?s))
	(or (padre ?t ?x) (madre ?t ?x))
	(mujer ?x)
	=>
	(assert (prima ?x ?p)))

(defrule reglaAbuelos
	(esposos ?x ?y)
	(padre ?y ?h)
	(madre ?x ?h)
	(or (padre ?h ?n) (madre ?h ?n))
	=>
	(assert (abuela ?x ?n))
	(assert (abuelo ?y ?n)))

(defrule reglaNietos
	(or (abuelo ?a ?n) (abuela ?a ?n))
	(hombre ?n)
	=>
	(assert (nieto ?n ?a)))

(defrule reglaNietas
	(or (abuelo ?a ?n) (abuela ?a ?n))
	(mujer ?n)
	=>
	(assert (nieta ?n ?a)))

(defrule reglaBisabuelo
	(esposos ?x ?y)
	(abuela ?x ?n)
	(abuelo ?y ?n)
	(or (padre ?n ?bn) (madre ?n ?bn))
	=>
	(assert (bisabuela ?x ?bn))
	(assert (bisabuelo ?y ?bn)))

(run)
(facts)
(dribble-off)

