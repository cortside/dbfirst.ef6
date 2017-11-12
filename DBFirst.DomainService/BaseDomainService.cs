using DBFirst.Respository.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.DomainService {
    public abstract class BaseDomainService {

	protected internal virtual IUnitOfWork UnitOfWorkInstance {
	    get { return UnitOfWork.Current; }
	}

    }
}
