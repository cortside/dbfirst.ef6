using KellermanSoftware.CompareNetObjects;
using System.Collections.Generic;

namespace DBFirst.EF6.Entity
{
    public abstract class BaseEntity
    {

        public virtual bool Compare(object obj)
        {
            return Compare(obj, false);
        }

        public virtual bool Compare(object obj, bool ignoreType)
        {
            return Compare(obj, ignoreType, new List<string>());
        }

        public virtual bool Compare(object obj, bool ignoreType, List<string> membersToIgnore)
        {
            var comparer = new CompareLogic();
            comparer.Config.IgnoreObjectTypes = ignoreType;

            if (membersToIgnore == null)
            {
                membersToIgnore = new List<string>();
            }
            membersToIgnore.Add("CreateDate");
            membersToIgnore.Add("CreateUserId");
            membersToIgnore.Add("LastModifiedDate");
            membersToIgnore.Add("LastModifiedUserId");
            comparer.Config.MembersToIgnore = membersToIgnore;

            var result = comparer.Compare(this, obj);
            return result.AreEqual;
        }
    }
}
