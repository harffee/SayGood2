CREATE TABLE [dbo].[Account]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Alias] NVARCHAR(50) NOT NULL, 
    [Name] NVARCHAR(50) NOT NULL, 
    [Role] INT NOT NULL, 
    [Got] INT NULL, 
    [Give] INT NULL, 
    [Pic] NVARCHAR(MAX) NULL
)
