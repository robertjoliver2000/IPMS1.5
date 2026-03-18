CREATE TABLE [dbo].[Contacts]
(
	[ContactID] INT NOT NULL PRIMARY KEY , 
    [Surname] NVARCHAR(50) NOT NULL, 
	[Firstname] NVARCHAR(50) NULL,
    [Email] NVARCHAR(50) NULL, 
    [Login] NVARCHAR(50) NULL,
	[Mobile] NVARCHAR(20) NULL,
	[Salutation] NVARCHAR(20) NULL,
	[Rolename] NVARCHAR(50) NULL,
	[MaxPermission] NVARCHAR(50) NULL,
	[SuperUser]	BIT NULL
)
