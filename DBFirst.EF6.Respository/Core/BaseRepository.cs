using System.Linq;

namespace DBFirst.Respository.Core {

    public abstract class BaseRepository<T> : IRepository<T> {
	public abstract IQueryable<T> Query { get; }

	public abstract T Get(object id);

	public abstract void Insert(T entity);

	public abstract void Delete(T entity);
    }
}