using DBFirst.EF6.Respository.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.Data {
    public class EFUnitOfWorkFactory : BaseUnitOfWorkFactory, IDisposable {
	//private ISessionFactory sessionFactory;

	public EFUnitOfWorkFactory() {
	}

	//public EFUnitOfWorkFactory(string connectionStringKey, IWindsorContainer container) {
	//    this.sessionFactory = Configure(connectionStringKey, container);
	//}

	//private ISessionFactory Configure(string connectionStringKey, IWindsorContainer container) {
	//    IoCInterceptor interceptor = new IoCInterceptor(container);
	//    string assemblyName = Assembly.GetExecutingAssembly().FullName;
	//    assemblyName = assemblyName.Substring(0, assemblyName.IndexOf(','));

	//    Configuration cfg = new Configuration()
	//	.SetInterceptor(interceptor)
	//	.SetProperty("connection.connection_string_name", connectionStringKey)
	//	.Configure(GetType().Assembly, assemblyName + ".Mappings.hibernate.cfg.xml")
	//	.AddAssembly(GetType().Assembly);
	//    ISessionFactory factory = cfg.BuildSessionFactory();
	//    interceptor.SetSessionFactory(factory);

	//    return factory;
	//}

	protected override IUnitOfWork GetUnitOfWork(bool implicitTransaction) {
	    return new EFUnitOfWork(new DBFirstContext(), implicitTransaction);
	}

	#region IDisposable Members

	public void Dispose() {
	    // TODO: beyond scope
	    //   if (sessionFactory != null && !sessionFactory.IsClosed) {
	    //sessionFactory.Close();
	    //   }
	}

	#endregion IDisposable Members
    }
}
