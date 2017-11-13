using DBFirst.EF6.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.Facade {
    public interface IServiceFacade {
	IEnumerable<Blog> GetBlogs();
	Blog CreateBlog(string name, string v);
    }
}
