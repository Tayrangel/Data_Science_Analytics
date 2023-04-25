CREATE TABLE [dbo].[dimTempo]
(
	[id_dia] NVARCHAR(50) NOT NULL , 
    [data] DATE NULL, 
    [id_semana] INT NULL, 
    [desc_dia_semana] NVARCHAR(50) NULL, 
    [id_mes] INT NULL, 
    [desc_mes] NVARCHAR(50) NULL, 
    [id_mes_ano] NVARCHAR(50) NULL, 
    [desc_mes_ano] NVARCHAR(50) NULL, 
    [id_trimestre] INT NULL, 
    [desc_trimestre] NVARCHAR(50) NULL, 
    [id_trimestre_ano] NVARCHAR(50) NULL, 
    [desc_trimestre_ano] NVARCHAR(50) NULL, 
    [id_semestre] INT NULL, 
    [desc_semestre] NVARCHAR(50) NULL, 
    [id_semestre_ano] NVARCHAR(50) NULL, 
    [desc_semestre_ano] NVARCHAR(50) NULL, 
    [ano] NVARCHAR(50) NOT NULL, 
    [tipo_dia] NVARCHAR(50) NULL, 
    PRIMARY KEY ([id_dia])
)
