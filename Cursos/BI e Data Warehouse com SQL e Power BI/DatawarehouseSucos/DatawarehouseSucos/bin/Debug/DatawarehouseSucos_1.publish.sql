/*
Script de implantação para DW_SUCOS

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DW_SUCOS"
:setvar DefaultFilePrefix "DW_SUCOS"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detecta o modo SQLCMD e desabilita a execução do script se o modo SQLCMD não tiver suporte.
Para reabilitar o script após habilitar o modo SQLCMD, execute o comando a seguir:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'O modo SQLCMD deve ser habilitado para executar esse script com êxito.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'A operação de refatoração Renomear com chave 6b2e5d4e-261a-4688-aa6c-52b8761ceaa6 foi ignorada; o elemento [dbo].[Dim_Cliente].[Id] (SqlSimpleColumn) não será renomeado para cod_cliente';


GO
PRINT N'A operação de refatoração Renomear com chave c0753fae-c804-40de-bf0f-c395e6779b01 foi ignorada; o elemento [dbo].[Dim_Categoria].[Id] (SqlSimpleColumn) não será renomeado para cod_categoria';


GO
PRINT N'A operação de refatoração Renomear com chave 5dcbbc61-bbbf-46d3-a3c9-9c2fee5e48d4 foi ignorada; o elemento [dbo].[Dim_Marca].[Id] (SqlSimpleColumn) não será renomeado para cod_marca';


GO
PRINT N'A operação de refatoração Renomear com chave 4af4e02e-0ad0-4027-967b-612948db49c0 foi ignorada; o elemento [dbo].[Dim_Produto].[Id] (SqlSimpleColumn) não será renomeado para cod_produto';


GO
PRINT N'Criando Tabela [dbo].[Dim_Categoria]...';


GO
CREATE TABLE [dbo].[Dim_Categoria] (
    [cod_categoria]  NVARCHAR (50)  NOT NULL,
    [desc_categoria] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([cod_categoria] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Dim_Cliente]...';


GO
CREATE TABLE [dbo].[Dim_Cliente] (
    [cod_cliente]   NVARCHAR (50)  NOT NULL,
    [desc_cliente]  NVARCHAR (200) NULL,
    [cod_cidade]    NVARCHAR (50)  NULL,
    [desc_cidade]   NVARCHAR (200) NULL,
    [cod_estado]    NVARCHAR (50)  NULL,
    [desc_estado]   NVARCHAR (200) NULL,
    [cod_regiao]    NVARCHAR (50)  NULL,
    [desc_regiao]   NVARCHAR (200) NULL,
    [cod_segmento]  NVARCHAR (50)  NULL,
    [desc_segmento] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([cod_cliente] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Dim_Marca]...';


GO
CREATE TABLE [dbo].[Dim_Marca] (
    [cod_marca]     NVARCHAR (50)  NOT NULL,
    [desc_marca]    NVARCHAR (200) NULL,
    [cod_categoria] NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([cod_marca] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Dim_Produto]...';


GO
CREATE TABLE [dbo].[Dim_Produto] (
    [cod_produto]  NVARCHAR (50)  NOT NULL,
    [desc_produto] NVARCHAR (200) NULL,
    [atr_tamanho]  NVARCHAR (200) NULL,
    [atr_sabor]    NVARCHAR (200) NULL,
    [cod_marca]    NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([cod_produto] ASC)
);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Dim_Marca_Dim_Categoria]...';


GO
ALTER TABLE [dbo].[Dim_Marca] WITH NOCHECK
    ADD CONSTRAINT [FK_Dim_Marca_Dim_Categoria] FOREIGN KEY ([cod_categoria]) REFERENCES [dbo].[Dim_Categoria] ([cod_categoria]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Dim_Produto_Dim_Marca]...';


GO
ALTER TABLE [dbo].[Dim_Produto] WITH NOCHECK
    ADD CONSTRAINT [FK_Dim_Produto_Dim_Marca] FOREIGN KEY ([cod_marca]) REFERENCES [dbo].[Dim_Marca] ([cod_marca]);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6b2e5d4e-261a-4688-aa6c-52b8761ceaa6')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6b2e5d4e-261a-4688-aa6c-52b8761ceaa6')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c0753fae-c804-40de-bf0f-c395e6779b01')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c0753fae-c804-40de-bf0f-c395e6779b01')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5dcbbc61-bbbf-46d3-a3c9-9c2fee5e48d4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5dcbbc61-bbbf-46d3-a3c9-9c2fee5e48d4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4af4e02e-0ad0-4027-967b-612948db49c0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4af4e02e-0ad0-4027-967b-612948db49c0')

GO

GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Dim_Marca] WITH CHECK CHECK CONSTRAINT [FK_Dim_Marca_Dim_Categoria];

ALTER TABLE [dbo].[Dim_Produto] WITH CHECK CHECK CONSTRAINT [FK_Dim_Produto_Dim_Marca];


GO
PRINT N'Atualização concluída.';


GO
