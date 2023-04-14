CREATE TABLE [dbo].[Dim_Produto]
(
	[cod_produto] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [desc_produto] NVARCHAR(200) NULL, 
    [atr_tamanho] NVARCHAR(200) NULL, 
    [atr_sabor] NVARCHAR(200) NULL, 
    [cod_marca] NVARCHAR(50) NULL, 
    CONSTRAINT [FK_Dim_Produto_Dim_Marca] FOREIGN KEY ([cod_marca]) REFERENCES [Dim_Marca]([cod_marca])
)
