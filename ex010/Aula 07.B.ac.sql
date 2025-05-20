--Questão 01. Crie um procedimento denominado salaryHistogram, que distribua as frequências dos salários dos Professores em intervalos (Histograma).
--O número de intervalos será calculado de acordo com o parâmetro de entrada do procedimento. Exemplo: EXEC dbo.salaryHistogram 5;
CREATE OR ALTER PROCEDURE salaryHistogram
    @num_intervals INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @minSalary DECIMAL(10,2),
            @maxSalary DECIMAL(10,2),
            @range DECIMAL(10,2),
            @i INT = 0,
            @lower DECIMAL(10,2),
            @upper DECIMAL(10,2);

    SELECT @minSalary = MIN(salary), @maxSalary = MAX(salary) FROM Instructor;

    SET @range = (@maxSalary - @minSalary) / @num_intervals;

    CREATE TABLE #Histogram (
        SalaryRange VARCHAR(50),
        Frequency INT
    );

    WHILE @i < @num_intervals
    BEGIN
        SET @lower = @minSalary + (@i * @range);
        SET @upper = @lower + @range;

        INSERT INTO #Histogram (SalaryRange, Frequency)
        SELECT 
            CONCAT(FORMAT(@lower, 'N2'), ' - ', FORMAT(@upper, 'N2')),
            COUNT(*) 
        FROM Instructor
        WHERE salary >= @lower AND salary < @upper;

        SET @i += 1;
    END;

    SELECT * FROM #Histogram;

    DROP TABLE #Histogram;
END;