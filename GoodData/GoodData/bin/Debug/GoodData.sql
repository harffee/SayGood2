﻿/*
Deployment script for GoodData

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "GoodData"
:setvar DefaultFilePrefix "GoodData"
:setvar DefaultDataPath "C:\Users\v-jzingh\AppData\Local\Microsoft\VisualStudio\SSDT\GoodData"
:setvar DefaultLogPath "C:\Users\v-jzingh\AppData\Local\Microsoft\VisualStudio\SSDT\GoodData"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
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
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Rename refactoring operation with key 5b8a9b84-2323-4cdb-9abd-0a80a4575a4b is skipped, element [dbo].[Detail].[Id] (SqlSimpleColumn) will not be renamed to UpdateId';


GO
PRINT N'Rename refactoring operation with key 8c1386c5-410d-47da-976d-60c23c36e5c2 is skipped, element [dbo].[Detail].[dESC] (SqlSimpleColumn) will not be renamed to Desc';


GO
PRINT N'Creating [dbo].[Account]...';


GO
CREATE TABLE [dbo].[Account] (
    [Id]    INT            NOT NULL,
    [Alias] NVARCHAR (50)  NOT NULL,
    [Name]  NVARCHAR (50)  NOT NULL,
    [Role]  INT            NOT NULL,
    [Got]   INT            NULL,
    [Give]  INT            NULL,
    [Pic]   NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Detail]...';


GO
CREATE TABLE [dbo].[Detail] (
    [UpdateId] INT            NOT NULL,
    [Name]     NVARCHAR (50)  NOT NULL,
    [UpDate]   DATETIME2 (7)  NOT NULL,
    [Desc]     NVARCHAR (MAX) NOT NULL,
    [ToWho]    NVARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([UpdateId] ASC)
);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5b8a9b84-2323-4cdb-9abd-0a80a4575a4b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5b8a9b84-2323-4cdb-9abd-0a80a4575a4b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8c1386c5-410d-47da-976d-60c23c36e5c2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8c1386c5-410d-47da-976d-60c23c36e5c2')

GO

GO
PRINT N'Update complete.';


GO
