using System;

namespace DBFirst.EF6.Respository.Core {

    public static class UnitOfWork {

	[ThreadStatic]
	private static IUnitOfWork current;

	private static object lockObject;

	static UnitOfWork() {
	    lockObject = new object();
	}

	internal static void SetCurrent(IUnitOfWork unitOfWork) {
	    lock (lockObject) { current = unitOfWork; }
	}

	internal static void UnsetCurrent() {
	    lock (lockObject) { current = null; }
	}

	public static IUnitOfWork Current {
	    get { return current; }
	}
    }
}