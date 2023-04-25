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
/*
A coluna [dbo].[fCobertura].[id_dia] na tabela [dbo].[fCobertura] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.
*/

IF EXISTS (select top 1 1 from [dbo].[fCobertura])
    RAISERROR (N'Linhas foram detectadas. A atualização de esquema está sendo encerrada porque pode ocorrer perda de dados.', 16, 127) WITH NOWAIT

GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fCobertura_dimLocalizacao]...';


GO
ALTER TABLE [dbo].[fCobertura] DROP CONSTRAINT [FK_fCobertura_dimLocalizacao];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fCobertura_dimClasse]...';


GO
ALTER TABLE [dbo].[fCobertura] DROP CONSTRAINT [FK_fCobertura_dimClasse];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fCobertura_DimBioma]...';


GO
ALTER TABLE [dbo].[fCobertura] DROP CONSTRAINT [FK_fCobertura_DimBioma];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fCobertura_dimTempo]...';


GO
ALTER TABLE [dbo].[fCobertura] DROP CONSTRAINT [FK_fCobertura_dimTempo];


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[fCobertura]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_fCobertura] (
    [id_cidade] NVARCHAR (50) NOT NULL,
    [id_classe] INT           NOT NULL,
    [id_bioma]  NVARCHAR (50) NOT NULL,
    [id_dia]    NVARCHAR (50) NOT NULL,
    [ano]       NVARCHAR (50) NOT NULL,
    [area]      FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([id_cidade] ASC, [id_dia] ASC, [id_classe] ASC, [id_bioma] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[fCobertura])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_fCobertura] ([id_cidade], [id_classe], [id_bioma], [ano], [area])
        SELECT   [id_cidade],
                 [id_classe],
                 [id_bioma],
                 [ano],
                 [area]
        FROM     [dbo].[fCobertura]
        ORDER BY [id_cidade] ASC, [id_classe] ASC, [id_bioma] ASC;
    END

DROP TABLE [dbo].[fCobertura];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_fCobertura]', N'fCobertura';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[dimTempo]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_dimTempo] (
    [id_dia]             NVARCHAR (50) NOT NULL,
    [data]               DATE          NULL,
    [id_semana]          INT           NULL,
    [desc_dia_semana]    NVARCHAR (50) NULL,
    [id_mes]             INT           NULL,
    [desc_mes]           NVARCHAR (50) NULL,
    [id_mes_ano]         NVARCHAR (50) NULL,
    [desc_mes_ano]       NVARCHAR (50) NULL,
    [id_trimestre]       INT           NULL,
    [desc_trimestre]     NVARCHAR (50) NULL,
    [id_trimestre_ano]   NVARCHAR (50) NULL,
    [desc_trimestre_ano] NVARCHAR (50) NULL,
    [id_semestre]        INT           NULL,
    [desc_semestre]      NVARCHAR (50) NULL,
    [id_semestre_ano]    NVARCHAR (50) NULL,
    [desc_semestre_ano]  NVARCHAR (50) NULL,
    [ano]                NVARCHAR (50) NOT NULL,
    [tipo_dia]           NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id_dia] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[dimTempo])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_dimTempo] ([id_dia], [data], [id_semana], [desc_dia_semana], [id_mes], [desc_mes], [id_mes_ano], [desc_mes_ano], [id_trimestre], [desc_trimestre], [id_trimestre_ano], [desc_trimestre_ano], [id_semestre], [desc_semestre], [id_semestre_ano], [desc_semestre_ano], [ano], [tipo_dia])
        SELECT   [id_dia],
                 [data],
                 [id_semana],
                 [desc_dia_semana],
                 [id_mes],
                 [desc_mes],
                 [id_mes_ano],
                 [desc_mes_ano],
                 [id_trimestre],
                 [desc_trimestre],
                 [id_trimestre_ano],
                 [desc_trimestre_ano],
                 [id_semestre],
                 [desc_semestre],
                 [id_semestre_ano],
                 [desc_semestre_ano],
                 [ano],
                 [tipo_dia]
        FROM     [dbo].[dimTempo]
        ORDER BY [id_dia] ASC;
    END

DROP TABLE [dbo].[dimTempo];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_dimTempo]', N'dimTempo';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fCobertura_dimLocalizacao]...';


GO
ALTER TABLE [dbo].[fCobertura] WITH NOCHECK
    ADD CONSTRAINT [FK_fCobertura_dimLocalizacao] FOREIGN KEY ([id_cidade]) REFERENCES [dbo].[dimLocalizacao] ([id_cidade]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fCobertura_dimClasse]...';


GO
ALTER TABLE [dbo].[fCobertura] WITH NOCHECK
    ADD CONSTRAINT [FK_fCobertura_dimClasse] FOREIGN KEY ([id_classe]) REFERENCES [dbo].[dimClasse] ([id_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fCobertura_DimBioma]...';


GO
ALTER TABLE [dbo].[fCobertura] WITH NOCHECK
    ADD CONSTRAINT [FK_fCobertura_DimBioma] FOREIGN KEY ([id_bioma]) REFERENCES [dbo].[dimBioma] ([id_bioma]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fCobertura_dimTempo]...';


GO
ALTER TABLE [dbo].[fCobertura] WITH NOCHECK
    ADD CONSTRAINT [FK_fCobertura_dimTempo] FOREIGN KEY ([id_dia]) REFERENCES [dbo].[dimTempo] ([id_dia]);


GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[fCobertura] WITH CHECK CHECK CONSTRAINT [FK_fCobertura_dimLocalizacao];

ALTER TABLE [dbo].[fCobertura] WITH CHECK CHECK CONSTRAINT [FK_fCobertura_dimClasse];

ALTER TABLE [dbo].[fCobertura] WITH CHECK CHECK CONSTRAINT [FK_fCobertura_DimBioma];

ALTER TABLE [dbo].[fCobertura] WITH CHECK CHECK CONSTRAINT [FK_fCobertura_dimTempo];


GO
PRINT N'Atualização concluída.';


GO
