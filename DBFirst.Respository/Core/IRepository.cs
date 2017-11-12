using System.Linq;

namespace DBFirst.Respository.Core {

    public interface IRepository<T> {
	IQueryable<T> Query { get; }

	T Get(object id);
    }
}