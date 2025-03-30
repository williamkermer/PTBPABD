--Questão 01. Crie uma relação a partir da união das tabelas student e takes.
SELECT * FROM student s JOIN takes t ON s.ID = t.ID


--Questão 2. Contar a quantidade de cursos realizados pelos alunos do departamento de Civil Eng. - Ordenar de maneira descendente a quantidade de cursos associada aos alunos.
SELECT s.ID, s.name,  COUNT(t.course_id) AS Quantidade_de_Cursos
FROM student s JOIN takes t ON s.ID = t.ID WHERE s.dept_name = 'Civil Eng.'
GROUP BY s.ID, s.name
ORDER BY Quantidade_de_Cursos DESC;

--Questão 3. Criar uma view chamada 'civil_eng_students' a partir da relação construída na Questão 2.

CREATE view civil_eng_students as
SELECT s.ID, s.name,  COUNT(t.course_id) AS Quantidade_de_Cursos
FROM student s JOIN takes t ON s.ID = t.ID WHERE s.dept_name = 'Civil Eng.'
GROUP BY s.ID, s.name