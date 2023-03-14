CREATE TABLE [dbo].[Dim_Marca]
(
	[cod_marca] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [desc_marca] NVARCHAR(200) NULL, 
    [cod_categoria] NVARCHAR(50) NULL, 
    CONSTRAINT [FK_Dim_Marca_Dim_Categoria] FOREIGN KEY ([cod_categoria]) REFERENCES [Dim_Categoria]([cod_categoria])
)
