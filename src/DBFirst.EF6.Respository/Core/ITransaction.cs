using System;
using System.Data;

namespace DBFirst.EF6.Respository.Core {

    public interface ITransaction : IDisposable {

	void Commit();

	void Rollback();

	void Enlist(IDbCommand cmd);
    }
}