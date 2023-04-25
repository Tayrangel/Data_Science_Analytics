CREATE TABLE [dbo].[fCobertura]
(
    [id_cidade] NVARCHAR(50) NOT NULL, 
    [id_classe] INT NOT NULL, 
    [id_bioma] NVARCHAR(50) NOT NULL, 
    [id_dia] NVARCHAR(50) NOT NULL, 
    [ano] NVARCHAR(50) NOT NULL,
    [area] FLOAT NULL, 
    PRIMARY KEY ([id_cidade], [id_dia], [id_classe], [id_bioma]), 
    CONSTRAINT [FK_fCobertura_dimLocalizacao] FOREIGN KEY ([id_cidade]) REFERENCES [dimLocalizacao]([id_cidade]), 
    CONSTRAINT [FK_fCobertura_dimClasse] FOREIGN KEY ([id_classe]) REFERENCES [dimClasse]([id_classe]), 
    CONSTRAINT [FK_fCobertura_DimBioma] FOREIGN KEY ([id_bioma]) REFERENCES [dimBioma]([id_bioma]), 
    CONSTRAINT [FK_fCobertura_dimTempo] FOREIGN KEY ([id_dia]) REFERENCES [dimTempo]([id_dia]) 
)
