(clear)
(deftemplate coche
	     (slot modelo)
	     (slot precio (default 13000))
	     (slot maletero (allowed-values pequeno mediano grande) (default grande))
	     (slot caballos (default 80))
	     (slot abs (allowed-values no si) (default si))
	     (slot consumo (default 8)))

(deffacts initial-fact
	(coche (modelo 1) (precio 12000) (maletero pequeno) (caballos 65) (abs no) (consumo 4.7))
	(coche (modelo 2) (precio 12500) (maletero pequeno) (caballos 80) (abs si) (consumo 4.9))
	(coche (modelo 3) (precio 13000) (maletero mediano) (caballos 100) (abs si) (consumo 7.8))
	(coche (modelo 4) (precio 14000) (maletero grande) (caballos 125) (abs si) (consumo 6.0))
	(coche (modelo 5) (precio 15000) (maletero pequeno) (caballos 147) (abs si) (consumo 8.5))
)
(reset)


