using Spring2.DataTierGenerator.Attribute;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System;

namespace DBFirst.EF6.Entity {
    [Table("Blog")]
    public class Blog : BaseEntity {
	[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
	public Blog() {
	    Posts = new HashSet<Post>();
	}

	public Int32 BlogId { get; set; }

	[StringLength(200)]
	public String Name { get; set; }

	[StringLength(200)]
	public String Url { get; set; }

	[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
	public virtual ICollection<Post> Posts { get; set; }

	[Generate()]
	private Int32 blogId = 0;
	[Generate()]
	private String name = null;
	[Generate()]
	private String url = null;
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
