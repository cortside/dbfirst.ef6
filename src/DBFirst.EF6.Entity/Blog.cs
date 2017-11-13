using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBFirst.EF6.Entity {
    [Table("Blog")]
    public partial class Blog : BaseEntity {
	[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
	public Blog() {
	    Posts = new HashSet<Post>();
	}

	public int BlogId { get; set; }

	[StringLength(200)]
	public string Name { get; set; }

	[StringLength(200)]
	public string Url { get; set; }

	[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
	public virtual ICollection<Post> Posts { get; set; }
    }
}
