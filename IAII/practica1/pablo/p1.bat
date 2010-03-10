(clear)
(deffacts initial-fact 
	(persona Maria) 
	(gaditana Maria))
(reset)

(defrule r1_andaluza
      (gaditana Maria)
              => (assert (andaluza Maria)))
(facts)
(rules)
(run)
(facts)
(rules)


