if exists (select * from sysobjects where id = object_id(N'dbo.[vwUser]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view dbo.[vwUser]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.[vwUser]

AS

SELECT
    [User].UserId,
    [User].UserStatus,
    [User].Username,
    [User].Password,
    [User].LoginCount,
    [User].LastLogin,
    [User].LastLoginIPAddress,
    [User].EffectiveDate,
    [User].ExpirationDate,
    [User].SecurityToken,
    [User].TokenExpiration,
    [User].TermsOfUseAcceptanceDate,
    [User].CreateDate,
    [User].CreateUserId,
    [User].LastModifiedDate,
    [User].LastModifiedUserId

FROM
    [User]
GO
