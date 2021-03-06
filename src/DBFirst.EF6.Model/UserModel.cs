using System;

using Spring2.DataTierGenerator.Attribute;
using System.Linq;

namespace DBFirst.EF6.Model {
    public abstract class UserModel {
	[Generate()]
	private Int32 userId = 0;
	[Generate()]
	private String userStatus = null;
	[Generate()]
	private String username = null;
	[Generate()]
	private String password = null;
	[Generate()]
	private Int32 loginCount = 0;
	[Generate()]
	private Nullable<DateTime> lastLogin = null;
	[Generate()]
	private String lastLoginIPAddress = null;
	[Generate()]
	private DateTime effectiveDate = new DateTime();
	[Generate()]
	private Nullable<DateTime> expirationDate = null;
	[Generate()]
	private String securityToken = null;
	[Generate()]
	private Nullable<DateTime> tokenExpiration = null;
	[Generate()]
	private Nullable<DateTime> termsOfUseAcceptanceDate = null;
	[Generate()]
	private DateTime createDate = new DateTime();
	[Generate()]
	private Int32 createUserId = 0;
	[Generate()]
	private DateTime lastModifiedDate = new DateTime();
	[Generate()]
	private Int32 lastModifiedUserId = 0;

	[Generate()]
	public Int32 UserId {
	    get { return this.userId; }
	    set { this.userId = value; }
	}

	[Generate()]
	public String UserStatus {
	    get { return this.userStatus; }
	    set { this.userStatus = value; }
	}

	[Generate()]
	public String Username {
	    get { return this.username; }
	    set { this.username = value; }
	}

	[Generate()]
	public String Password {
	    get { return this.password; }
	    set { this.password = value; }
	}

	[Generate()]
	public Int32 LoginCount {
	    get { return this.loginCount; }
	    set { this.loginCount = value; }
	}

	[Generate()]
	public Nullable<DateTime> LastLogin {
	    get { return this.lastLogin; }
	    set { this.lastLogin = value; }
	}

	[Generate()]
	public String LastLoginIPAddress {
	    get { return this.lastLoginIPAddress; }
	    set { this.lastLoginIPAddress = value; }
	}

	[Generate()]
	public DateTime EffectiveDate {
	    get { return this.effectiveDate; }
	    set { this.effectiveDate = value; }
	}

	[Generate()]
	public Nullable<DateTime> ExpirationDate {
	    get { return this.expirationDate; }
	    set { this.expirationDate = value; }
	}

	[Generate()]
	public String SecurityToken {
	    get { return this.securityToken; }
	    set { this.securityToken = value; }
	}

	[Generate()]
	public Nullable<DateTime> TokenExpiration {
	    get { return this.tokenExpiration; }
	    set { this.tokenExpiration = value; }
	}

	[Generate()]
	public Nullable<DateTime> TermsOfUseAcceptanceDate {
	    get { return this.termsOfUseAcceptanceDate; }
	    set { this.termsOfUseAcceptanceDate = value; }
	}

	[Generate()]
	public DateTime CreateDate {
	    get { return this.createDate; }
	    set { this.createDate = value; }
	}

	[Generate()]
	public Int32 CreateUserId {
	    get { return this.createUserId; }
	    set { this.createUserId = value; }
	}

	[Generate()]
	public DateTime LastModifiedDate {
	    get { return this.lastModifiedDate; }
	    set { this.lastModifiedDate = value; }
	}

	[Generate()]
	public Int32 LastModifiedUserId {
	    get { return this.lastModifiedUserId; }
	    set { this.lastModifiedUserId = value; }
	}
    }
}
