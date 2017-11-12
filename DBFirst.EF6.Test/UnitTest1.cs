using DBFirst.EF6.Data;
using DBFirst.EF6.Data.EFRespository;
using DBFirst.EF6.DomainService;
using DBFirst.EF6.Facade;
using System;
using System.Linq;
using Xunit;

namespace DBFirst.EF6.Test {
    public class UnitTest1 {

	[Fact]
	public void ShouldBeAbleToCreateABlog() {
	    var facade = new ServiceFacade(new EFUnitOfWorkFactory()) as IServiceFacade;
	    var before = facade.GetBlogs().Count();
	    var name = Guid.NewGuid().ToString();
	    var blog = facade.CreateBlog(name, $"www.{name}.com");
	    var after = facade.GetBlogs().Count();

	    Assert.True(after > before, $"{after} > {before}");
	    Assert.NotEqual(0, blog.BlogId);
	}

	[Fact]
	public void ShouldBeAbleToLoadBlogs() {
	    var facade = new ServiceFacade(new EFUnitOfWorkFactory()) as IServiceFacade;
	    var count = facade.GetBlogs().Count();
	    Assert.True(count > 0, $"{count} > 0");
	}
    }
}
