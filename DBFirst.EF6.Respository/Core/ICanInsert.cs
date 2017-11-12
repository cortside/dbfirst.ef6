using DBFirst.EF6.Entity;

namespace DBFirst.EF6.Respository.Core {

    public interface ICanInsert<T> where T : BaseEntity {

	void Insert(T entity);
    }
}