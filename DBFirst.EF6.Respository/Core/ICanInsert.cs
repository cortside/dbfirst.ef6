using DBFirst.Entity;

namespace DBFirst.Respository.Core {

    public interface ICanInsert<T> where T : BaseEntity {

	void Insert(T entity);
    }
}