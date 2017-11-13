IF OBJECT_ID('[dbo].[trBlog_Update]','TR') IS NOT NULL
BEGIN
	DROP TRIGGER [dbo].[trBlog_Update]
	PRINT 'Trigger Dropped: trBlog_Update '
END
GO

-- Create Update Trigger [dbo].[trBlog_Update] for Table [dbo].[Blog]
Print 'Create Update Trigger [dbo].[trBlog_Update] for Table [dbo].[Blog]'
go
CREATE TRIGGER [dbo].[trBlog_Update]
ON [dbo].[Blog]
FOR UPDATE
NOT FOR REPLICATION
As

BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),
		@AuditLogTransactionId	Int,
		@PRIM_KEY				nvarchar(4000),
		@Inserted	    		bit,
		--@TableName			nvarchar(4000),
 		@ROWS_COUNT				int
 
	SET NOCOUNT ON

	--Set @TableName = '[dbo].[Blog]'
	Select @ROWS_COUNT=count(*) from inserted
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))

-- CAS: get the userId from the inserted data
declare @userId int
select @userId=LastModifiedUserId from inserted

	INSERT
	INTO dbo.AuditLogTransaction 
	(
		TableName,
		TableSchema,
		AuditActionId,
		HostName,
		ApplicationName,
		AuditLogin,
		AuditDate,
		AffectedRows,
		DatabaseName,
		UserId
	)
	values(
		'Blog',
		'dbo',
		1,	--	ACTION ID For UPDATE
		CASE 
		  WHEN LEN(HOST_NAME()) < 1 THEN ' '
		  ELSE HOST_NAME()
		END,
		CASE 
		  WHEN LEN(APP_NAME()) < 1 THEN ' '
		  ELSE APP_NAME()
		END,
		SUSER_SNAME(),
		GETDATE(),
		@ROWS_COUNT,
		db_name(),
		@userId
	)
	
	
	Set @AuditLogTransactionId = SCOPE_IDENTITY()
	
	
	SET @Inserted = 0


	If UPDATE(BlogId)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'BlogId',
			CONVERT(nvarchar(4000), OLD.BlogId, 0),
			CONVERT(nvarchar(4000), NEW.BlogId, 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.BlogId <>
					OLD.BlogId
				) Or
			
				(
					NEW.BlogId Is Null And
					OLD.BlogId Is Not Null
				) Or
				(
					NEW.BlogId Is Not Null And
					OLD.BlogId Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	If UPDATE(Name)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'Name',
			CONVERT(nvarchar(4000), OLD.Name, 0),
			CONVERT(nvarchar(4000), NEW.Name, 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.Name <>
					OLD.Name
				) Or
			
				(
					NEW.Name Is Null And
					OLD.Name Is Not Null
				) Or
				(
					NEW.Name Is Not Null And
					OLD.Name Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	If UPDATE(Url)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'Url',
			CONVERT(nvarchar(4000), OLD.Url, 0),
			CONVERT(nvarchar(4000), NEW.Url, 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.Url <>
					OLD.Url
				) Or
			
				(
					NEW.Url Is Null And
					OLD.Url Is Not Null
				) Or
				(
					NEW.Url Is Not Null And
					OLD.Url Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	If UPDATE(CreateUserId)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'CreateUserId',
			CONVERT(nvarchar(4000), OLD.CreateUserId, 0),
			CONVERT(nvarchar(4000), NEW.CreateUserId, 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.CreateUserId <>
					OLD.CreateUserId
				) Or
			
				(
					NEW.CreateUserId Is Null And
					OLD.CreateUserId Is Not Null
				) Or
				(
					NEW.CreateUserId Is Not Null And
					OLD.CreateUserId Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	If UPDATE(CreateDate)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'CreateDate',
			CONVERT(nvarchar(4000), OLD.CreateDate, 121),
			CONVERT(nvarchar(4000), NEW.CreateDate, 121),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.CreateDate <>
					OLD.CreateDate
				) Or
			
				(
					NEW.CreateDate Is Null And
					OLD.CreateDate Is Not Null
				) Or
				(
					NEW.CreateDate Is Not Null And
					OLD.CreateDate Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	If UPDATE(LastModifiedUserId)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'LastModifiedUserId',
			CONVERT(nvarchar(4000), OLD.LastModifiedUserId, 0),
			CONVERT(nvarchar(4000), NEW.LastModifiedUserId, 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.LastModifiedUserId <>
					OLD.LastModifiedUserId
				) Or
			
				(
					NEW.LastModifiedUserId Is Null And
					OLD.LastModifiedUserId Is Not Null
				) Or
				(
					NEW.LastModifiedUserId Is Not Null And
					OLD.LastModifiedUserId Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	
	If UPDATE(LastModifiedDate)
	BEGIN
    
		INSERT
		INTO AuditLog 
		(
			AuditLogTransactionId,
			PrimaryKey,
			ColumnName,
			OldValue,
			NewValue,
			DataType
			, Key1
		)
		SELECT
			@AuditLogTransactionId,
		    convert(nvarchar(1500), IsNull('[BlogId]='+CONVERT(nvarchar(4000), IsNull(OLD.[BlogId], NEW.[BlogId]), 0), '[BlogId] Is Null')),
		    'LastModifiedDate',
			CONVERT(nvarchar(4000), OLD.LastModifiedDate, 121),
			CONVERT(nvarchar(4000), NEW.LastModifiedDate, 121),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[BlogId], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[BlogId], 0)))
			
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[BlogId], 0)=CONVERT(nvarchar(4000), OLD.[BlogId], 0) or (NEW.[BlogId] Is Null and OLD.[BlogId] Is Null))
			where (
				(
					NEW.LastModifiedDate <>
					OLD.LastModifiedDate
				) Or
			
				(
					NEW.LastModifiedDate Is Null And
					OLD.LastModifiedDate Is Not Null
				) Or
				(
					NEW.LastModifiedDate Is Not Null And
					OLD.LastModifiedDate Is Null
				)
				)
        
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	

	-- Watch
	
	-- Lookup
	
	IF @Inserted = 0
	BEGIN
		DELETE FROM dbo.AuditLogTransaction WHERE AuditLogTransactionId = @AuditLogTransactionId
	END
	-- Restore @@IDENTITY Value  
    DECLARE @maxprec AS varchar(2)
    SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
    EXEC('SELECT IDENTITY(decimal('+@maxprec+',0),'+@IDENTITY_SAVE+',1) id INTO #tmp')
End
GO

-- Display the status of Trigger Created
IF @@Error = 0 PRINT 'Trigger Created: trBlog_Update '
ELSE PRINT 'Trigger Failed: trBlog_Update Error on Creation'
GO

-- mark the trigger as last 

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE parent_obj=OBJECT_ID('[dbo].[Blog]') AND OBJECTPROPERTY(id,'ExecIsLastUpdateTrigger')=1 AND xtype='TR')
BEGIN
  EXEC sp_settriggerorder '[dbo].[trBlog_Update]', 'Last', 'Update'
  If @@Error = 0 PRINT 'Trigger trBlog_Update has been marked as Last' 
END

GO
