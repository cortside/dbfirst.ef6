CREATE TABLE [dbo].[Post] ( 
    [PostId] INT IDENTITY (1, 1) NOT NULL, 
    [Title] NVARCHAR (200) NULL, 
    [Content] NTEXT NULL, 
    [BlogId] INT NOT NULL, 
    CONSTRAINT [PK_dbo.Post] PRIMARY KEY CLUSTERED ([PostId] ASC), 
    CONSTRAINT [FK_dbo.Post_dbo.Blog_BlogId] FOREIGN KEY ([BlogId]) REFERENCES [dbo].[Blog] ([BlogId]) ON DELETE CASCADE 
);

