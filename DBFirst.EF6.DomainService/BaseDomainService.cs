using DBFirst.EF6.Respository.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.DomainService {
    public abstract class BaseDomainService {

	protected internal virtual IUnitOfWork UnitOfWorkInstance {
	    get { return UnitOfWork.Current; }
	}

    }
}
