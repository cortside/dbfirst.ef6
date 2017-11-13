if not exists (select * from [user] where userId=1)
  BEGIN
	SET IDENTITY_INSERT dbo.[User] ON
	insert into [User] 
	(UserId, UserStatus, Username, Password, LoginCount, LastLogin, LastLoginIPAddress, EffectiveDate, ExpirationDate, SecurityToken, CreateDate, CreateUserId, LastModifiedDate, LastModifiedUserId)
	values(1, 'Inactive', 'System', '', '0', null, '127.0.0.1', GETDATE(), GETDATE(), null, GETDATE(), 1, GETDATE(), 1)
	SET IDENTITY_INSERT dbo.[User] OFF
  END
 