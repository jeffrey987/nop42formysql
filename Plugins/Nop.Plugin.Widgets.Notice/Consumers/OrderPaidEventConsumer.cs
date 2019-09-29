using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Nop.Core;
using Nop.Core.Domain.Customers;
using Nop.Core.Domain.Orders;
using Nop.Plugin.Widgets.Notification.Hubs;
using Nop.Plugin.Widgets.Notification.Services;
using Nop.Services.Configuration;
using Nop.Services.Customers;
using Nop.Services.Events;
using Nop.Services.Helpers;
using System;

namespace Nop.Plugin.Widgets.Notification.Consumers
{
    public partial class OrderPaidEventConsumer : IConsumer<OrderPaidEvent>
    {
        #region Fields

        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly ISettingService _settingService;
        private readonly IHubContext<NotificationHub, INotificationClient> _notificationHubContext;
        //private readonly IShortMessageService _workflowMessageService;
        private readonly ICustomerService _customerService;
        private readonly IDateTimeHelper _dateTimeHelper;
        private readonly IWorkContext _workContext;

        #endregion

        #region Ctor

        public OrderPaidEventConsumer(ISettingService settingService,
            IHttpContextAccessor httpContextAccessor,
            IHubContext<NotificationHub, INotificationClient> notificationHubContext,
            ICustomerService customerService,
            //IShortMessageService workflowMessageService,
            IDateTimeHelper dateTimeHelper,
            IWorkContext workContext)
        {
            _settingService = settingService;
            _httpContextAccessor = httpContextAccessor;
            _notificationHubContext = notificationHubContext;
            _customerService = customerService;
            //this._workflowMessageService = workflowMessageService;

            _dateTimeHelper = dateTimeHelper;
            _workContext = workContext;
        }

        #endregion

        #region Methods

        /// <summary>
        /// Handle shipping method deleted event
        /// </summary>
        /// <param name="eventMessage">Event message</param>
        public void HandleEvent(OrderPaidEvent eventMessage)
        {
            //var httpContext = _httpContextAccessor.HttpContext;
            //var user = httpContext.User;
            //_notificationHubContext.Clients.User(user.Identity.Name).SendAsync("OrderPaid", new { a ="a", b = "b"});

            //var customers = _customerService.GetAllCustomers(customerRoleIds: new[]
            //{
            //    _customerService.GetCustomerRoleBySystemName(NopCustomerDefaults.AdministratorsRoleName).Id
            //});
            //foreach (var admin in customers)
            //{
            //    var user = _notificationHubContext.Clients.User(admin.Username);
            //    if (user == null)
            //        user = _notificationHubContext.Clients.User(admin.Email);
            //    if (user != null)
            //    {
            //        user.ReceiveOrderPaidMessage(
            //            _customerService.GetCustomerFullName(_workContext.CurrentCustomer),
            //            new
            //            {
            //                role = "admin：订单已经付款啦",
            //                orderid = eventMessage.Order.Id,
            //                order = NotificationHelper.GetBody(eventMessage.Order),
            //                date = _dateTimeHelper.ConvertToUserTime(eventMessage.Order.PaidDateUtc.Value, DateTimeKind.Utc).ToString("yyyy-MM-hh HH:mm:ss"),
            //                customer = _customerService.GetCustomerFullName(_workContext.CurrentCustomer)
            //            });
            //    }
            //}

            _notificationHubContext.Clients.Group(NopCustomerDefaults.AdministratorsRoleName)
                .ReceiveOrderPaidMessage(
                    _customerService.GetCustomerFullName(_workContext.CurrentCustomer),
                    new
                    {
                        role = "admin：订单已经付款啦",
                        orderid = eventMessage.Order.Id,
                        order = NotificationHelper.GetBody(eventMessage.Order),
                        date = _dateTimeHelper.ConvertToUserTime(eventMessage.Order.PaidDateUtc.Value, DateTimeKind.Utc).ToString("yyyy-MM-hh HH:mm:ss"),
                        customer = _customerService.GetCustomerFullName(_workContext.CurrentCustomer)
                    }
                );

        }


        #endregion
    }
}
