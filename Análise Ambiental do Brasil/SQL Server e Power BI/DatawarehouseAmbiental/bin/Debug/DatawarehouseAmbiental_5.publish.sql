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
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fCobertura_dimClasse]...';


GO
ALTER TABLE [dbo].[fCobertura] DROP CONSTRAINT [FK_fCobertura_dimClasse];


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[dimClasse]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_dimClasse] (
    [id_classe]      INT           NOT NULL,
    [desc_classe_n0] NVARCHAR (50) NULL,
    [desc_classe_n1] NVARCHAR (50) NULL,
    [desc_classe_n2] NVARCHAR (50) NULL,
    [desc_classe_n3] NVARCHAR (50) NULL,
    [desc_classe_n4] NVARCHAR (50) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_dimClasse1] PRIMARY KEY CLUSTERED ([id_classe] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[dimClasse])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_dimClasse] ([id_classe], [desc_classe_n1], [desc_classe_n2], [desc_classe_n3], [desc_classe_n4])
        SELECT   [id_classe],
                 [desc_classe_n1],
                 [desc_classe_n2],
                 [desc_classe_n3],
                 [desc_classe_n4]
        FROM     [dbo].[dimClasse]
        ORDER BY [id_classe] ASC;
    END

DROP TABLE [dbo].[dimClasse];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_dimClasse]', N'dimClasse';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_dimClasse1]', N'PK_dimClasse', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fCobertura_dimClasse]...';


GO
ALTER TABLE [dbo].[fCobertura] WITH NOCHECK
    ADD CONSTRAINT [FK_fCobertura_dimClasse] FOREIGN KEY ([id_classe]) REFERENCES [dbo].[dimClasse] ([id_classe]);


GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[fCobertura] WITH CHECK CHECK CONSTRAINT [FK_fCobertura_dimClasse];


GO
PRINT N'Atualização concluída.';


GO
