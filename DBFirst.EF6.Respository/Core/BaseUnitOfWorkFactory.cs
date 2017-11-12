namespace DBFirst.Respository.Core {

    public abstract class BaseUnitOfWorkFactory : IUnitOfWorkFactory {

	public IUnitOfWork BeginUnitOfWork(bool implicitTransaction = true) {
	    //if (UnitOfWork.Current != null) {
	    //    throw new InvalidOperationException("Cannot create a unit of work when currently in one already.");
	    //}
	    IUnitOfWork unitOfWork = GetUnitOfWork(implicitTransaction);
	    UnitOfWork.SetCurrent(unitOfWork);
	    return unitOfWork;
	}

	public IUnitOfWork GetCurrentUnitOfWork() {
	    return UnitOfWork.Current;
	}

	protected abstract IUnitOfWork GetUnitOfWork(bool implicitTransaction);
    }
}