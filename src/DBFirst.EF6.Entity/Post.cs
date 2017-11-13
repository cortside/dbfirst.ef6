using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBFirst.EF6.Entity {
    [Table("Post")]
    public partial class Post : BaseEntity {
	public int PostId { get; set; }

	[StringLength(200)]
	public string Title { get; set; }

	[Column(TypeName = "ntext")]
	public string Content { get; set; }

	public int BlogId { get; set; }

	public virtual Blog Blog { get; set; }
    }
}
