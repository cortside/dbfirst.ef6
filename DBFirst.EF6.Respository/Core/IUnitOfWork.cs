using System;
using System.Data;

namespace DBFirst.EF6.Respository.Core {

    public interface IUnitOfWork : IDisposable {

	/// <summary>
	/// Begins a new transaction.
	/// </summary>
	/// <param name="isolationLevel">The isolation level.</param>
	/// <returns></returns>
	ITransaction BeginTransaction(IsolationLevel isolationLevel = IsolationLevel.ReadUncommitted, bool autoFlush = true);

	/// <summary>
	/// Commits the current set of data to the persistance layer.
	/// Will not create an new implicit transaction unless the UnitOfWork was created with an implicit transaction, and [newImplicitTransaction] is set to true.
	/// </summary>
	/// <param name="newImplicitTransaction">If set to <c>true</c>, a [new implicit transaction] will be create. Defaults to false.</param>
	void Commit(bool newImplicitTransaction = false);

	/// <summary>
	/// Gets a value indicating whether this instance is in transaction.
	/// </summary>
	/// <value>
	/// 	<c>true</c> if this instance is in transaction; otherwise, <c>false</c>.
	/// </value>
	bool IsInTransaction { get; }

	void Flush();

	void Attach(Object entity);

	ITransaction CurrentTransaction { get; }
    }
}