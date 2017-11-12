using DBFirst.Entity;
using DBFirst.Respository.Core;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.Data.EFRespository {
    public abstract class EFBaseRepository<T> : BaseRepository<T> where T : BaseEntity {
	protected DBFirstContext context;
	private IQueryable<T> queryable;

	public EFBaseRepository() {
	    if (UnitOfWork.Current == null)
		throw new InvalidOperationException("Repository must be created in Unit of Work");

	    // TODO: not as abstract as NHibernate, needs rework
	    context = (UnitOfWork.Current as EFUnitOfWork).OrmContext as DBFirstContext;
	    queryable = context.Set<T>().AsQueryable();
	}

	public override IQueryable<T> Query {
	    get { return queryable; }
	}

	public override T Get(object id) {
	    if (id == null) {
		return default(T);
	    }
	    return context.Set<T>().Find(id);
	}

	public override void Insert(T entity) {
	    context.Set<T>().Add(entity);
	}

	public override void Delete(T entity) {
	    context.Set<T>().Remove(entity);
	}

	protected Int32 GetCurrenttUserId() {
	    // TODO: beyond scope
	    //var user = System.Threading.Thread.CurrentPrincipal as Spring2.DCMS.Security.IUserPrincipal;
	    //return user == null ? 0 : user.UserId;
	    return 1;
	}
    }
}
