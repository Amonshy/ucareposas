(clear)

(deftemplate persona
    (slot nombre (default NIL))
    (slot sexo (default NIL))
    (slot padre (default NIL))
    (slot madre (default NIL))
    (slot conyuge (default NIL))
    (multislot hijos (default NIL))
    (multislot hermanos (default NIL))
    (multislot tios (default NIL))
    (multislot sobrinos (default NIL))
    (multislot abuelos (default NIL))
    (multislot nietos (default NIL))
    (multislot primos (default NIL))
)
    
(deffacts initial-fact
    (persona (nombre juan) (sexo hombre) (conyuge sofia) (hijos carlos mateo clara))
    (persona (nombre sofia) (sexo mujer) (conyuge juan) (hijos carlos mateo clara))
    (persona (nombre carlos) (sexo hombre) (padre juan) (madre sofia) (hermanos mateo clara))
    (persona (nombre mateo) (sexo hombre) (padre juan) (madre sofia) (conyuge calixta) (hijos amancio amanda) (hermanos carlos clara))
    (persona (nombre clara) (sexo mujer) (padre juan) (madre sofia) (conyuge joao) (hijos pepito julia) (hermanos carlos mateo))
    (persona (nombre amancio) (sexo hombre) (padre mateo) (madre calixta) (hermanos amanda))
    (persona (nombre amanda) (sexo mujer) (padre mateo) (madre calixta) (hermanos amancio))
    (persona (nombre pepito) (sexo hombre) (padre joao) (madre clara) (hermanos julia))
    (persona (nombre julia) (sexo mujer) (padre joao) (madre clara) (conyuge mario) (hijos julieta juanete) (hermanos pepito))
    (persona (nombre julieta) (sexo mujer) (padre mario) (madre julia) (hermanos juanete))
    (persona (nombre juanete) (sexo hombre) (padre mario) (madre julia) (hermanos julieta))
)

(reset)

(defrule regla_nietos
    (persona (nombre ?x) (hijos $?hijos & : (neq (first$ $?hijos) (create$ NIL))))
    ?p<-(persona (hijos $? ?x $?) (nietos $?nietos))
    (test (not (member$ $?hijos $?nietos)))
    =>
    (bind $?nietos (delete-member$ $?nietos NIL))
    (modify ?p (nietos (create$ $?hijos $?nietos)))
)

(defrule regla_abuelos
    ?p<-(persona (nombre ?x) (abuelos $?abuelos))
    (persona (nombre ?abuelo) (nietos $? ?x $?))
    (test (not (member$ ?abuelo $?abuelos)))
    =>
    (bind $?abuelos (delete-member$ $?abuelos NIL))
    (modify ?p (abuelos (create$ ?abuelo $?abuelos)))
)

(defrule regla_tios
    ?p<-(persona (nombre ?x) (tios $?tios))
    (persona (nombre ?padre) (hijos $? ?x $?) (hermanos $?hermanos & : (not (member$ NIL $?hermanos))))
    (test (not (subsetp $?hermanos $?tios)))
    =>
    (bind $?tios (delete-member$ $?tios NIL))
    (modify ?p (tios (create$ $?hermanos $?tios)))
)

(defrule regla_sobrinos
    (persona (nombre ?x) (tios $? ?y $?))
    ?p<-(persona (nombre ?y) (sobrinos $?sobrinos))
    (test (not (member$ ?x $?sobrinos)))
    =>
    (bind $?sobrinos (delete-member$ $?sobrinos NIL))
    (modify ?p (sobrinos (create$ ?x $?sobrinos)))
)

(defrule regla_primos
    ?p<-(persona (nombre ?x) (tios $? ?y $?) (primos $?primos))
    (persona (nombre ?y) (hijos $?hijos & : (not (member$ NIL $?hijos))))
    (test (not (subsetp $?hijos $?primos)))
    =>
    (bind $?primos (delete-member$ $?primos NIL))
    (modify ?p (primos (create$ $?hijos $?primos)))
)

(defrule regla_imprimir_primos
    (persona (nombre ?x) (sexo hombre) (primos $?primos & : (not (member$ NIL $?primos))))
    (persona (nombre ?y) (primos $? ?x $?))
;;     (not (impreso ?x ?y))
    =>
;;     (assert (impreso ?x ?y))
    (printout t ?x " es primo de " ?y crlf)
)

(defrule regla_imprimir_primas
    (persona (nombre ?x) (sexo mujer) (primos $?primos & : (not (member$ NIL $?primos))))
    (persona (nombre ?y) (primos $? ?x $?))
;;     (not (impreso ?x ?y))
    =>
;;     (assert (impreso ?x ?y))
    (printout t ?x " es prima de " ?y crlf)
)

(run)
(facts)
