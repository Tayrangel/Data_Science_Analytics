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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'A operação de refatoração Renomear com chave 1b2c82ea-432a-4707-9c69-2ce4a3c85915 foi ignorada; o elemento [dbo].[dimEstado].[Id] (SqlSimpleColumn) não será renomeado para id_estado';


GO
PRINT N'A operação de refatoração Renomear com chave f6f55b24-8f46-4714-bf3d-3fb2befffd02 foi ignorada; o elemento [dbo].[dimBioma].[Id] (SqlSimpleColumn) não será renomeado para id_bioma';


GO
PRINT N'A operação de refatoração Renomear com chave e2ad855e-27ab-48e3-9396-d6cc0abedfa5 foi ignorada; o elemento [dbo].[dimCobertura].[Id] (SqlSimpleColumn) não será renomeado para id_cobertura';


GO
PRINT N'A operação de refatoração Renomear com chave f79c3ee1-676e-4275-82bc-6afb08c703ca foi ignorada; o elemento [dbo].[dimTempo].[Id] (SqlSimpleColumn) não será renomeado para id_dia';


GO
PRINT N'A operação de refatoração Renomear com chave 3f8c3c83-86b2-4e97-914d-840d7afcb5cc foi ignorada; o elemento [dbo].[fCobertura].[Id] (SqlSimpleColumn) não será renomeado para id_estado';


GO
PRINT N'A operação de refatoração Renomear com chave 1f598a9a-0a61-4a13-8433-dcfadb671cab foi ignorada; o elemento [dbo].[FK_fCobertura_dimEstado] (SqlForeignKeyConstraint) não será renomeado para [FK_fCobertura_dimLocalizacao]';


GO
PRINT N'Criando Tabela [dbo].[dimBioma]...';


GO
CREATE TABLE [dbo].[dimBioma] (
    [id_bioma]   NVARCHAR (50) NOT NULL,
    [desc_bioma] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id_bioma] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[dimClasse]...';


GO
CREATE TABLE [dbo].[dimClasse] (
    [id_classe]      INT           NOT NULL,
    [desc_classe_n0] NVARCHAR (50) NULL,
    [desc_classe_n1] NVARCHAR (50) NULL,
    [desc_classe_n2] NVARCHAR (50) NULL,
    [desc_classe_n3] NVARCHAR (50) NULL,
    [desc_classe_n4] NVARCHAR (50) NULL,
    CONSTRAINT [PK_dimClasse] PRIMARY KEY CLUSTERED ([id_classe] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[dimLocalizacao]...';


GO
CREATE TABLE [dbo].[dimLocalizacao] (
    [id_cidade]   NVARCHAR (50) NOT NULL,
    [desc_cidade] NVARCHAR (50) NULL,
    [id_estado]   NVARCHAR (50) NULL,
    [desc_estado] NVARCHAR (50) NULL,
    [sigla]       NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id_cidade] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[dimTempo]...';


GO
CREATE TABLE [dbo].[dimTempo] (
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
    PRIMARY KEY CLUSTERED ([ano] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[fCobertura]...';


GO
CREATE TABLE [dbo].[fCobertura] (
    [id_cidade] NVARCHAR (50) NOT NULL,
    [id_classe] INT           NOT NULL,
    [id_bioma]  NVARCHAR (50) NOT NULL,
    [ano]       NVARCHAR (50) NOT NULL,
    [area]      FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([id_cidade] ASC, [id_classe] ASC, [id_bioma] ASC, [ano] ASC)
);


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
    ADD CONSTRAINT [FK_fCobertura_dimTempo] FOREIGN KEY ([ano]) REFERENCES [dbo].[dimTempo] ([ano]);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1b2c82ea-432a-4707-9c69-2ce4a3c85915')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1b2c82ea-432a-4707-9c69-2ce4a3c85915')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f6f55b24-8f46-4714-bf3d-3fb2befffd02')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f6f55b24-8f46-4714-bf3d-3fb2befffd02')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e2ad855e-27ab-48e3-9396-d6cc0abedfa5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e2ad855e-27ab-48e3-9396-d6cc0abedfa5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f79c3ee1-676e-4275-82bc-6afb08c703ca')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f79c3ee1-676e-4275-82bc-6afb08c703ca')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3f8c3c83-86b2-4e97-914d-840d7afcb5cc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3f8c3c83-86b2-4e97-914d-840d7afcb5cc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1f598a9a-0a61-4a13-8433-dcfadb671cab')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1f598a9a-0a61-4a13-8433-dcfadb671cab')

GO

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
