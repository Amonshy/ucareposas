(clear)
(deffacts initial-fact
	(piromano Juan)
	(delincuente Juan))
(reset)

;;Reglas
(defrule condena
	(piromano ?p)
	(delincuente ?p)
	=>
	(assert (condena50 ?p)))

(defrule estudiante
	(condena50 ?p)
	=>
	(assert (estudianteDerecho ?p)))

(defrule esHonrado
	(estudianteDerecho ?p)
	=>
	(assert (honrado ?p)))

(facts)
(run)
(facts)

