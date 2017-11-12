using DBFirst.Entity;
using DBFirst.Respository.Core;
using System;
using System.Collections.Generic;

namespace DBFirst.Respository {

    public interface IBlogRepository : IRepository<Blog>, ICanInsert<Blog>, ICanDelete<Blog> {

	Blog GetBlog(Int32 blogId);
	IEnumerable<Blog> GetBlogs();
    }
}