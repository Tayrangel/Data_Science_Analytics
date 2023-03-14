CREATE TABLE [dbo].[Dim_Cliente]
(
	[cod_cliente] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [desc_cliente] NVARCHAR(200) NULL, 
    [cod_cidade] NVARCHAR(50) NULL, 
    [desc_cidade] NVARCHAR(200) NULL,
    [cod_estado] NVARCHAR(50) NULL, 
    [desc_estado] NVARCHAR(200) NULL,
    [cod_regiao] NVARCHAR(50) NULL, 
    [desc_regiao] NVARCHAR(200) NULL,
    [cod_segmento] NVARCHAR(50) NULL, 
    [desc_segmento] NVARCHAR(200) NULL
)
