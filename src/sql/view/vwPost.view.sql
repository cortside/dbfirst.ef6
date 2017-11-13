if exists (select * from sysobjects where id = object_id(N'dbo.[vwPost]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view dbo.[vwPost]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.[vwPost]

AS

SELECT
    Post.PostId,
    Post.BlogId,
    Post.Title,
    Post.Content,
    Post.CreateDate,
    Post.CreateUserId,
    Post.LastModifiedDate,
    Post.LastModifiedUserId

FROM
    Post
GO
