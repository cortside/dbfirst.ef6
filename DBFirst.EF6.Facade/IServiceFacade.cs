using DBFirst.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.Facade {
    public interface IServiceFacade {
	IEnumerable<Blog> GetBlogs();
	Blog CreateBlog(string name, string v);
    }
}
