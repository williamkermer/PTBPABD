-- Questão 01. Crie um procedimento chamado student_grade_points segundo os critérios abaixo:
-- 
-- a. Utilize como parâmetro de entrada o conceito. Exemplo: A+, A-, ...
-- 
-- b. Retorne os atributos das tuplas: Nome do estudante, Departamento do estudante,
--    Título do curso, Departamento do curso, Semestre do curso, Ano do curso,
--    Pontuação alfanumérica, Pontuação numérica.
--
-- c. Filtre as tuplas utilizando o parâmetro de entrada.

CREATE PROCEDURE student_grade_points
    @grade_letter VARCHAR(2)
AS
BEGIN
    SELECT 
        e.Nome AS NomeEstudante,
        de1.Nome AS DepartamentoEstudante,
        c.Titulo AS TituloCurso,
        de2.Nome AS DepartamentoCurso,
        m.Semestre,
        m.Ano,
        n.Conceito AS PontuacaoAlfanumerica,
        CASE 
            WHEN n.Conceito = 'A+' THEN 4.3
            WHEN n.Conceito = 'A'  THEN 4.0
            WHEN n.Conceito = 'A-' THEN 3.7
            WHEN n.Conceito = 'B+' THEN 3.3
            WHEN n.Conceito = 'B'  THEN 3.0
            WHEN n.Conceito = 'B-' THEN 2.7
            WHEN n.Conceito = 'C+' THEN 2.3
            WHEN n.Conceito = 'C'  THEN 2.0
            WHEN n.Conceito = 'C-' THEN 1.7
            WHEN n.Conceito = 'D'  THEN 1.0
            WHEN n.Conceito = 'F'  THEN 0.0
            ELSE NULL
        END AS PontuacaoNumerica
    FROM Matricula m
    JOIN Estudante e ON m.IdEstudante = e.IdEstudante
    JOIN Departamento de1 ON e.IdDepartamento = de1.IdDepartamento
    JOIN Curso c ON m.IdCurso = c.IdCurso
    JOIN Departamento de2 ON c.IdDepartamento = de2.IdDepartamento
    JOIN Notas n ON m.IdMatricula = n.IdMatricula
    WHERE n.Conceito = @grade_letter
END;

-- Questão 02.
--
-- Crie uma função chamada return_instructor_location segundo os critérios abaixo:
--
-- a. Utilize como parâmetro de entrada o nome do instrutor.
--
-- b. Retorne os atributos das tuplas: Nome do instrutor, Curso ministrado, 
--    Semestre do curso, Ano do curso, prédio e número da sala na qual o curso foi ministrado.
--
-- c. Exemplo: SELECT * FROM dbo.return_instructor_location('Gustafsson');

CREATE FUNCTION dbo.return_instructor_location (
    @instructor_name VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.name AS instructor_name,
        c.title AS course_title,
        s.semester,
        s.year,
        cl.building,
        cl.room_number
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
    JOIN course c ON c.course_id = s.course_id
    JOIN classroom cl ON s.building = cl.building AND s.room_number = cl.room_number
    WHERE i.name = @instructor_name
);
