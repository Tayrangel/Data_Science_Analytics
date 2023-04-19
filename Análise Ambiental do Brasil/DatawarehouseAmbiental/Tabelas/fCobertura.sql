CREATE TABLE [dbo].[fCobertura]
(
	[id_estado] INT NOT NULL , 
    [id_cidade] INT NOT NULL, 
    [id_classe] INT NOT NULL, 
    [id_bioma] INT NOT NULL, 
    [id_dia] NVARCHAR(50) NOT NULL, 
    [area] FLOAT NULL, 
    PRIMARY KEY ([id_estado], [id_cidade], [id_classe], [id_bioma], [id_dia]), 
    CONSTRAINT [FK_fCobertura_dimEstado] FOREIGN KEY ([id_estado]) REFERENCES [dimEstado]([id_estado]), 
    CONSTRAINT [FK_fCobertura_dimClasse] FOREIGN KEY ([id_classe]) REFERENCES [dimClasse]([id_classe]), 
    CONSTRAINT [FK_fCobertura_DimBioma] FOREIGN KEY ([id_bioma]) REFERENCES [dimBioma]([id_bioma]), 
    CONSTRAINT [FK_fCobertura_dimTempo] FOREIGN KEY ([id_dia]) REFERENCES [dimTempo]([id_dia]) 
)
