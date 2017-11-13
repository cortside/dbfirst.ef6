using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.Entity
{

    public interface IAuditableEntity
    {
        DateTime CreateDate { get; set; }
        int CreateUserId { get; set; }
        DateTime LastModifiedDate { get; set; }
        int LastModifiedUserId { get; set; }
    }
}
