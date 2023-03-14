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
PRINT N'A operação de refatoração Renomear com chave f9d47103-f45b-49c7-bd0e-f7f3524cbf0e foi ignorada; o elemento [dbo].[Dim_Organizacional].[Id] (SqlSimpleColumn) não será renomeado para cod_filho';


GO
PRINT N'Criando Tabela [dbo].[Dim_Organizacional]...';


GO
CREATE TABLE [dbo].[Dim_Organizacional] (
    [cod_filho]  NVARCHAR (50)  NOT NULL,
    [desc_filho] NVARCHAR (200) NULL,
    [cod_pai]    NVARCHAR (50)  NULL,
    [esquerda]   INT            NULL,
    [direita]    INT            NULL,
    [nivel]      INT            NULL,
    PRIMARY KEY CLUSTERED ([cod_filho] ASC)
);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Dim_Organizacional_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Dim_Organizacional] WITH NOCHECK
    ADD CONSTRAINT [FK_Dim_Organizacional_Dim_Organizacional] FOREIGN KEY ([cod_pai]) REFERENCES [dbo].[Dim_Organizacional] ([cod_filho]);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f9d47103-f45b-49c7-bd0e-f7f3524cbf0e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f9d47103-f45b-49c7-bd0e-f7f3524cbf0e')

GO

GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Dim_Organizacional] WITH CHECK CHECK CONSTRAINT [FK_Dim_Organizacional_Dim_Organizacional];


GO
PRINT N'Atualização concluída.';


GO
