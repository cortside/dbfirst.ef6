SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*
if exists (select * from tempdb..sysobjects where name like '#spAlterColumn_Post%' and xtype='P')
drop procedure #spAlterColumn_Post
GO
*/

CREATE PROCEDURE #spAlterColumn_Post
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

if not exists (select * from dbo.sysobjects where id = object_id(N'[Post]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
CREATE TABLE dbo.Post (
	PostId Int IDENTITY(1,1) NOT NULL,
	BlogId Int NOT NULL,
	Title VarChar(200) NOT NULL,
	Content Text NOT NULL,
	CreateDate DateTime NOT NULL,
	CreateUserId Int NOT NULL,
	LastModifiedDate DateTime NOT NULL,
	LastModifiedUserId Int NOT NULL

)
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'PostId')
  BEGIN
	ALTER TABLE Post ADD
	    PostId Int IDENTITY(1,1) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='Post' and column_name='PostId') and not exists(select * from information_schema.columns where table_name='Post' and column_name='PostId' and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_Post 'Post', 'PostId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'BlogId')
  BEGIN
	ALTER TABLE Post ADD
	    BlogId Int NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='Post' and column_name='BlogId') and not exists(select * from information_schema.columns where table_name='Post' and column_name='BlogId' and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_Post 'Post', 'BlogId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'Title')
  BEGIN
	ALTER TABLE Post ADD
	    Title VarChar(200) NOT NULL
  END
GO


if exists(select * from information_schema.columns where table_name='Post' and column_name='Title') and not exists(select * from information_schema.columns where table_name='Post' and column_name='Title' and character_maximum_length=200 and is_nullable='NO')
  BEGIN
	exec #spAlterColumn_Post 'Post', 'Title', 'VarChar(200)', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'Content')
  BEGIN
	ALTER TABLE Post ADD
	    Content Text NOT NULL
  END
GO
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'CreateUserId')
  BEGIN
	ALTER TABLE Post ADD
		CreateUserId Int NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Post') and name = 'CreateUserId') and not exists(select * from sys.columns where object_id=object_id('Post') and name = 'CreateUserId' and system_type_id=type_id('Int') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Post 'Post', 'CreateUserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'CreateDate')
  BEGIN
	ALTER TABLE Post ADD
	    CreateDate DateTime NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Post') and name = 'CreateDate') and not exists(select * from sys.columns where object_id=object_id('Post') and name = 'CreateDate' and system_type_id=type_id('DateTime') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Post 'Post', 'CreateDate', 'DateTime', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'LastModifiedUserId')
  BEGIN
	ALTER TABLE Post ADD
		LastModifiedUserId Int NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Post') and name = 'LastModifiedUserId') and not exists(select * from sys.columns where object_id=object_id('Post') and name = 'LastModifiedUserId' and system_type_id=type_id('Int') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Post 'Post', 'LastModifiedUserId', 'Int', 1
  END
GO

if not exists(select * from syscolumns where id=object_id('Post') and name = 'LastModifiedDate')
  BEGIN
	ALTER TABLE Post ADD
	    LastModifiedDate DateTime NOT NULL
  END
GO

if exists(select * from sys.columns where object_id=object_id('Post') and name = 'LastModifiedDate') and not exists(select * from sys.columns where object_id=object_id('Post') and name = 'LastModifiedDate' and system_type_id=type_id('DateTime') and is_nullable= 0)
  BEGIN
	exec #spAlterColumn_Post 'Post', 'LastModifiedDate', 'DateTime', 1
  END
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'PK_Post') and OBJECTPROPERTY(id, N'IsPrimaryKey') = 1)
ALTER TABLE Post WITH NOCHECK ADD
	CONSTRAINT PK_Post PRIMARY KEY CLUSTERED
	(
		PostId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_Post_Blog') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE Post ADD
	CONSTRAINT FK_Post_Blog FOREIGN KEY
	(
		BlogId
	)
	REFERENCES Blog
	(
		BlogId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_Post_CreatedUser') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE Post ADD
	CONSTRAINT FK_Post_CreatedUser FOREIGN KEY
	(
		CreateUserId
	)
	REFERENCES [User]
	(
		UserId
	)
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'FK_Post_LastModifiedUser') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE Post ADD
	CONSTRAINT FK_Post_LastModifiedUser FOREIGN KEY
	(
		LastModifiedUserId
	)
	REFERENCES [User]
	(
		UserId
	)
GO

drop procedure #spAlterColumn_Post
GO
