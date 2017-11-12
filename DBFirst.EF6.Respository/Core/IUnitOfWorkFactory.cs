namespace DBFirst.Respository.Core {

    public interface IUnitOfWorkFactory {

	IUnitOfWork BeginUnitOfWork(bool implicitTransaction = true);

	IUnitOfWork GetCurrentUnitOfWork();
    }
}