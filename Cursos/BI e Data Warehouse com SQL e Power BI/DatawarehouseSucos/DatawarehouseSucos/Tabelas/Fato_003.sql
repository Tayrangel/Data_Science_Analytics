CREATE TABLE [dbo].[Fato_003]
(
    [cod_fabrica] NVARCHAR(50) NOT NULL, 
    [cod_dia] NVARCHAR(50) NOT NULL, 
    [custo_fixo] FLOAT NULL, 
    PRIMARY KEY ([cod_fabrica], [cod_dia]),
    CONSTRAINT [FK_Fato_003_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [Dim_Fabrica]([cod_fabrica]),
    CONSTRAINT [FK_Fato_003_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [Dim_Tempo]([cod_dia])
)
