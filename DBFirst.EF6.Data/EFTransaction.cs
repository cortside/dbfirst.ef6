using System.Data;
using System.Data.Entity;

namespace DBFirst.Data {
    public class EFTransaction : Respository.Core.ITransaction {
	private DbContext session;

	public DbContextTransaction Transaction { private set; get; }

	public EFTransaction(DbContext session, DbContextTransaction transaction) {
	    Transaction = transaction;
	    this.session = session;
	}

	public void Commit() {
	    Transaction.Commit();
	}

	public void Rollback() {
	    Transaction.Rollback();
	}

	public void Dispose() {
	    Transaction.Dispose();
	    Transaction = null;
	}

	public void Enlist(IDbCommand cmd) {
	    // TODO: beyond scope
	    //   if (Transaction != null) {
	    //Transaction.Enlist(cmd);
	    //   }
	}
    }
}
