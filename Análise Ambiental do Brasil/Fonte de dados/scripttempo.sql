/********************************************************************************************/
--Specify Start Date and End date here
--Value of Start Date Must be Less than Your End Date 

DECLARE @DIMDATE TABLE
	(	[id_dia] NVARCHAR(50) primary key, 
		[data] DATE,
		[id_semana] int,-- 01,02,03 .... 42,43,44
		[desc_dia_semana] NVARCHAR(50),-- Segunda, terça, quarta, quinta, sexta
		[id_mes] int,-- 01,02,03 ... , 11, 12
		[desc_mes] NVARCHAR(50),-- Janeiro, Fevereiro, Março, ... Novembro, Dezembro
		[id_mes_ano] NVARCHAR(50),-- 2017-01, 2017-02, ..., 2017-11, 2017-12
		[desc_mes_ano] NVARCHAR(50),-- Janeiro 2017, Fevereiro 2017, ....
		[id_trimestre] int,-- 01, 02, 03, 04
		[desc_trimestre] NVARCHAR(50),-- Primeiro Trimestre, Segundo Trimestre, ...
		[id_trimestre_ano] NVARCHAR(50),-- 2017-01, 2017-02, ...
		[desc_trimestre_ano] NVARCHAR(50),-- Primeiro Trimestre 2017, Segundo Trimestre 2017, ...
		[id_semestre] int,-- 01, 02, ...
		[desc_semestre] NVARCHAR(50),-- Primeiro Semestre, Segundo Semestre, ...
		[id_semestre_ano] NVARCHAR(50),-- 2017-01, 2017-02, ...
		[desc_semestre_ano] NVARCHAR(50),-- Primeiro Semestre, Segundo Semestre, ...
		[ano] NVARCHAR(50),-- 2017, ...
		[tipo_dia] NVARCHAR(50) -- Dia Útil ou Fim de Semana
	)

DECLARE @AnoInicial VARCHAR(4) = ?
DECLARE @MesInicial VARCHAR(2) = ?
DECLARE @AnoFinal VARCHAR(4) = ?
DECLARE @MesFinal VARCHAR(2) = ?

DECLARE @StartDate DATETIME
Select @StartDate = CAST(@AnoInicial + '/' + @MesInicial + '/01' AS DATETIME)

DECLARE @EndDate DATETIME 
SELECT @EndDate = DATEADD(month, ((CAST(@AnoFinal AS INTEGER) - 1900) * 12) + CAST(@MesFinal AS INTEGER), 0)

--Temporary Variables To Hold the Values During Processing of Each Date of Year
DECLARE
	@DayOfWeekInMonth INT,
	@DayOfWeekInYear INT,
	@DayOfQuarter INT,
	@WeekOfMonth INT,
	@CurrentYear INT,
	@CurrentMonth INT,
	@CurrentQuarter INT

/*Table Data type to store the day of week count for the month and year*/
DECLARE @DayOfWeek TABLE (DOW INT, MonthCount INT, QuarterCount INT, YearCount INT)

INSERT INTO @DayOfWeek VALUES (1, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (2, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (3, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (4, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (5, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (6, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (7, 0, 0, 0)

--Extract and assign various parts of Values from Current Date to Variable

DECLARE @CurrentDate AS DATETIME = @StartDate
SET @CurrentMonth = DATEPART(MM, @CurrentDate)
SET @CurrentYear = DATEPART(YY, @CurrentDate)
SET @CurrentQuarter = DATEPART(QQ, @CurrentDate)

/********************************************************************************************/
--Proceed only if Start Date(Current date ) is less than End date you specified above

WHILE @CurrentDate < @EndDate
BEGIN
 
/*Begin day of week logic*/

         /*Check for Change in Month of the Current date if Month changed then 
          Change variable value*/
	IF @CurrentMonth != DATEPART(MM, @CurrentDate) 
	BEGIN
		UPDATE @DayOfWeek
		SET MonthCount = 0
		SET @CurrentMonth = DATEPART(MM, @CurrentDate)
	END

        /* Check for Change in Quarter of the Current date if Quarter changed then change 
         Variable value*/

	IF @CurrentQuarter != DATEPART(QQ, @CurrentDate)
	BEGIN
		UPDATE @DayOfWeek
		SET QuarterCount = 0
		SET @CurrentQuarter = DATEPART(QQ, @CurrentDate)
	END
       
        /* Check for Change in Year of the Current date if Year changed then change 
         Variable value*/
	

	IF @CurrentYear != DATEPART(YY, @CurrentDate)
	BEGIN
		UPDATE @DayOfWeek
		SET YearCount = 0
		SET @CurrentYear = DATEPART(YY, @CurrentDate)
	END
	
        -- Set values in table data type created above from variables 

	UPDATE @DayOfWeek
	SET 
		MonthCount = MonthCount + 1,
		QuarterCount = QuarterCount + 1,
		YearCount = YearCount + 1
	WHERE DOW = DATEPART(DW, @CurrentDate)

	SELECT
		@DayOfWeekInMonth = MonthCount,
		@DayOfQuarter = QuarterCount,
		@DayOfWeekInYear = YearCount
	FROM @DayOfWeek
	WHERE DOW = DATEPART(DW, @CurrentDate)
	
/*End day of week logic*/


/* Populate Your Dimension Table with values*/
	
	INSERT INTO @DIMDATE
	SELECT	
		CONVERT (NVARCHAR(8),@CurrentDate,112) as id_dia,
		@CurrentDate as data,
		RIGHT ('00'+LTRIM(STR(CONVERT(NVARCHAR(2), @DayOfWeekInYear))),2 ) as id_semana,
		CASE DATEPART(DW, @CurrentDate)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Segunda'
			WHEN 3 THEN 'Terça'
			WHEN 4 THEN 'Quarta'
			WHEN 5 THEN 'Quinta'
			WHEN 6 THEN 'Sexta'
			WHEN 7 THEN 'Sábado'
			END 
			AS D_desc_dia_semana,
        RIGHT ('00'+LTRIM(STR(CONVERT(NVARCHAR(2), DATEPART(MM, @CurrentDate)))),2 )  as id_mes,
		CASE DATEPART(MM, @CurrentDate)
			WHEN 1 THEN 'Janeiro'
			WHEN 2 THEN 'Fevereiro'
			WHEN 3 THEN 'Março'
			WHEN 4 THEN 'Abril'
			WHEN 5 THEN 'Maio'
			WHEN 6 THEN 'Junho'
			WHEN 7 THEN 'Julho'
			WHEN 8 THEN 'Agosto'
			WHEN 9 THEN 'Setembro'
			WHEN 10 THEN 'Outubro'
			WHEN 11 THEN 'Novembro'
			WHEN 12 THEN 'Dezembro'
			END 
			AS D_desc_mes,
			RIGHT ('00'+LTRIM(STR(CONVERT(NVARCHAR(2), DATEPART(MM, @CurrentDate)))),2 ) + '-' + CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) as id_mes_ano,
			CASE DATEPART(MM, @CurrentDate)
			WHEN 1 THEN 'Janeiro'
			WHEN 2 THEN 'Fevereiro'
			WHEN 3 THEN 'Março'
			WHEN 4 THEN 'Abril'
			WHEN 5 THEN 'Maio'
			WHEN 6 THEN 'Junho'
			WHEN 7 THEN 'Julho'
			WHEN 8 THEN 'Agosto'
			WHEN 9 THEN 'Setembro'
			WHEN 10 THEN 'Outubro'
			WHEN 11 THEN 'Novembro'
			WHEN 12 THEN 'Dezembro'
			END + ' ' + CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) as D_desc_mes_ano,
			RIGHT ('00'+LTRIM(STR(CONVERT(NVARCHAR(2), DATEPART(QQ, @CurrentDate)))),2 ) AS id_trimestre,
			CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN 'Primeiro Trimestre'
			WHEN 2 THEN 'Segundo Trimestre'
			WHEN 3 THEN 'Terceiro Trimestre'
			WHEN 4 THEN 'Quarto Trimestre'
			END AS D_desc_trimestre,
			RIGHT ('00'+LTRIM(STR(CONVERT(NVARCHAR(2), DATEPART(QQ, @CurrentDate)))),2 ) + '-' + 
			CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) as id_trimestre_ano,
			CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN 'Primeiro Trimestre'
			WHEN 2 THEN 'Segundo Trimestre'
			WHEN 3 THEN 'Terceiro Trimestre'
			WHEN 4 THEN 'Quarto Trimestre'
			END + ' ' + CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) AS D_desc_trimestre_ano,
			CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN '01'
			WHEN 2 THEN '01'
			WHEN 3 THEN '02'
			WHEN 4 THEN '02'
			END 
			AS id_semestre,
			CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN 'Primeiro Semestre'
			WHEN 2 THEN 'Primeiro Semestre'
			WHEN 3 THEN 'Segundo Semestre'
			WHEN 4 THEN 'Segundo Semestre'
			END 
			AS D_desc_semestre,
			CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN '01'
			WHEN 2 THEN '01'
			WHEN 3 THEN '02'
			WHEN 4 THEN '02'
			END + '-' + 
			CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) as id_semestre_ano,
			CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN 'Primeiro Semestre'
			WHEN 2 THEN 'Primeiro Semestre'
			WHEN 3 THEN 'Segundo Semestre'
			WHEN 4 THEN 'Segundo Semestre'
			END + ' ' + 
			CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) as D_desc_semestre_ano,
			CONVERT(NVARCHAR(4), DATEPART(YEAR, @CurrentDate)) AS ano,
			CASE DATEPART(DW, @CurrentDate)
			WHEN 1 THEN 'Fim de Semana'
			WHEN 2 THEN 'Dia Útil'
			WHEN 3 THEN 'Dia Útil'
			WHEN 4 THEN 'Dia Útil'
			WHEN 5 THEN 'Dia Útil'
			WHEN 6 THEN 'Dia Útil'
			WHEN 7 THEN 'Fim de Semana'
			END 
			AS tipo_dia

	SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END

SELECT * FROM @DIMDATE order by id_dia