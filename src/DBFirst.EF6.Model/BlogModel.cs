using System;

using Spring2.DataTierGenerator.Attribute;
using System.Linq;

namespace DBFirst.EF6.Model {
    public class BlogModel {
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
	public Int32 BlogId {
	    get { return this.blogId; }
	    set { this.blogId = value; }
	}

	[Generate()]
	public String Name {
	    get { return this.name; }
	    set { this.name = value; }
	}

	[Generate()]
	public String Url {
	    get { return this.url; }
	    set { this.url = value; }
	}

	[Generate()]
	public DateTime CreateDate {
	    get { return this.createDate; }
	    set { this.createDate = value; }
	}

	[Generate()]
	public Int32 CreateUserId {
	    get { return this.createUserId; }
	    set { this.createUserId = value; }
	}

	[Generate()]
	public DateTime LastModifiedDate {
	    get { return this.lastModifiedDate; }
	    set { this.lastModifiedDate = value; }
	}

	[Generate()]
	public Int32 LastModifiedUserId {
	    get { return this.lastModifiedUserId; }
	    set { this.lastModifiedUserId = value; }
	}
    }
}
