using DBFirst.EF6.Entity;

namespace DBFirst.EF6.Respository.Core {

    public interface ICanDelete<T> where T : BaseEntity {

	void Delete(T entity);
    }
}