; MODULO 0
; Lectura de datos y obtención de valores inestables

(deftemplate empresa
	(field nombre)
	(field precio)
	(field vardia)
	(field capitalizacion)
	(field per)
	(field rpd)
	(field tama)
	(field ibex)
	(field etiqper)
	(field etiqrpd)
	(field sector)
	(field var5)
	(field perd3)
	(field perd5)
	(field resp5)
	(field vrs5)
	(field varmen)
	(field vartri)
	(field varsem)
	(field var12m)
)

(deftemplate sectores
	(field nombre)
	(field vardia)
	(field capitalizacion)
	(field per)
	(field rpd)
	(field ibex)
	(field var5)
	(field perd3)
	(field perd5)
	(field resp5)
	(field varmen)
	(field vartri)
	(field varsem)
	(field var12m)
)

(deftemplate noticia
	(field sector)
	(field noti)
)

(deftemplate cartera
	(field nombre)
	(field acciones)
	(field valorActual)
)

(deftemplate propuesta
	(field accion)
	(field nombre1)
	(field nombre2)
	(field re)
	(field rpd)
)

(deftemplate final
	(field accion)
	(field nombre1)
	(field nombre2)
	(field re)
	(field rpd)
	(field cont)
)

(deffacts contadores
	(contador 0)
	(totalCartera 0)
)

(deffacts opciones
	(opcion 0)	
)

(deffacts modulo
	(modulo 0)
	(modulo 4)
)

; MODULO 0

; TAREA 0.1 LECTURA DE LOS FICHEROS ANALISIS.TXT Y SECTORES.TXT
; Lectura de fichero analisis

; Regla para abrir el fichero analisis
(defrule openanalisis
	(declare (salience 10))
	=>
	(open "Analisis.txt" mydata)
	(assert (SeguirLeyendo))
)

; Regla para leer los valores del fichero
(defrule LeerAnalisis
	?f <- (SeguirLeyendo)
	=>
	(bind ?nombre (read mydata))
	(retract ?f)
	(if (neq ?nombre EOF) then
		(bind ?precio (read mydata))
		(bind ?vardia (read mydata))
		(bind ?capitalizacion (read mydata))
		(bind ?per (read mydata))
		(bind ?rpd (read mydata))
		(bind ?tama (read mydata))
		(bind ?ibex (read mydata))
		(bind ?etiqper (read mydata))
		(bind ?etiqrpd (read mydata))
		(bind ?sector (read mydata))
		(bind ?var5 (read mydata))
		(bind ?perd3 (read mydata))
		(bind ?perd5 (read mydata))
		(bind ?resp5 (read mydata))
		(bind ?vrs5 (read mydata))
		(bind ?varmen (read mydata))
		(bind ?vartri (read mydata))
		(bind ?varsem (read mydata))
		(bind ?var12m (read mydata))
		(assert (empresa
			(nombre ?nombre)
			(precio ?precio)
			(vardia ?vardia)
			(capitalizacion ?capitalizacion)
			(per ?per)
			(rpd ?rpd)
			(tama ?tama)
			(ibex ?ibex)
			(etiqper ?etiqper)
			(etiqrpd ?etiqrpd)
			(sector ?sector)
			(var5 ?var5)
			(perd3 ?perd3)
			(perd5 ?perd5)
			(resp5 ?resp5)
			(vrs5 ?vrs5)
			(varmen ?varmen)
			(vartri ?vartri)
			(varsem ?varsem)
			(var12m ?var12m)
			)
		)
		(assert (SeguirLeyendo)))
)

; Regla para abrir el fichero sectores
(defrule opensectores
	(declare (salience 10))
	=>
	(open "AnalisisSectores.txt" mydata2)
	(assert (SeguirLeyendo2))
)

(defrule LeerSectores
	?f <- (SeguirLeyendo2)
	=>
	(bind ?nombre (read mydata2))
	(retract ?f)
	(if (neq ?nombre EOF) then
		(bind ?vardia (read mydata2))
		(bind ?capitalizacion (read mydata2))
		(bind ?per (read mydata2))
		(bind ?rpd (read mydata2))
		(bind ?ibex (read mydata2))
		(bind ?var5 (read mydata2))
		(bind ?perd3 (read mydata2))
		(bind ?perd5 (read mydata2))
		(bind ?varmen (read mydata2))
		(bind ?vartri (read mydata2))
		(bind ?varsem (read mydata2))
		(bind ?var12m (read mydata2))
		(assert (sectores
			(nombre ?nombre)
			(vardia ?vardia)
			(capitalizacion ?capitalizacion)
			(per ?per)
			(rpd ?rpd)
			(ibex ?ibex)
			(var5 ?var5)
			(perd3 ?perd3)
			(perd5 ?perd5)
			(varmen ?varmen)
			(vartri ?vartri)
			(varsem ?varsem)
			(var12m ?var12m)
			)
		)
		(assert (SeguirLeyendo2)))
)


; TAREA 0.2 LECTURA DE LOS FICHEROS DE NOTICIAS y CARTERA

; Regla para abrir el fichero noticias
(defrule opennoticia
	(declare (salience 10))
	=>
	(open "Noticias.txt" mydata3)
	(assert (SeguirLeyendo3))
)

; Regla para leer las noticias
(defrule LeerNoticia
	?f <- (SeguirLeyendo3)
	=>
	(bind ?sector (read mydata3))
	(retract ?f)
	(if (neq ?sector EOF) then
		(bind ?noti (read mydata3))
		(assert (noticia
			(sector ?sector)
			(noti ?noti)
			)
		)
		(assert (SeguirLeyendo3))
		
	)
)

; Regla para abrir el fichero
(defrule opencartera
	(declare (salience 10))
	=>
	(open "Cartera.txt" mydata4)
	(assert (SeguirLeyendo4))
)

; Regla para leer la cartera
(defrule LeerCartera
	?f <- (SeguirLeyendo4)
	?total <- (totalCartera ?t)
	=>
	(bind ?nombre (read mydata4))
	(retract ?f)
	(if (neq ?nombre EOF) then
		(bind ?acciones (read mydata4))
		(bind ?valorActual (read mydata4))

		(assert (cartera
			(nombre ?nombre)
			(acciones ?acciones)
			(valorActual ?valorActual)
			)
		)
		(assert (SeguirLeyendo4))
		(bind ?t (+ ?t 1))
		(retract ?total)
		(assert (totalCartera ?t))
	)
)

; Regla para cerrar los ficheros
(defrule closefile
	(declare (salience -10))
	=>
	(close mydata)
	(close mydata2)
	(close mydata3)
	(close mydata4)
)

; TAREA 0.3 CALCULAR VALORES INESTABLES

; Regla para añadir valores inestables del sector de la construccion
(defrule valoresInestables1
	(empresa (nombre ?nombre) (sector Construccion))
	=>
	(assert(valorInestable ?nombre))
)

; Regla para añadir valores inestables según las noticias
(defrule valoresInestables2
	(empresa (nombre ?nombre) (sector ?s))
	(noticia (sector ?s) (noti negativo))
	=>
	(assert(valorInestable ?nombre))
)

; Regla para eliminar valores inestables seǵun las noticias
(defrule valoresInestables3
	(empresa (nombre ?nombre) (sector ?s))
	(noticia (sector ?s) (noti positivo))
	?variable <- (valorInestable ?nombre)
	=>
	(retract ?variable)
)


; MODULO 1
; Obtención de valores peligrosos

; Regla para añadir valores peligrosos en función de la pérdida durante 3 días
(defrule valoresPreligrosos1
	(cartera (nombre ?n_cartera))
	(valorInestable ?n_cartera)
	(empresa (nombre ?n_cartera) (perd3 true))
	=>
	(assert(valorPeligroso ?n_cartera))
)

; Regla para añadir valores peligrosos en función de la pérdida durante 5 días
(defrule valoresPreligrosos2
	(cartera (nombre ?n_cartera))
	(valorInestable ?n_cartera)
	(empresa (nombre ?n_cartera) (perd5 true) (vrs5 false))
	=>
	(assert(valorPeligroso ?n_cartera))
)

; MODULO 2
; Obtención de valores sobrevalorados

; Regla para añadir valores sobrevalorados en caso general
(defrule empresasSobrevaloradas
	(empresa (nombre ?nombre) (etiqper Alto) (etiqrpd Bajo))
	=>
	(assert(sobrevalorada ?nombre))
)

; Regla para añadir valores sobrevalorados para empresas pequeñas con PER alto
(defrule empresaSobrevaloradaPequenia
	(empresa (nombre ?nombre) (tama PEQUENIA) (etiqper Alto))
	=>
	(assert(sobrevalorada ?nombre))
)

; Regla para añadir valores sobrevalorados para empresas pequeñas con PER mediano
(defrule empresaSobrevaloradaPequenia2
	(empresa (nombre ?nombre) (tama PEQUENIA) (etiqper Mediano) (etiqrpd Bajo))
	=>
	(assert(sobrevalorada ?nombre))

)

; Regla para añadir valores sobrevalorados para empresas grandes con PER alto y RPD bajo
(defrule empresaSobrevaloradaGrande
	(empresa (nombre ?nombre) (tama GRANDE) (etiqper Alto) (etiqrpd Bajo))
	=>
	(assert(sobrevalorada ?nombre))
)

; Regla para añadir valores sobrevalorados para empresas grandes con PER mediano
(defrule empresaSobrevaloradaGrande2
	(empresa (nombre ?nombre) (tama GRANDE) (etiqper Mediano) (etiqrpd Bajo))
	=>
	(assert(sobrevalorada ?nombre))
)

; Regla para añadir valores sobrevalorados para empresas grandes con PER alto y RPD mediano
(defrule empresaSobrevaloradaGrande3
	(empresa (nombre ?nombre) (tama GRANDE) (etiqper Alto) (etiqrpd Mediano))
	=>
	(assert(sobrevalorada ?nombre))
)


; MODULO 3
; Obtención de valores infravalorados

; Regla para añadir valores infravalorados en caso general
(defrule empresasInfravaloradas
	(empresa (nombre ?nombre) (etiqper Bajo) (etiqrpd Alto))
	=>
	(assert(infravalorada ?nombre))
)

; Regla para añadir valores infravalorados si la empresa ha caído bastante
(defrule empresasInfravaloradas2
	(empresa (nombre ?nombre) (etiqper Bajo) (varmen ?vmen) (vartri ?vtri) (varsem ?vsem) (var12m ?v12))
	(or (or (test(<= ?vtri -30)) (test(<= ?vsem -30))) (test(<= ?v12 -30)))
	(test(> ?vmen 0))
    (test(<= ?vmen 5))
	=>
	(assert(infravalorada ?nombre))
)

; Regla para añadir valores infravalorados si la empresa es grande
(defrule empresasInfravaloradas3
	(empresa (nombre ?nombre) (etiqper Alto) (tama GRANDE) (etiqrpd Mediano) (perd3 false) (perd5 false) (resp5 ?resp5))
	(test(> ?resp5 0))
	=>
	(assert(infravalorada ?nombre))
)


; MODULO 4.1
(defrule venderEmpresasPeligrosas
	(modulo 4)
	(cartera (nombre ?n))
	(empresa (nombre ?n) (rpd ?rpd) (varmen ?vmen) (resp5 ?resp5))
	(valorPeligroso ?n)
	(test(< ?vmen 0))
	(test(<= ?resp5 -3))
	=>
	(bind ?re (- 20 ?rpd))
	(assert(propuesta (accion vender-pel) (nombre1 ?n) (nombre2 ?n) (re ?re) (rpd ?rpd)))
)

(defrule invertirEmpresaInfravalorada
	(modulo 4)
	(cartera (nombre ?nombre))
	(empresa (nombre ?n) (sector ?s) (per ?per) (rpd ?rpd))
	(infravalorada ?n)
	(cartera (nombre DISPONIBLE) (valorActual ?v))
	(sectores (nombre ?s) (per ?permedio))
	(test (> ?v 0))
	(test (neq ?nombre ?n))
	=>
	(bind ?re (/ (* (- ?permedio ?per) 100) (+ ?rpd (* 5 ?per))))
	(assert(propuesta (accion invertir) (nombre1 ?n) (nombre2 ?n) (re ?re) (rpd ?rpd)))
)

(defrule venderEmpresaSobrevalorada
	(modulo 4)
	(cartera (nombre ?n))
	(empresa (nombre ?n) (sector ?s) (per ?p) (rpd ?rpd))
	(sectores (nombre ?s) (per ?permedio))
	(sobrevalorada ?n)
	(test(< ?p 5))
	=>
	(bind ?re (/ (+ (* ?rpd -1) (- ?p ?permedio)) (* 5 ?p)))
	(assert(propuesta (accion vender-sob) (nombre1 ?n) (nombre2 ?n) (re ?re) (rpd ?rpd)))
)

(defrule cambiarAcciones
	(modulo 4)
	(cartera (nombre ?n))
	(infravalorada ?n0)
	(test(neq ?n ?n0))
	(empresa (nombre ?n) (rpd ?r1) (var12m ?v12m1))
	(empresa (nombre ?n1) (rpd ?r2) (var12m ?v12m2))
	(sobrevalorada ?n2)
	(infravalorada ?n3)
	(test(neq ?n1 ?n2))
	(test(neq ?n1 ?n3))
	(test(neq ?n ?n1))
	(test (> ?r1 (+ (+ (* ?v12m2 100) ?r2) (+ ?r2 1))))
	=>
	(bind ?re (- ?r1 (+ ?r2 1))) 
	(assert (propuesta (accion cambiar) (nombre1 ?n) (nombre2 ?n1) (re ?re) (rpd ?r1)))
)


; MODULO 4.2

(defrule propuestas-finales
	(declare (salience -10))
	?c <- (contador ?i)
	(test (!= ?i 5))
	?p <- (propuesta (accion ?accion) (nombre1 ?nombre1) (nombre2 ?nombre2) (re ?re) (rpd ?rpd))
	?mod <- (modulo ?m)
	=>
	(retract ?c)
	(retract ?p)
	(if (eq ?m 4) then 
		(retract ?mod)
	)
	(bind ?i (+ ?i 1))
	(assert (final (accion ?accion) (nombre1 ?nombre1) (nombre2 ?nombre2) (re ?re) (rpd ?rpd) (cont ?i)))
	(assert (contador ?i))

)	

(defrule finales-finales
	(declare (salience -100))
	?fin <- (final (accion ?accion) (nombre1 ?nombre1) (nombre2 ?nombre2) (re ?re) (cont ?i))
	?p <- (propuesta (accion ?a) (nombre1 ?n1) (nombre2 ?n2) (re ?r&:(> ?r ?re)) (rpd ?rpd))
	=>
	(assert (final (accion ?a) (nombre1 ?n1) (nombre2 ?n2) (re ?r) (rpd ?rpd) (cont ?i)))	
	(retract ?p)
	(retract ?fin)
)

(defrule mostrar-propuestas
	(declare (salience -1000))
	(final (accion ?a) (nombre1 ?n1) (nombre2 ?n2) (re ?re) (rpd ?rpd) (cont ?i))
	=>
	(assert (opcion 0))
	(if (eq ?a vender-pel) then
		(printout t "Propuesta " ?i " - Vender valores de la empresa " ?n1 ". Los valores de la empresa se consideran peligrosos; ademas esta entranado en tendencia bajista con respecto a su sector. Segun mi estimacion existe una probabilidad no despreciable de que pueda caer al cabo del anio un 20%, aunque produzca un " ?rpd "% por dividendos perderiamos un" ?re "%." crlf)
		else
		(if (eq ?a vender-sob) then 
			(printout t "Propuesta " ?i " - Vender valores de la empresa " ?n1 ". Esta empresa esta sobrevalorada, es mejor amortizar lo invertido, ya que seguramente el PER tan alto debera bajar al PER medio del sector en unos 5 anios, con lo que se deberia devaluar un" (- (* ?re 100) ?rpd) "% anual, así que aunque se pierda el " ?rpd "% de beneficios por dividendos saldria rentable." crlf)
			else
			(if (eq ?a invertir) then
				(printout t "Propuesta " ?i " - Invertir en " ?n1 ". Esta empresa esta infravalorada y seguramente el PER tienda al PER medio en 5 anios, con lo que se deberia revalorizar " (- ?re ?rpd) "% anual a lo que habria que sumar el " ?rpd "% de beneficios por dividendos." crlf)
			else
				(printout t "Propuesta " ?i " - Cambiar la inversion en " ?n1 " a " ?n2 ". " ?n2 " debe tener una revalorizacion acorde con la evolucion de la bolsa. Por dividendos se espera un " ?rpd "% que es mas de lo que te esta dando " ?n1 ", por eso te propongo cambiar los valores por los de esta otra. Aunque se pague el 1% del coste del cambio te saldria rentable." crlf)
			)
		)
	)
)

(defrule respuesta-usuario
	(declare (salience -9000))
	?op <- (opcion ?opc)
	=>
	(printout t "Desea aceptar alguna sugerencia? (si/no)" crlf)
	(bind ?opc (read))
	(if (eq ?opc si) then
		(printout t "Elija la accion a realizar (1-5)" crlf)
		(bind ?opc (read))
		(assert (prop ?opc))
		(retract ?op)
	else
		(retract *)
	)
)

(defrule realizar-propuesta
	(declare (salience -9900))
	?prop <- (prop ?opc)
	?f <- (final (accion ?a) (nombre1 ?n1) (nombre2 ?n2) (re ?re) (rpd ?rpd) (cont ?opc))
	?cartera <- (cartera (nombre ?n1) (acciones ?acn1) (valorActual ?va1))
	(empresa (nombre ?n1) (precio ?p))
	(empresa (nombre ?n2) (precio ?p2))
	?disp <- (cartera (nombre DISPONIBLE) (acciones ?ac) (valorActual ?va))
	?total <- (totalCartera ?t)
	=>
	(if (eq ?a vender-pel) then
		(bind ?ac (+ ?ac ?va1))
		(bind ?va ?ac) 
		(assert (cartera (nombre DISPONIBLE) (acciones ?ac) (valorActual ?va)))
		(printout t "Se han vendido las acciones de " ?n1 "." crlf)
		(retract ?cartera)
		(retract ?f)
		(retract ?disp)
		(retract ?prop)
		(bind ?t (- ?t 1))
		(assert (totalCartera ?t))
		(retract ?total)

		else 
		(if (eq ?a vender-sob) then
			(bind ?ac (+ ?ac ?va1))
			(bind ?va ?ac)
			(assert (cartera (nombre DISPONIBLE) (acciones ?ac) (valorActual ?va))) 
			(printout t "Se han vendido las acciones de " ?n1 "." crlf)
			(retract ?cartera)
			(retract ?f)
			(retract ?disp)
			(retract ?prop)
			(bind ?t (- ?t 1))
			(assert (totalCartera ?t))
			(retract ?total)
		
			else
			(if (eq ?a invertir) then
				(printout t "Cuantas acciones desea comprar?" crlf)
				(bind ?opc (read))
				(assert (cartera (nombre ?n1) (acciones ?opc) (valorActual (* ?opc ?p))))
				(bind ?ac (- ?ac (* ?opc ?p)))
				(bind ?va ?ac)
				(assert (cartera (nombre DISPONIBLE) (acciones ?ac) (valorActual ?va)))
				(printout t "Se ha invertido en " ?n1 "." crlf)
				(retract ?f)
				(retract ?disp)
				(retract ?prop)
				(bind ?t (+ ?t 1))
				(assert (totalCartera ?t))
				(retract ?total)

				else
				(if (eq ?a cambiar) then
					(assert (cartera (nombre ?n2) (acciones ?acn1) (valorActual (* ?acn1 ?p2))))
					(bind ?ac (+ ?ac  ?va1))
					(bind ?ac (- ?ac (* ?acn1 ?p2)))
					(bind ?va ?ac)
					(assert (cartera (nombre DISPONIBLE) (acciones ?ac) (valorActual ?va))) 
					(printout t "Se han cambiado las acciones de " ?n1 " a " ?n2 "." crlf)
					(retract ?cartera)
					(retract ?f)
					(retract ?disp)
					(retract ?prop)
				)
			)
		)
	)

	(printout t "Desea aceptar alguna otra sugerencia? (si/no)" crlf)
	(bind ?opc (read))
	(if (eq ?opc si) then
		(printout t "Elija la accion a realizar (1-5)" crlf)
		(bind ?opc (read))
		(assert (prop ?opc))
		
		else
			(assert (contador1 1))
			(retract ?prop)

	)
)

(defrule mostrarCarteraActual
	(declare (salience -10000))
	?c <- (contador1 ?i)
	?cont <- (contador ?j)
	(cartera (nombre ?n) (acciones ?a) (valorActual ?va))
	(totalCartera ?total)
	=>
	(if (and (eq ?i 1) (eq ?n DISPONIBLE)) then
		(printout t "Cartera actual: " crlf)
		(printout t ?n "    " ?a "    " ?va crlf)
	)

	(if(eq ?i ?total) then
			(assert(modulo 4))
			(retract ?c)
			(retract ?cont)
			(assert (contador 0))
	)

	(if (< ?i ?total) then
		(bind ?i (+ ?i 1))
		(assert (contador1 ?i))
		(retract ?c)
	)
	
	(if (neq ?n DISPONIBLE) then
		(printout t ?n "    " ?a "    " ?va crlf)
	)
)