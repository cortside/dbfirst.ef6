using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.Data {
    public class DatabaseManager {
	private static DatabaseManager _instance;

	private DatabaseManager() {
	}

	static DatabaseManager() {
	    _instance = new DatabaseManager();
	}

	public static DatabaseManager Instance => _instance;

	public DBFirstContext Context { get; set; }
	public DBFirstContext CreateContext() {
	    this.Context = new DBFirstContext();
	    return this.Context;
	}
    }
}
