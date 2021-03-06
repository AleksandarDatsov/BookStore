﻿/*
Deployment script for BookStore

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookStore"
:setvar DefaultFilePrefix "BookStore"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.ENTERPRISE2014\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.ENTERPRISE2014\MSSQL\DATA\"

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
/*
The column [dbo].[Book].[Price] on table [dbo].[Book] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column NumbersInStock on table [dbo].[Book] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Book])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering [dbo].[Book]...';


GO
ALTER TABLE [dbo].[Book] ALTER COLUMN [NumbersInStock] INT NOT NULL;


GO
ALTER TABLE [dbo].[Book]
    ADD [Price] DECIMAL (18, 2) NOT NULL;


GO
PRINT N'Creating [dbo].[Purchase]...';


GO
CREATE TABLE [dbo].[Purchase] (
    [Id]                  INT NOT NULL,
    [BookId]              INT NULL,
    [UserId]              INT NULL,
    [IsPurchasedFinished] BIT NULL,
    CONSTRAINT [PK_Purchase] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FK_Purchase_User]...';


GO
ALTER TABLE [dbo].[Purchase] WITH NOCHECK
    ADD CONSTRAINT [FK_Purchase_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Purchase_BookId]...';


GO
ALTER TABLE [dbo].[Purchase] WITH NOCHECK
    ADD CONSTRAINT [FK_Purchase_BookId] FOREIGN KEY ([BookId]) REFERENCES [dbo].[Book] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Purchase] WITH CHECK CHECK CONSTRAINT [FK_Purchase_User];

ALTER TABLE [dbo].[Purchase] WITH CHECK CHECK CONSTRAINT [FK_Purchase_BookId];


GO
PRINT N'Update complete.';


GO
