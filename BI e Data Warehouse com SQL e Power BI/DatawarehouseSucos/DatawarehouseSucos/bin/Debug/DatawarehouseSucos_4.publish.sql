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
PRINT N'A operação de refatoração Renomear com chave b0d22ba5-c547-41cb-aa87-17a3ccbce8ad foi ignorada; o elemento [dbo].[Fato_001].[Id] (SqlSimpleColumn) não será renomeado para cod_cliente';


GO
PRINT N'Criando Tabela [dbo].[Fato_001]...';


GO
CREATE TABLE [dbo].[Fato_001] (
    [cod_cliente]        NVARCHAR (50) NOT NULL,
    [cod_produto]        NVARCHAR (50) NOT NULL,
    [cod_organizacional] NVARCHAR (50) NOT NULL,
    [cod_fabrica]        NVARCHAR (50) NOT NULL,
    [cod_dia]            NVARCHAR (50) NOT NULL,
    [faturamento]        FLOAT (53)    NULL,
    [imposto]            FLOAT (53)    NULL,
    [custo_variavel]     FLOAT (53)    NULL,
    [qtd_vendida]        FLOAT (53)    NULL,
    [un_vendida]         FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([cod_cliente] ASC, [cod_produto] ASC, [cod_organizacional] ASC, [cod_fabrica] ASC, [cod_dia] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Fato_002]...';


GO
CREATE TABLE [dbo].[Fato_002] (
    [cod_cliente] NVARCHAR (50) NOT NULL,
    [cod_produto] NVARCHAR (50) NOT NULL,
    [cod_fabrica] NVARCHAR (50) NOT NULL,
    [cod_dia]     NVARCHAR (50) NOT NULL,
    [frete]       FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([cod_cliente] ASC, [cod_produto] ASC, [cod_fabrica] ASC, [cod_dia] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Fato_003]...';


GO
CREATE TABLE [dbo].[Fato_003] (
    [cod_fabrica] NVARCHAR (50) NOT NULL,
    [cod_dia]     NVARCHAR (50) NOT NULL,
    [custo_fixo]  FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([cod_fabrica] ASC, [cod_dia] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Fato_004]...';


GO
CREATE TABLE [dbo].[Fato_004] (
    [cod_cliente]        NVARCHAR (50) NOT NULL,
    [cod_produto]        NVARCHAR (50) NOT NULL,
    [cod_organizacional] NVARCHAR (50) NOT NULL,
    [cod_dia]            NVARCHAR (50) NOT NULL,
    [meta_faturamento]   FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([cod_cliente] ASC, [cod_produto] ASC, [cod_organizacional] ASC, [cod_dia] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Fato_005]...';


GO
CREATE TABLE [dbo].[Fato_005] (
    [cod_produto] NVARCHAR (50) NOT NULL,
    [cod_fabrica] NVARCHAR (50) NOT NULL,
    [cod_dia]     NVARCHAR (50) NOT NULL,
    [meta_custo]  FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([cod_produto] ASC, [cod_fabrica] ASC, [cod_dia] ASC)
);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_001] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_001_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [dbo].[Dim_Cliente] ([cod_cliente]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_001] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_001_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Fato_001] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_001_Dim_Organizacional] FOREIGN KEY ([cod_organizacional]) REFERENCES [dbo].[Dim_Organizacional] ([cod_filho]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_001] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_001_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_001] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_001_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_002] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_002_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [dbo].[Dim_Cliente] ([cod_cliente]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_002] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_002_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_002] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_002_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_002] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_002_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_003_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_003] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_003_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_003_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_003] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_003_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_004] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_004_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [dbo].[Dim_Cliente] ([cod_cliente]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_004] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_004_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Fato_004] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_004_Dim_Organizacional] FOREIGN KEY ([cod_organizacional]) REFERENCES [dbo].[Dim_Organizacional] ([cod_filho]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_004] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_004_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_005_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_005] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_005_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_005_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_005] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_005_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_005_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_005] WITH NOCHECK
    ADD CONSTRAINT [FK_Fato_005_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b0d22ba5-c547-41cb-aa87-17a3ccbce8ad')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b0d22ba5-c547-41cb-aa87-17a3ccbce8ad')

GO

GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Fato_001] WITH CHECK CHECK CONSTRAINT [FK_Fato_001_Dim_Cliente];

ALTER TABLE [dbo].[Fato_001] WITH CHECK CHECK CONSTRAINT [FK_Fato_001_Dim_Produto];

ALTER TABLE [dbo].[Fato_001] WITH CHECK CHECK CONSTRAINT [FK_Fato_001_Dim_Organizacional];

ALTER TABLE [dbo].[Fato_001] WITH CHECK CHECK CONSTRAINT [FK_Fato_001_Dim_Fabrica];

ALTER TABLE [dbo].[Fato_001] WITH CHECK CHECK CONSTRAINT [FK_Fato_001_Dim_Tempo];

ALTER TABLE [dbo].[Fato_002] WITH CHECK CHECK CONSTRAINT [FK_Fato_002_Dim_Cliente];

ALTER TABLE [dbo].[Fato_002] WITH CHECK CHECK CONSTRAINT [FK_Fato_002_Dim_Produto];

ALTER TABLE [dbo].[Fato_002] WITH CHECK CHECK CONSTRAINT [FK_Fato_002_Dim_Fabrica];

ALTER TABLE [dbo].[Fato_002] WITH CHECK CHECK CONSTRAINT [FK_Fato_002_Dim_Tempo];

ALTER TABLE [dbo].[Fato_003] WITH CHECK CHECK CONSTRAINT [FK_Fato_003_Dim_Fabrica];

ALTER TABLE [dbo].[Fato_003] WITH CHECK CHECK CONSTRAINT [FK_Fato_003_Dim_Tempo];

ALTER TABLE [dbo].[Fato_004] WITH CHECK CHECK CONSTRAINT [FK_Fato_004_Dim_Cliente];

ALTER TABLE [dbo].[Fato_004] WITH CHECK CHECK CONSTRAINT [FK_Fato_004_Dim_Produto];

ALTER TABLE [dbo].[Fato_004] WITH CHECK CHECK CONSTRAINT [FK_Fato_004_Dim_Organizacional];

ALTER TABLE [dbo].[Fato_004] WITH CHECK CHECK CONSTRAINT [FK_Fato_004_Dim_Tempo];

ALTER TABLE [dbo].[Fato_005] WITH CHECK CHECK CONSTRAINT [FK_Fato_005_Dim_Produto];

ALTER TABLE [dbo].[Fato_005] WITH CHECK CHECK CONSTRAINT [FK_Fato_005_Dim_Fabrica];

ALTER TABLE [dbo].[Fato_005] WITH CHECK CHECK CONSTRAINT [FK_Fato_005_Dim_Tempo];


GO
PRINT N'Atualização concluída.';


GO
