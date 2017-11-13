SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*
if exists (select * from tempdb..sysobjects where name like '#spAlterColumn_Blog%' and xtype='P')
drop procedure #spAlterColumn_Blog
GO
*/

CREATE PROCEDURE #spAlterColumn_Blog
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

if not exists (select * from dbo.sysobjects where id = object_id(N'[Blog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
CREATE TABLE dbo.Blog (
	BlogId Int IDENTITY(1,1) NOT NULL,
	Name VarChar(50) NOT NULL,
	Url VarChar(100) NOT NULL,
	CreateDate DateTime NOT NULL,
	CreateUserId Int NOT NULL,
	LastModifiedDate DateTime NOT NULL,
	LastModifiedUserId Int NOT NULL

)
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'BlogId')
  BEGIN
	ALTER TABLE Blog ADD
	    BlogId Int IDENTITY(1,1) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='Blog' and column_name='BlogId') and not exists(select * from information_schema.columns where table_name='Blog' and column_name='BlogId' and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'BlogId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'Name')
  BEGIN
	ALTER TABLE Blog ADD
	    Name VarChar(50) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='Blog' and column_name='Name') and not exists(select * from information_schema.columns where table_name='Blog' and column_name='Name' and character_maximum_length=50 and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'Name', 'VarChar(50)', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'Url')
  BEGIN
	ALTER TABLE Blog ADD
	    Url VarChar(100) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='Blog' and column_name='Url') and not exists(select * from information_schema.columns where table_name='Blog' and column_name='Url' and character_maximum_length=100 and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'Url', 'VarChar(100)', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'CreateUserId')
  BEGIN
	ALTER TABLE Blog ADD
		CreateUserId Int NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Blog') and name = 'CreateUserId') and not exists(select * from sys.columns where object_id=object_id('Blog') and name = 'CreateUserId' and system_type_id=type_id('Int') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'CreateUserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'CreateDate')
  BEGIN
	ALTER TABLE Blog ADD
	    CreateDate DateTime NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Blog') and name = 'CreateDate') and not exists(select * from sys.columns where object_id=object_id('Blog') and name = 'CreateDate' and system_type_id=type_id('DateTime') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'CreateDate', 'DateTime', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'LastModifiedUserId')
  BEGIN
	ALTER TABLE Blog ADD
		LastModifiedUserId Int NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Blog') and name = 'LastModifiedUserId') and not exists(select * from sys.columns where object_id=object_id('Blog') and name = 'LastModifiedUserId' and system_type_id=type_id('Int') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'LastModifiedUserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Blog') and name = 'LastModifiedDate')
  BEGIN
	ALTER TABLE Blog ADD
	    LastModifiedDate DateTime NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Blog') and name = 'LastModifiedDate') and not exists(select * from sys.columns where object_id=object_id('Blog') and name = 'LastModifiedDate' and system_type_id=type_id('DateTime') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Blog 'Blog', 'LastModifiedDate', 'DateTime', 1
  END
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'PK_Blog') and OBJECTPROPERTY(id, N'IsPrimaryKey') = 1)
ALTER TABLE Blog WITH NOCHECK ADD
	CONSTRAINT PK_Blog PRIMARY KEY CLUSTERED
	(
		BlogId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'UN_Blog_Name') and OBJECTPROPERTY(id, N'IsUniqueCnst') = 1)
ALTER TABLE Blog ADD
	CONSTRAINT UN_Blog_Name UNIQUE
	(
		Name
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_Blog_CreatedUser') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE Blog ADD
	CONSTRAINT FK_Blog_CreatedUser FOREIGN KEY
	(
		CreateUserId
	)
	REFERENCES [User]
	(
		UserId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_Blog_LastModifiedUser') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE Blog ADD
	CONSTRAINT FK_Blog_LastModifiedUser FOREIGN KEY
	(
		LastModifiedUserId
	)
	REFERENCES [User]
	(
		UserId
	)
GO
if not exists (select * from sys.indexes where name='IxBlog_BlogId' and object_id=object_id(N'[Blog]'))
	CREATE INDEX IxBlog_BlogId ON Blog
	(
        	BlogId
	)
GO

drop procedure #spAlterColumn_Blog
GO
