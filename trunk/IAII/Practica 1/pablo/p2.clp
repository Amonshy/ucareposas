(clear)
(deffacts initial-facts
	(persona Maria)
	(gaditana Maria))
(reset)

;;regla para andaluz

(defrule andaluza
	(persona ?p)
	(gaditana ?p)
	=>
	(assert (andaluza ?p))
	(printout t ?p "  es andaluza" crlf))

;;Regla para espagnol

(defrule espagnol
	(andaluza ?p)
	=>
	(assert (espagnol ?p)))




;;hechos

(assert (catalana Clara))
(assert (persona Montse))
(assert (gaditana Montse))
(assert (persona Maria))
(assert (gaditana Maria))
(assert (persona Clara))


(facts)
(run)
(facts)
