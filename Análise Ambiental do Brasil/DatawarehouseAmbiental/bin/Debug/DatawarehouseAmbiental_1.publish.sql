/*
Script de implantação para DW_AMBIENTAL

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DW_AMBIENTAL"
:setvar DefaultFilePrefix "DW_AMBIENTAL"
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
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fCobertura_dimEstado]...';


GO
ALTER TABLE [dbo].[fCobertura] DROP CONSTRAINT [FK_fCobertura_dimEstado];


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[dimEstado]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_dimEstado] (
    [id_estado]   INT           NOT NULL,
    [desc_estado] NVARCHAR (50) NULL,
    [sigla]       NVARCHAR (50) NULL,
    [id_cidade]   INT           NULL,
    [desc_cidade] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id_estado] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[dimEstado])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_dimEstado] ([id_estado], [desc_estado], [id_cidade], [desc_cidade])
        SELECT   [id_estado],
                 [desc_estado],
                 [id_cidade],
                 [desc_cidade]
        FROM     [dbo].[dimEstado]
        ORDER BY [id_estado] ASC;
    END

DROP TABLE [dbo].[dimEstado];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_dimEstado]', N'dimEstado';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fCobertura_dimEstado]...';


GO
ALTER TABLE [dbo].[fCobertura] WITH NOCHECK
    ADD CONSTRAINT [FK_fCobertura_dimEstado] FOREIGN KEY ([id_estado]) REFERENCES [dbo].[dimEstado] ([id_estado]);


GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[fCobertura] WITH CHECK CHECK CONSTRAINT [FK_fCobertura_dimEstado];


GO
PRINT N'Atualização concluída.';


GO
