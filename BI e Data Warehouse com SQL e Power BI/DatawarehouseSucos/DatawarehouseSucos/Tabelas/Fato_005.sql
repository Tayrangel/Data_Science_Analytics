CREATE TABLE [dbo].[Fato_005]
(
    [cod_produto] NVARCHAR(50) NOT NULL, 
    [cod_fabrica] NVARCHAR(50) NOT NULL, 
    [cod_dia] NVARCHAR(50) NOT NULL, 
    [meta_custo] FLOAT NULL, 
    PRIMARY KEY ([cod_produto], [cod_fabrica], [cod_dia]), 
    CONSTRAINT [FK_Fato_005_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [Dim_Produto]([cod_produto]),
    CONSTRAINT [FK_Fato_005_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [Dim_Fabrica]([cod_fabrica]),
    CONSTRAINT [FK_Fato_005_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [Dim_Tempo]([cod_dia])
)
