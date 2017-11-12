using DBFirst.Entity;

namespace DBFirst.Respository.Core {

    public interface ICanDelete<T> where T : BaseEntity {

	void Delete(T entity);
    }
}