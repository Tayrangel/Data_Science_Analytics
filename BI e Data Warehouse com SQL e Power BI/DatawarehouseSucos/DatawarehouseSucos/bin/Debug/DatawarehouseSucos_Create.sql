/*
Script de implantação para DatawarehouseSucos

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DatawarehouseSucos"
:setvar DefaultFilePrefix "DatawarehouseSucos"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Criando o banco de dados $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
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
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'As configurações de banco de dados não podem ser modificadas. Você deve ser um SysAdmin para aplicar essas configurações.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'As configurações de banco de dados não podem ser modificadas. Você deve ser um SysAdmin para aplicar essas configurações.';
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
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
PRINT N'Criando Tabela [dbo].[Fato_003]...';


GO
CREATE TABLE [dbo].[Fato_003] (
    [cod_fabrica] NVARCHAR (50) NOT NULL,
    [cod_dia]     NVARCHAR (50) NOT NULL,
    [custo_fixo]  FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([cod_fabrica] ASC, [cod_dia] ASC)
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
PRINT N'Criando Tabela [dbo].[Dim_Marca]...';


GO
CREATE TABLE [dbo].[Dim_Marca] (
    [cod_marca]     NVARCHAR (50)  NOT NULL,
    [desc_marca]    NVARCHAR (200) NULL,
    [cod_categoria] NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([cod_marca] ASC)
);


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
PRINT N'Criando Tabela [dbo].[Dim_Fabrica]...';


GO
CREATE TABLE [dbo].[Dim_Fabrica] (
    [cod_fabrica]  NVARCHAR (50)  NOT NULL,
    [desc_fabrica] NVARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([cod_fabrica] ASC)
);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_005_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_005]
    ADD CONSTRAINT [FK_Fato_005_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_005_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_005]
    ADD CONSTRAINT [FK_Fato_005_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_005_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_005]
    ADD CONSTRAINT [FK_Fato_005_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_004]
    ADD CONSTRAINT [FK_Fato_004_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [dbo].[Dim_Cliente] ([cod_cliente]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_004]
    ADD CONSTRAINT [FK_Fato_004_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Fato_004]
    ADD CONSTRAINT [FK_Fato_004_Dim_Organizacional] FOREIGN KEY ([cod_organizacional]) REFERENCES [dbo].[Dim_Organizacional] ([cod_filho]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_004_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_004]
    ADD CONSTRAINT [FK_Fato_004_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_003_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_003]
    ADD CONSTRAINT [FK_Fato_003_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_003_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_003]
    ADD CONSTRAINT [FK_Fato_003_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_002]
    ADD CONSTRAINT [FK_Fato_002_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [dbo].[Dim_Cliente] ([cod_cliente]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_002]
    ADD CONSTRAINT [FK_Fato_002_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_002]
    ADD CONSTRAINT [FK_Fato_002_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_002_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_002]
    ADD CONSTRAINT [FK_Fato_002_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Cliente] FOREIGN KEY ([cod_cliente]) REFERENCES [dbo].[Dim_Cliente] ([cod_cliente]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Produto] FOREIGN KEY ([cod_produto]) REFERENCES [dbo].[Dim_Produto] ([cod_produto]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Organizacional] FOREIGN KEY ([cod_organizacional]) REFERENCES [dbo].[Dim_Organizacional] ([cod_filho]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Fabrica]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Fabrica] FOREIGN KEY ([cod_fabrica]) REFERENCES [dbo].[Dim_Fabrica] ([cod_fabrica]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Fato_001_Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Tempo] FOREIGN KEY ([cod_dia]) REFERENCES [dbo].[Dim_Tempo] ([cod_dia]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Dim_Organizacional_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Dim_Organizacional]
    ADD CONSTRAINT [FK_Dim_Organizacional_Dim_Organizacional] FOREIGN KEY ([cod_pai]) REFERENCES [dbo].[Dim_Organizacional] ([cod_filho]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Dim_Produto_Dim_Marca]...';


GO
ALTER TABLE [dbo].[Dim_Produto]
    ADD CONSTRAINT [FK_Dim_Produto_Dim_Marca] FOREIGN KEY ([cod_marca]) REFERENCES [dbo].[Dim_Marca] ([cod_marca]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_Dim_Marca_Dim_Categoria]...';


GO
ALTER TABLE [dbo].[Dim_Marca]
    ADD CONSTRAINT [FK_Dim_Marca_Dim_Categoria] FOREIGN KEY ([cod_categoria]) REFERENCES [dbo].[Dim_Categoria] ([cod_categoria]);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd4ef92b8-9ddb-417d-944f-9ff4f2da9a6e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d4ef92b8-9ddb-417d-944f-9ff4f2da9a6e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6b2e5d4e-261a-4688-aa6c-52b8761ceaa6')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6b2e5d4e-261a-4688-aa6c-52b8761ceaa6')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c0753fae-c804-40de-bf0f-c395e6779b01')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c0753fae-c804-40de-bf0f-c395e6779b01')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5dcbbc61-bbbf-46d3-a3c9-9c2fee5e48d4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5dcbbc61-bbbf-46d3-a3c9-9c2fee5e48d4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4af4e02e-0ad0-4027-967b-612948db49c0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4af4e02e-0ad0-4027-967b-612948db49c0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f9d47103-f45b-49c7-bd0e-f7f3524cbf0e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f9d47103-f45b-49c7-bd0e-f7f3524cbf0e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bd8a652b-6383-49d1-993a-fea1ff7e45b1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bd8a652b-6383-49d1-993a-fea1ff7e45b1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f39d56b9-dbc0-4ad0-9882-c26239df7bd6')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f39d56b9-dbc0-4ad0-9882-c26239df7bd6')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '00881bdd-942e-4b0d-93ad-be6000739857')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('00881bdd-942e-4b0d-93ad-be6000739857')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b0d22ba5-c547-41cb-aa87-17a3ccbce8ad')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b0d22ba5-c547-41cb-aa87-17a3ccbce8ad')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Atualização concluída.';


GO
