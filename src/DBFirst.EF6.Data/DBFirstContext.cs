using DBFirst.EF6.Entity;
using System.Data.Entity;

namespace DBFirst.EF6.Data {
    public partial class DBFirstContext : DbContext {
	public DBFirstContext() : base("name=DBFirst") {
	    //disable initializer so that no code migrations happen
	    Database.SetInitializer<DBFirstContext>(null);
	}

	public virtual DbSet<Blog> Blogs { get; set; }
	public virtual DbSet<Post> Posts { get; set; }
    }
}
