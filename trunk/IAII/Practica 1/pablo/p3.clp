(clear)
(reset)
(deftemplate persona
      (multislot nombre) ;para almacenar nombre y apellidos
      (slot dni (type INTEGER))
      (slot profesion (default estudiante))
      (slot nacionalidad (allowed-values Es Fr Po Al In It)))
(deftemplate intelectual_europeo
           (multislot nombre)
           (slot idioma))
(list-deftemplates)

(assert (persona (nombre Mateo Duran Barbera)
                  (dni 333221)))
(assert (persona (nombre Mario Cantero Cansino)
                  (dni 122333)
                  (profesion escritor)
                   (nacionalidad Es)))
(duplicate 2 (nombre Maria Ramos Cantero)
             (dni 4444))
(facts)

(modify 1 (profesion informatico))
(facts)

;; agenda

(defrule europeos
	(persona (nombre ?x ?y ?z)(nacionalidad Es)(profesion escritor))
	=>
	(assert (intelectual_europeo (nombre ?x ?y ?z)))
	(printout t ?x " " ?y " " ?z " " " es intelectual europeo"crlf))
(agenda)


