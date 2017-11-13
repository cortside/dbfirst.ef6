using DBFirst.EF6.Data.EFRespository;
using DBFirst.EF6.DomainService;
using DBFirst.EF6.Entity;
using DBFirst.EF6.Respository.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBFirst.EF6.Facade
{
    public class ServiceFacade : IServiceFacade
    {
        private IUnitOfWorkFactory uowFactory;

        public ServiceFacade(IUnitOfWorkFactory factory)
        {
            this.uowFactory = factory;
        }

        public IEnumerable<Blog> GetBlogs()
        {
            using (IUnitOfWork uow = uowFactory.BeginUnitOfWork())
            {
                // TODO: IoC
                var service = new BlogService(new BlogRepository());
                return service.GetBlogs();
            }
        }

        public Blog CreateBlog(string name, string url)
        {
            using (IUnitOfWork uow = uowFactory.BeginUnitOfWork())
            {
                // TODO: IoC
                var service = new BlogService(new BlogRepository());

                var blog = service.CreateBlog(name, url);
                // TODO: until the UOW handles this
                blog.LastModifiedUserId = 1;
                blog.LastModifiedDate = DateTime.Now;
                blog.CreateUserId = 1;
                blog.CreateDate = DateTime.Now;

                uow.Commit();
                // TODO:
                //return assembler.FromDomainObject(order);
                return blog;
            }
        }

        //public OrderDTO CancelOrder(int merchantId, int orderId) {
        //    using (IUnitOfWork uow = uowFactory.BeginUnitOfWork()) {
        //	IOrderService service = dsFactory.GetOrderService();
        //	var assembler = dtoFactory.GetOrderDTOAssembler();
        //	Order order = service.CancelOrderWithResult(merchantId, orderId);
        //	uow.Commit();
        //	return assembler.FromDomainObject(order);
        //    }
        //}

        //public void UpdateOrderShippingInfo(OrderDTO orderDTO) {
        //    using (IUnitOfWork uow = uowFactory.BeginUnitOfWork()) {
        //	IOrderService service = dsFactory.GetOrderService();
        //	service.UpdateOrderShippingInfo(orderDTO);
        //	uow.Commit();
        //    }
        //}
    }
}
