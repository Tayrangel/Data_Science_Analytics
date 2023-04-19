CREATE TABLE [dbo].[dimClasse]
(
    [id_classe] INT NOT NULL, 
    [desc_classe_n1] NVARCHAR(50) NULL, 
    [desc_classe_n2] NVARCHAR(50) NULL, 
    [desc_classe_n3] NVARCHAR(50) NULL, 
    [desc_classe_n4] NVARCHAR(50) NULL, 
    CONSTRAINT [PK_dimClasse] PRIMARY KEY ([id_classe])
)
