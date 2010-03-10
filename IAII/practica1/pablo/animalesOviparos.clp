(clear)
(deffacts initial-fact
	(animal paloma)
	(animal boa)
	(ponehuevo paloma)
	(ponehuevo boa)
	(tienepico paloma)
	(tienepluma paloma)
	(tienealas paloma))
(reset)

;;Reglas

(defrule esAve
	(tienepluma ?p)
	(tienepico ?p)
	(tienealas ?p)
	=>
	(assert (ave ?p)))

(defrule esOvipara
	(animal ?p)
	(ponehuevo ?p)
	=>
	(assert (oviparo ?p)))

(facts)
(run)
(facts)

