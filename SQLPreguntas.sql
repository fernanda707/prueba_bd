--1.-Conocer el numero de evaluaciones por curso
select c.nombre, count(ev.id_evaluacion) from curso c
inner join Estudiante e on e.curso_id_curso=c.id_curso
inner join evaluacion ev on ev.estudiante_id_estudiante=e.id_estudiante
group by c.nombre;

--2.-Conocer los cursos sin evaluaciones
select c.nombre, count(ev.id_evaluacion) from curso c
full join Estudiante e on e.curso_id_curso=c.id_curso
full join evaluacion ev on ev.estudiante_id_estudiante=e.id_estudiante
HAVING count(ev.id_evaluacion)=0
group by c.nombre;

--3.-Evaluacion con deficiencias:
--no tienen preguntas
select t.nombre "Pruebas sin preguntas" from test t
full join pregunta p on p.test_id_test=t.id_test
having count(p.id_pregunta)=0
group by t.nombre ;

--Si hay preguntas con 2 o menos alternativas
select t.id_test, t.nombre from test t
inner join pregunta p on p.test_id_test=t.id_test
left join alternativa a on a.pregunta_id_pregunta=p.id_pregunta
where a.id_alternativa is NULL
group by t.id_test, t.nombre;

--Si todas las aternativas son correctas o si todas las alternativas son incorrectas
select  t.nombre from test t
inner join pregunta p on p.test_id_test=t.id_test
inner join alternativa a on a.pregunta_id_pregunta=p.id_pregunta
having count(a.id_alternativa)=sum(a.alternativa_correcta) or sum(a.alternativa_correcta)=0
group by t.nombre, p.id_pregunta order by p.id_pregunta asc

--NOTA: para realizar la consulta, conte cuantas alternativas tenia cada pregunta 
--y cuantas alternativas correctas tenia esa misma pregunta 
--(ya que tiene un char que si es "1" es correcta y "0" si no)
--de esta forma contraste los dos datos de cada pregunta

--4.- Determinar cuantos alumnos hay en cada curso
select c.nombre "curso", count(e.id_estudiante) "n° Estudiantes" from curso c
inner join estudiante e on e.curso_id_curso=c.id_curso
group by c.nombre

--5.-Obtener el puntaje no normalizado de cada evaluación.  P = buenas – malas/4
/*select e.id_evaluacion, p.id_pregunta from evaluacion e
inner join respuesta r on r.evaluacion_id_evaluacion= e.id_evaluacion
inner join alternativa a on a.id_alternativa=r.alternativa_id_alternativa
inner join pregunta p on a.pregunta_id_pregunta= p.id_pregunta
where 
order by e.id_evaluacion, p.id_pregunta asc


select p.id_pregunta, a.id_alternativa, a.alternativa_correcta from pregunta p
inner join alternativa a on a.pregunta_id_pregunta=p.id_pregunta
where a.alternativa_correcta=1?*/

order by p.id_pregunta asc
