;;Guardamos la traza
(dribble-on traza_familiaUnisex)

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
	(hermanode Juanete Julieta))
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
	=>
	(assert (tio ?x ?s)))

(defrule reglaSobrinos
	(tio ?t ?s)
	=>
	(assert (sobrino ?s ?t)))
	

(defrule reglaPrimos
	(tio ?t ?p)
	(or (padre ?t ?x) (madre ?t ?x))
	(not (primo ?p ?x)) ;; Para no repetir en distinto orden
	=>
	(assert (primo ?x ?p)))

(defrule reglaAbuelos
	(esposos ?x ?y)
	(padre ?y ?h)
	(madre ?x ?h)
	(or (padre ?h ?n) (madre ?h ?n))
	=>
	(assert (abuelo ?x ?n))
	(assert (abuelo ?y ?n)))

(defrule reglaNietos
	(abuelo ?a ?n)
	=>
	(assert (nieto ?n)))

(defrule reglaBisabuelo
	(esposos ?x ?y)
	(abuelo ?x ?n)
	(abuelo ?y ?n)
	(or (padre ?n ?bn) (madre ?n ?bn))
	=>
	(assert (bisabuelo ?x ?bn))
	(assert (bisabuelo ?y ?bn)))

(run)
(facts)
(dribble-off)

