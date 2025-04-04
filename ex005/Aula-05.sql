/*Questão 1.Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram. Não se esqueça de mostrar o número de seções
como 0 para os instrutores que não ministraram qualquer seção. Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.*/

SELECT i.ID, i.name, COUNT(t.course_id) AS num_secoes
FROM  instructor i LEFT OUTER JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name;

/*Questão 2.Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join.*/

SELECT i.ID,i.name,
(SELECT COUNT(*) FROM teaches t WHERE t.ID = i.ID) AS num_secoes 
FROM instructor i;

/*Questão 3.Gere a lista de todas as seções de curso oferecidas na primavera de 2010, junto com o nome dos instrutores ministrando a seção.Se uma seção tiver mais de 1 instrutor,
ela deverá aparecer uma vez no resultado para cada instrutor. Se não tiver instrutor algum, ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”.*/

SELECT sub1.sec_id, ISNULL(sub2.name,'-') AS name FROM 
(SELECT * FROM section s WHERE s.semester = 'spring' AND s.[year] = 2010) AS sub1
LEFT JOIN
(SELECT i.ID,i.name,t.sec_id FROM instructor i LEFT OUTER JOIN teaches t ON i.ID = t.ID) AS sub2 ON sub2.sec_id = sub1.sec_id

/*Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), que oferece uma conversão de conceitos (letras) na relação takes para notas numéricas;
 por exemplo, uma nota “A+” poderia ser especificada para corresponder a 4 pontos, um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 

Os Pontos totais obtidos por um aluno para uma oferta de curso (section) são definidos como o número de créditos para o curso multiplicado pelos pontos numéricos para a nota
que o aluno recebeu.

Dada essa relação e o nosso esquema university, escreva: 

Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele.*/

SELECT 
    s.ID,
    s.name,
    co.title,
    co.dept_name,
    ta.grade,
    co.credits,
    CASE ta.grade
        WHEN 'A+' THEN 4.0
        WHEN 'A'  THEN 3.7
        WHEN 'A-' THEN 3.5
        WHEN 'B+' THEN 3.3
        WHEN 'B'  THEN 3.0
        WHEN 'B-' THEN 2.7
        WHEN 'C+' THEN 2.3
        WHEN 'C'  THEN 2.0
        WHEN 'C-' THEN 1.7
        ELSE 0
    END AS points,
    CASE ta.grade
        WHEN 'A+' THEN 4.0
        WHEN 'A'  THEN 3.7
        WHEN 'A-' THEN 3.5
        WHEN 'B+' THEN 3.3
        WHEN 'B'  THEN 3.0
        WHEN 'B-' THEN 2.7
        WHEN 'C+' THEN 2.3
        WHEN 'C'  THEN 2.0
        WHEN 'C-' THEN 1.7
        ELSE 0
    END * co.credits AS Pontos_Totais
FROM student s
JOIN department d ON s.dept_name = d.dept_name
JOIN takes ta ON s.ID = ta.ID
JOIN course co ON ta.course_id = co.course_id
LEFT JOIN section se ON co.course_id = se.course_id

--Questão 5. Crie uma view a partir do resultado da Questão 4 com o nome “coeficiente_rendimento”.

CREATE view coeficiente_rendimento AS
SELECT 
    s.ID,
    s.name,
    co.title,
    co.dept_name,
    ta.grade,
    co.credits,
    CASE ta.grade
        WHEN 'A+' THEN 4.0
        WHEN 'A'  THEN 3.7
        WHEN 'A-' THEN 3.5
        WHEN 'B+' THEN 3.3
        WHEN 'B'  THEN 3.0
        WHEN 'B-' THEN 2.7
        WHEN 'C+' THEN 2.3
        WHEN 'C'  THEN 2.0
        WHEN 'C-' THEN 1.7
        ELSE 0
    END AS points,
    CASE ta.grade
        WHEN 'A+' THEN 4.0
        WHEN 'A'  THEN 3.7
        WHEN 'A-' THEN 3.5
        WHEN 'B+' THEN 3.3
        WHEN 'B'  THEN 3.0
        WHEN 'B-' THEN 2.7
        WHEN 'C+' THEN 2.3
        WHEN 'C'  THEN 2.0
        WHEN 'C-' THEN 1.7
        ELSE 0
    END * co.credits AS Pontos_Totais
FROM student s
JOIN department d ON s.dept_name = d.dept_name
JOIN takes ta ON s.ID = ta.ID
JOIN course co ON ta.course_id = co.course_id
LEFT JOIN section se ON co.course_id = se.course_id
