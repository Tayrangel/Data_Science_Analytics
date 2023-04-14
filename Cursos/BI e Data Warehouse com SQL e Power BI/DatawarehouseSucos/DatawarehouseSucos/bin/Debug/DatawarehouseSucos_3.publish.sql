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
PRINT N'A operação de refatoração Renomear com chave bd8a652b-6383-49d1-993a-fea1ff7e45b1 foi ignorada; o elemento [dbo].[Dim_Tempo].[Id] (SqlSimpleColumn) não será renomeado para cod_dia';


GO
PRINT N'A operação de refatoração Renomear com chave f39d56b9-dbc0-4ad0-9882-c26239df7bd6 foi ignorada; o elemento [dbo].[Dim_Tempo].[mes_ano] (SqlSimpleColumn) não será renomeado para cod_mes_ano';


GO
PRINT N'A operação de refatoração Renomear com chave 00881bdd-942e-4b0d-93ad-be6000739857 foi ignorada; o elemento [dbo].[Dim_Tempo].[e_dia_semana] (SqlSimpleColumn) não será renomeado para tipo_dia';


GO
PRINT N'Criando Tabela [dbo].[Dim_Tempo]...';


GO
CREATE TABLE [dbo].[Dim_Tempo] (
    [cod_dia]            NVARCHAR (50) NOT NULL,
    [data]               DATE          NULL,
    [cod_semana]         INT           NULL,
    [nome_dia_semana]    NVARCHAR (50) NULL,
    [cod_mes]            INT           NULL,
    [nome_mes]           NVARCHAR (50) NULL,
    [cod_mes_ano]        NVARCHAR (50) NULL,
    [nome_mes_ano]       NVARCHAR (50) NULL,
    [cod_trimestre]      INT           NULL,
    [nome_trimeste]      NVARCHAR (50) NULL,
    [cod_trimestre_ano]  NVARCHAR (50) NULL,
    [nome_trimestre_ano] NVARCHAR (50) NULL,
    [cod_semestre]       INT           NULL,
    [nome_semestre]      NVARCHAR (50) NULL,
    [cod_semestre_ano]   NVARCHAR (50) NULL,
    [nome_semestre_ano]  NVARCHAR (50) NULL,
    [ano]                NVARCHAR (50) NULL,
    [tipo_dia]           NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([cod_dia] ASC)
);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bd8a652b-6383-49d1-993a-fea1ff7e45b1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bd8a652b-6383-49d1-993a-fea1ff7e45b1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f39d56b9-dbc0-4ad0-9882-c26239df7bd6')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f39d56b9-dbc0-4ad0-9882-c26239df7bd6')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '00881bdd-942e-4b0d-93ad-be6000739857')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('00881bdd-942e-4b0d-93ad-be6000739857')

GO

GO
PRINT N'Atualização concluída.';


GO
