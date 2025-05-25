--Questão 01. Ao realizar um curso o aluno ganha créditos. Ao eliminar um curso da lista do aluno, os seus créditos totais deverão ser reduzidos.
--Construa uma Trigger chamada dbo.lost_credits que atualiza o valor de créditos de um aluno após a retirada de um curso da sua lista.

CREATE OR ALTER TRIGGER dbo.lost_credits
ON takes
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE student
    SET tot_cred = tot_cred - c.credits
    FROM student s
    INNER JOIN deleted d ON s.ID = d.ID
    INNER JOIN course c ON d.course_id = c.course_id;
END;
