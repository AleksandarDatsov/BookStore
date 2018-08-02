﻿/*
Deployment script for BookStoree

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookStoree"
:setvar DefaultFilePrefix "BookStoree"
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
GO
-- Nomenclatures
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (1, N'Stephen', N'King')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (2, N'J.R.R.', N'Tolkien')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (3, N'Charles', N'Dickens')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (4, N'J.K', N'Rowling')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (5, N'Fyodor', N'Dostoevsky')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (6, N'Edgar', N'Allan')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (7, N'C.S.', N'Lewis')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (8, N'Roald', N'Dahl')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (9, N'Leo', N'Tolstoy')
INSERT INTO [dbo].[Author] ([Id], [FirstName], [LastName]) VALUES (10, N'William', N'Shakespeare')

GO

GO
PRINT N'Update complete.';


GO