using DBFirst.EF6.Data;
using DBFirst.EF6.Respository.Core;
using System;
using System.Data;
using System.Data.Entity;
using SCITransaction = DBFirst.EF6.Respository.Core.ITransaction;

namespace DBFirst.EF6.Data {

    public class EFUnitOfWork : BaseUnitOfWork<DbContext>, IUnitOfWork {

	public EFUnitOfWork(DbContext session, bool implicitTransaction) : base(session) {
	    if (implicitTransaction) {
		transaction = BeginTransaction();
	    }
	}

	public override bool IsInTransaction {
	    get { return OrmContext.Database.CurrentTransaction != null; }
	}

	public override SCITransaction CurrentTransaction {
	    get { return transaction; }
	}

	public override void Commit(bool newImplicitTransaction = false) {
	    if (this.transaction == null) {
		OrmContext.SaveChanges();
	    } else {
		OrmContext.SaveChanges();
		transaction.Commit();
		if (newImplicitTransaction) {
		    transaction.Dispose();
		    transaction = BeginTransaction();
		}
	    }
	}

	public override SCITransaction BeginTransaction(IsolationLevel isolationLevel = IsolationLevel.ReadUncommitted, bool autoFlush = true) {
	    // TODO: don't think this is supported
	    //OrmContext.FlushMode = autoFlush ? FlushMode.Auto : FlushMode.Commit;
	    return new EFTransaction(OrmContext, OrmContext.Database.BeginTransaction(isolationLevel));
	}

	public override void Dispose() {
	    base.Dispose();

	    // TODO: beyond scope
	    //OrmContext.SessionFactory.EvictQueries(CacheRegion.PerSession);
	    //OrmContext.Close();
	    //OrmContext.Dispose();
	}

	public override void Flush() {
	    OrmContext.SaveChanges();
	}

	/// <summary>
	/// Attach an entity from a different session back into the current session
	/// </summary>
	/// <see cref="http://weblogs.asp.net/ricardoperes/archive/2013/03/21/attaching-disconnected-entities-in-nhibernate-without-going-to-the-database.aspx"/>
	/// <param name="entity"></param>
	public override void Attach(Object entity) {
	    // TODO: beyond scope
	    //LockMode mode = LockMode.None;

	    //IEntityPersister persister = OrmContext.GetSessionImplementation().GetEntityPersister(NHibernateProxyHelper.GuessClass(entity).FullName, entity);
	    //Object[] fields = persister.GetPropertyValues(entity, OrmContext.ActiveEntityMode);
	    //Object id = persister.GetIdentifier(entity, OrmContext.ActiveEntityMode);
	    //EntityEntry entry = OrmContext.GetSessionImplementation().PersistenceContext.AddEntry(entity, Status.Loaded, fields, null, id, null, mode, true, persister, true, false);
	}
    }
}