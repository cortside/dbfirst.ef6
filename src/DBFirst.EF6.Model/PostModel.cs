using System;

using Spring2.DataTierGenerator.Attribute;
using System.Linq;


namespace DBFirst.EF6.Model
{
    public class PostModel
    {
        [Generate()]
        private Int32 postId = 0;
        [Generate()]
        private BlogModel blog = new BlogModel();
        [Generate()]
        private String title = null;
        [Generate()]
        private String content = null;
        [Generate()]
        private DateTime createDate = new DateTime();
        [Generate()]
        private Int32 createUserId = 0;
        [Generate()]
        private DateTime lastModifiedDate = new DateTime();
        [Generate()]
        private Int32 lastModifiedUserId = 0;

        [Generate()]
        public Int32 PostId
        {
            get { return this.postId; }
            set { this.postId = value; }
        }

        [Generate()]
        public BlogModel Blog
        {
            get { return this.blog; }
            set { this.blog = value; }
        }

        [Generate()]
        public String Title
        {
            get { return this.title; }
            set { this.title = value; }
        }

        [Generate()]
        public String Content
        {
            get { return this.content; }
            set { this.content = value; }
        }

        [Generate()]
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }

        [Generate()]
        public Int32 CreateUserId
        {
            get { return this.createUserId; }
            set { this.createUserId = value; }
        }

        [Generate()]
        public DateTime LastModifiedDate
        {
            get { return this.lastModifiedDate; }
            set { this.lastModifiedDate = value; }
        }

        [Generate()]
        public Int32 LastModifiedUserId
        {
            get { return this.lastModifiedUserId; }
            set { this.lastModifiedUserId = value; }
        }
    }
}
