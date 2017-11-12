using DBFirst.EF6.Entity;
using DBFirst.EF6.Respository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.DomainService {
    public class BlogService : BaseDomainService, IBlogService {
	private readonly IBlogRepository repository;

	public BlogService(IBlogRepository repository) {
	    this.repository = repository;
	}

	public Blog CreateBlog(string name, string url) {
	    var blog = new Blog() {
		Name = name,
		Url = url
	    };
	    repository.Insert(blog);
	    return blog;
	}

	public IEnumerable<Blog> GetBlogs() {
	    return repository.GetBlogs();
	}
    }
}
