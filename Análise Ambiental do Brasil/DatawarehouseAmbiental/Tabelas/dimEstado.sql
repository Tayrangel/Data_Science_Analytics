CREATE TABLE [dbo].[dimEstado]
(
	[id_estado] INT NOT NULL PRIMARY KEY, 
    [desc_estado] NVARCHAR(50) NULL, 
    [sigla] NVARCHAR(50) NULL,
    [id_cidade] INT NULL, 
    [desc_cidade] NVARCHAR(50) NULL
)
