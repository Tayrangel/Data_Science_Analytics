CREATE TABLE [dbo].[Fato_002]
(
	[cod_cliente] NVARCHAR(50) NOT NULL , 
    [cod_produto] NVARCHAR(50) NOT NULL, 
    [cod_fabrica] NVARCHAR(50) NOT NULL, 
    [cod_dia] NVARCHAR(50) NOT NULL, 
    [frete] FLOAT NULL, 
    PRIMARY KEY ([cod_cliente], [cod_produto], [cod_fabrica], [cod_dia]), 
    CONSTRAINT [FK_Fato_002_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [Dim_CLiente]([cod_cliente]),
    CONSTRAINT [FK_Fato_002_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [Dim_Produto]([cod_produto]),
    CONSTRAINT [FK_Fato_002_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [Dim_Fabrica]([cod_fabrica]),
    CONSTRAINT [FK_Fato_002_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [Dim_Tempo]([cod_dia])
)
