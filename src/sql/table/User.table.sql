SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*
if exists (select * from tempdb..sysobjects where name like '#spAlterColumn_User%' and xtype='P')
drop procedure #spAlterColumn_User
GO
*/

CREATE PROCEDURE #spAlterColumn_User
    @table varchar(100),
    @column varchar(100),
    @type varchar(50),
    @required bit
AS
if exists (select * from syscolumns where name=@column and id=object_id(@table))
begin
	declare @nullstring varchar(8)
	set @nullstring = case when @required=0 then 'null' else 'not null' end
	exec('alter table [' + @table + '] alter column [' + @column + '] ' + @type + ' ' + @nullstring)
end
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[User]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
CREATE TABLE dbo.[User] (
	UserId Int IDENTITY(1,1) NOT NULL,
	UserStatus VarChar(10) NULL,
	Username VarChar(100) NOT NULL,
	Password VarChar(50) NOT NULL,
	LoginCount Int NOT NULL CONSTRAINT [DF_User_LoginCount] DEFAULT (0),
	LastLogin DateTime NULL,
	LastLoginIPAddress VarChar(50) NULL,
	EffectiveDate DateTime NOT NULL,
	ExpirationDate DateTime NULL,
	SecurityToken VarChar(50) NULL,
	TokenExpiration DateTime NULL,
	TermsOfUseAcceptanceDate DateTime NULL,
	CreateDate DateTime NOT NULL,
	CreateUserId Int NOT NULL,
	LastModifiedDate DateTime NOT NULL,
	LastModifiedUserId Int NOT NULL

)
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'UserId')
  BEGIN
	ALTER TABLE [User] ADD
	    UserId Int IDENTITY(1,1) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='UserId') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='UserId' and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_User 'User', 'UserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'UserStatus')
  BEGIN
	ALTER TABLE [User] ADD
	    UserStatus VarChar(10) NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='UserStatus') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='UserStatus' and character_maximum_length=10 and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'UserStatus', 'VarChar(10)', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'Username')
  BEGIN
	ALTER TABLE [User] ADD
	    Username VarChar(100) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='Username') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='Username' and character_maximum_length=100 and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_User 'User', 'Username', 'VarChar(100)', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'Password')
  BEGIN
	ALTER TABLE [User] ADD
	    Password VarChar(50) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='Password') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='Password' and character_maximum_length=50 and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_User 'User', 'Password', 'VarChar(50)', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'LoginCount')
  BEGIN
	ALTER TABLE [User] ADD
	    LoginCount Int NOT NULL
	CONSTRAINT
	    [DF_User_LoginCount] DEFAULT 0 WITH VALUES
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='LoginCount') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='LoginCount' and is_nullable='YES')
  BEGIN
	declare @cdefault varchar(1000)
	select @cdefault = '[' + object_name(cdefault) + ']' from syscolumns where id=object_id('User') and name = 'LoginCount'

	if @cdefault is not null
		exec('alter table [User] DROP CONSTRAINT ' + @cdefault)
		
	if exists(select * from sysobjects where name = 'DF_User_LoginCount' and xtype='D')
          begin
            declare @table sysname
            select @table=object_name(parent_obj) from  sysobjects where (name = 'DF_User_LoginCount' and xtype='D')
            exec('alter table ' + @table + ' DROP CONSTRAINT [DF_User_LoginCount]')
          end
	
	exec #spAlterColumn_User 'User', 'LoginCount', 'Int', 0
	if not exists(select * from sysobjects where name = 'DF_User_LoginCount' and xtype='D')
		alter table [User]
			ADD CONSTRAINT [DF_User_LoginCount] DEFAULT 0 FOR LoginCount WITH VALUES
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'LastLogin')
  BEGIN
	ALTER TABLE [User] ADD
	    LastLogin DateTime NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='LastLogin') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='LastLogin' and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'LastLogin', 'DateTime', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'LastLoginIPAddress')
  BEGIN
	ALTER TABLE [User] ADD
	    LastLoginIPAddress VarChar(50) NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='LastLoginIPAddress') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='LastLoginIPAddress' and character_maximum_length=50 and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'LastLoginIPAddress', 'VarChar(50)', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'EffectiveDate')
  BEGIN
	ALTER TABLE [User] ADD
	    EffectiveDate DateTime NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='EffectiveDate') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='EffectiveDate' and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_User 'User', 'EffectiveDate', 'DateTime', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'ExpirationDate')
  BEGIN
	ALTER TABLE [User] ADD
	    ExpirationDate DateTime NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='ExpirationDate') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='ExpirationDate' and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'ExpirationDate', 'DateTime', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'SecurityToken')
  BEGIN
	ALTER TABLE [User] ADD
	    SecurityToken VarChar(50) NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='SecurityToken') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='SecurityToken' and character_maximum_length=50 and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'SecurityToken', 'VarChar(50)', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'TokenExpiration')
  BEGIN
	ALTER TABLE [User] ADD
	    TokenExpiration DateTime NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='TokenExpiration') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='TokenExpiration' and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'TokenExpiration', 'DateTime', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'TermsOfUseAcceptanceDate')
  BEGIN
	ALTER TABLE [User] ADD
	    TermsOfUseAcceptanceDate DateTime NULL
  END
GO


if exists(select * from information_schema.columns where table_name='[User]' and column_name='TermsOfUseAcceptanceDate') and not exists(select * from information_schema.columns where table_name='[User]' and column_name='TermsOfUseAcceptanceDate' and is_nullable='YES')
  BEGIN
	exec #spAlterColumn_User 'User', 'TermsOfUseAcceptanceDate', 'DateTime', 0
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'CreateUserId')
  BEGIN
	ALTER TABLE [User] ADD
		CreateUserId Int NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('[User]') and name = 'CreateUserId') and not exists(select * from sys.columns where object_id=object_id('[User]') and name = 'CreateUserId' and system_type_id=type_id('Int') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_User '[User]', 'CreateUserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'CreateDate')
  BEGIN
	ALTER TABLE [User] ADD
	    CreateDate DateTime NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('[User]') and name = 'CreateDate') and not exists(select * from sys.columns where object_id=object_id('[User]') and name = 'CreateDate' and system_type_id=type_id('DateTime') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_User '[User]', 'CreateDate', 'DateTime', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'LastModifiedUserId')
  BEGIN
	ALTER TABLE [User] ADD
		LastModifiedUserId Int NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('[User]') and name = 'LastModifiedUserId') and not exists(select * from sys.columns where object_id=object_id('[User]') and name = 'LastModifiedUserId' and system_type_id=type_id('Int') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_User '[User]', 'LastModifiedUserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('[User]') and name = 'LastModifiedDate')
  BEGIN
	ALTER TABLE [User] ADD
	    LastModifiedDate DateTime NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('[User]') and name = 'LastModifiedDate') and not exists(select * from sys.columns where object_id=object_id('[User]') and name = 'LastModifiedDate' and system_type_id=type_id('DateTime') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_User '[User]', 'LastModifiedDate', 'DateTime', 1
  END
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'PK_User') and OBJECTPROPERTY(id, N'IsPrimaryKey') = 1)
ALTER TABLE [User] WITH NOCHECK ADD
	CONSTRAINT PK_User PRIMARY KEY CLUSTERED
	(
		UserId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'UN_User') and OBJECTPROPERTY(id, N'IsUniqueCnst') = 1)
ALTER TABLE [User] ADD
	CONSTRAINT UN_User UNIQUE
	(
		Username
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_User_CreatedUser') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [User] ADD
	CONSTRAINT FK_User_CreatedUser FOREIGN KEY
	(
		CreateUserId
	)
	REFERENCES [User]
	(
		UserId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_User_LastModifiedUser') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [User] ADD
	CONSTRAINT FK_User_LastModifiedUser FOREIGN KEY
	(
		LastModifiedUserId
	)
	REFERENCES [User]
	(
		UserId
	)
GO

drop procedure #spAlterColumn_User
GO
