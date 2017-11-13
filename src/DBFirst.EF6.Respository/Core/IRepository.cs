using System.Linq;

namespace DBFirst.EF6.Respository.Core {

    public interface IRepository<T> {
	IQueryable<T> Query { get; }

	T Get(object id);
    }
}