if exists (select * from sysobjects where id = object_id(N'dbo.[vwBlog]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view dbo.[vwBlog]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.[vwBlog]

AS

SELECT
    Blog.BlogId,
    Blog.Name,
    Blog.Url,
    Blog.CreateDate,
    Blog.CreateUserId,
    Blog.LastModifiedDate,
    Blog.LastModifiedUserId

FROM
    Blog
GO
