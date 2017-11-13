using Spring2.DataTierGenerator.Attribute;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System;

namespace DBFirst.EF6.Entity {
    [Table("Post")]
    public class Post : BaseEntity {
	public Int32 PostId { get; set; }

	[StringLength(200)]
	public String Title { get; set; }

	[Column(TypeName = "ntext")]
	public String Content { get; set; }

	public Int32 BlogId { get; set; }

	public virtual Blog Blog { get; set; }

	[Generate()]
	private Int32 postId = 0;
	[Generate()]
	private Blog blog = new Blog();
	[Generate()]
	private String title = null;
	[Generate()]
	private String content = null;
	[Generate()]
	private DateTime createDate = new DateTime();
	[Generate()]
	private Int32 createUserId = 0;
	[Generate()]
	private DateTime lastModifiedDate = new DateTime();
	[Generate()]
	private Int32 lastModifiedUserId = 0;

	[Generate()]
	public virtual DateTime CreateDate {
	    get { return this.createDate; }
	    set { this.createDate = value; }
	}

	[Generate()]
	public virtual Int32 CreateUserId {
	    get { return this.createUserId; }
	    set { this.createUserId = value; }
	}

	[Generate()]
	public virtual DateTime LastModifiedDate {
	    get { return this.lastModifiedDate; }
	    set { this.lastModifiedDate = value; }
	}

	[Generate()]
	public virtual Int32 LastModifiedUserId {
	    get { return this.lastModifiedUserId; }
	    set { this.lastModifiedUserId = value; }
	}
    }
}
