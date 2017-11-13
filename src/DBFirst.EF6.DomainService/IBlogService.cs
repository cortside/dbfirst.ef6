using DBFirst.EF6.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.DomainService {
    public interface IBlogService {
	IEnumerable<Blog> GetBlogs();
	Blog CreateBlog(string name, string url);
    }
}
