using DBFirst.EF6.Respository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DBFirst.EF6.Entity;
using DBFirst.EF6.Respository.Core;

namespace DBFirst.EF6.Data.EFRespository {
    public class BlogRepository : EFBaseRepository<Blog>, IBlogRepository {

	public Blog GetBlog(int blogId) {
	    return Get(blogId);
	}

	public IEnumerable<Blog> GetBlogs() {
	    return context.Blogs.AsEnumerable<Blog>();
	}
    }
}
