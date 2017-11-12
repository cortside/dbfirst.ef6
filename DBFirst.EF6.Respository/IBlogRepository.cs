using DBFirst.EF6.Entity;
using DBFirst.EF6.Respository.Core;
using System;
using System.Collections.Generic;

namespace DBFirst.EF6.Respository {

    public interface IBlogRepository : IRepository<Blog>, ICanInsert<Blog>, ICanDelete<Blog> {

	Blog GetBlog(Int32 blogId);
	IEnumerable<Blog> GetBlogs();
    }
}