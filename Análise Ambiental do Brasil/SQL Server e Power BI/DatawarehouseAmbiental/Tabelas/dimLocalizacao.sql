CREATE TABLE [dbo].[dimLocalizacao]
(
	[id_cidade] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [desc_cidade] NVARCHAR(50) NULL,
    [id_estado] NVARCHAR(50) NULL, 
    [desc_estado] NVARCHAR(50) NULL, 
    [sigla] NVARCHAR(50) NULL 
)
