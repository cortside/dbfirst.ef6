using DBFirst.Respository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DBFirst.Entity;
using DBFirst.Respository.Core;

namespace DBFirst.Data.EFRespository {
    public class BlogRepository : EFBaseRepository<Blog>, IBlogRepository {

	public Blog GetBlog(int blogId) {
	    return Get(blogId);
	}

	public IEnumerable<Blog> GetBlogs() {
	    return context.Blogs.AsEnumerable<Blog>();
	}
    }
}
