namespace DBFirst.EF6.Respository.Core {

    public interface IUnitOfWorkFactory {

	IUnitOfWork BeginUnitOfWork(bool implicitTransaction = true);

	IUnitOfWork GetCurrentUnitOfWork();
    }
}