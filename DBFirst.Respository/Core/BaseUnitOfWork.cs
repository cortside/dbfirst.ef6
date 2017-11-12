using System.Data;

namespace DBFirst.Respository.Core {

    public abstract class BaseUnitOfWork<T> : IUnitOfWork {
	protected ITransaction transaction;

	public T OrmContext { private set; get; }

	public BaseUnitOfWork(T ormContext) {
	    OrmContext = ormContext;
	}

	public virtual void Dispose() {
	    if (transaction != null) {
		transaction.Dispose();
	    }
	    if (UnitOfWork.Current == this) {
		UnitOfWork.UnsetCurrent();
	    }
	}

	public abstract ITransaction BeginTransaction(IsolationLevel isolationLevel = IsolationLevel.ReadUncommitted, bool autoFlush = true);

	public abstract bool IsInTransaction { get; }

	public abstract void Commit(bool newImplicitTransaction = false);

	public abstract void Flush();

	public abstract void Attach(object entity);

	public abstract ITransaction CurrentTransaction { get; }
    }
}