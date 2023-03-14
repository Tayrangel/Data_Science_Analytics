CREATE TABLE [dbo].[Dim_Tempo]
(
	[cod_dia] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [data] DATE NULL, 
    [cod_semana] INT NULL, 
    [nome_dia_semana] NVARCHAR(50) NULL, 
    [cod_mes] INT NULL, 
    [nome_mes] NVARCHAR(50) NULL, 
    [cod_mes_ano] NVARCHAR(50) NULL, 
    [nome_mes_ano] NVARCHAR(50) NULL, 
    [cod_trimestre] INT NULL, 
    [nome_trimeste] NVARCHAR(50) NULL, 
    [cod_trimestre_ano] NVARCHAR(50) NULL, 
    [nome_trimestre_ano] NVARCHAR(50) NULL, 
    [cod_semestre] INT NULL, 
    [nome_semestre] NVARCHAR(50) NULL, 
    [cod_semestre_ano] NVARCHAR(50) NULL, 
    [nome_semestre_ano] NVARCHAR(50) NULL, 
    [ano] NVARCHAR(50) NULL, 
    [tipo_dia] NVARCHAR(50) NULL
)
